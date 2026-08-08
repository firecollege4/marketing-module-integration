"""
Automated browser test: every clickable image, image-button and thumbnail
must stay clickable (hit-testable) on every Marketing Manager screen.

Run:  python tests/e2e/clickable_images.py [base_url]
Default base_url: http://localhost:8080
Exits non-zero if any interactive image is blocked.
"""

import asyncio
import sys
from pathlib import Path

from playwright.async_api import async_playwright

BASE_URL = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:8080"

ROUTES = [
    "/marketing",
    "/marketing/campaigns",
    "/marketing/campaign-builder",
    "/marketing/hierarchy",
    "/marketing/seo",
    "/marketing/lead-sources",
    "/marketing/content",
    "/marketing/creatives",
    "/marketing/offers",
    "/marketing/targeting",
    "/marketing/schedules",
    "/marketing/performance",
    "/marketing/analytics",
    "/marketing/ai-automation",
    "/marketing/approvals",
    "/marketing/reports",
    "/marketing/audit",
]

SCREENSHOTS = Path(__file__).parent / "screenshots"

# Runs in the page. Collects every <img>, <svg>, and role=img that either is
# interactive itself or sits inside an interactive ancestor (button, link,
# [role=button], [onclick], .cursor-pointer), then checks that:
#   1. the interactive trigger and its ancestors are not pointer-events:none/hidden
#      (an icon with pointer-events:none inside a button is expected and fine)
#   2. the image's centre point hit-tests back to itself or its interactive trigger
COLLECT = """
() => {
  const INTERACTIVE = 'a,button,[role="button"],[role="link"],[role="tab"],[onclick],label,summary,.cursor-pointer';
  const nodes = Array.from(document.querySelectorAll('img, svg, [role="img"], picture, canvas'));
  const results = [];
  for (const el of nodes) {
    const trigger = el.closest(INTERACTIVE);
    const isInteractive = !!trigger;
    if (!isInteractive) continue;

    const rect = el.getBoundingClientRect();
    if (rect.width === 0 || rect.height === 0) continue;
    if (rect.bottom < 0 || rect.top > window.innerHeight) continue;

    // pointer-events chain, checked from the interactive trigger upwards.
    // An icon with pointer-events:none inside a button is fine (shadcn does this
    // on purpose) as long as the button itself still receives the click.
    let blockedBy = null;
    for (let n = trigger; n && n !== document.documentElement; n = n.parentElement) {
      const cs = getComputedStyle(n);
      if (cs.pointerEvents === 'none' || cs.visibility === 'hidden' || cs.display === 'none') {
        blockedBy = n.tagName.toLowerCase() + (typeof n.className === 'string' && n.className ? '.' + n.className.split(' ').filter(Boolean).slice(0,2).join('.') : '');
        break;
      }
    }

    // hit-test the centre point
    const x = Math.min(Math.max(rect.left + rect.width / 2, 1), window.innerWidth - 1);
    const y = Math.min(Math.max(rect.top + rect.height / 2, 1), window.innerHeight - 1);
    const hit = document.elementFromPoint(x, y);
    const hitOk = !!hit && (hit === el || el.contains(hit) || trigger.contains(hit) || hit.contains(el));

    results.push({
      tag: el.tagName.toLowerCase(),
      label: (trigger.getAttribute('aria-label') || trigger.textContent || el.getAttribute('alt') || '').trim().slice(0, 60),
      trigger: trigger.tagName.toLowerCase(),
      blockedBy,
      hitOk,
      hitTag: hit ? hit.tagName.toLowerCase() : null,
    });
  }
  return results;
}
"""


async def main() -> int:
    SCREENSHOTS.mkdir(parents=True, exist_ok=True)
    failures: list[str] = []
    total = 0

    async with async_playwright() as pw:
        browser = await pw.chromium.launch(headless=True)
        context = await browser.new_context(viewport={"width": 1280, "height": 1800})
        page = await context.new_page()
        console_errors: list[str] = []
        page.on("console", lambda m: m.type == "error" and console_errors.append(m.text))

        for route in ROUTES:
            await page.goto(f"{BASE_URL}{route}", wait_until="domcontentloaded")
            try:
                await page.wait_for_load_state("networkidle", timeout=10_000)
            except Exception:
                pass
            await page.wait_for_timeout(400)

            items = await page.evaluate(COLLECT)
            total += len(items)
            bad = [i for i in items if i["blockedBy"] or not i["hitOk"]]
            for b in bad:
                reason = (
                    f"pointer-events:none via <{b['blockedBy']}>"
                    if b["blockedBy"]
                    else f"click intercepted by <{b['hitTag']}>"
                )
                failures.append(f"{route}: {b['tag']} in <{b['trigger']}> \"{b['label']}\" — {reason}")

            status = "FAIL" if bad else "ok"
            print(f"[{status}] {route}: {len(items)} interactive image(s), {len(bad)} blocked")
            if bad:
                await page.screenshot(path=str(SCREENSHOTS / f"blocked{route.replace('/', '_')}.png"))

        # Real click smoke test: click the first interactive image-bearing control
        # on the Creatives screen and assert the page reacts (no interception error).
        await page.goto(f"{BASE_URL}/marketing/creatives", wait_until="domcontentloaded")
        await page.wait_for_timeout(800)
        candidate = page.locator(
            'button:has(svg), a:has(svg), [role="button"]:has(svg)'
        ).first
        if await candidate.count():
            try:
                await candidate.click(timeout=4000)
            except Exception as exc:  # pragma: no cover - reported as failure
                failures.append(f"/marketing/creatives: real click on image-button failed — {exc}")

        await browser.close()

    print(f"\nChecked {total} interactive images/thumbnails across {len(ROUTES)} routes.")
    if console_errors:
        print(f"Console errors observed: {len(console_errors)}")
        for e in console_errors[:5]:
            print("  -", e)
    if failures:
        print(f"\n{len(failures)} FAILURE(S):")
        for f in failures:
            print("  -", f)
        return 1
    print("PASS: all clickable images, image-buttons and thumbnails are hit-testable.")
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
