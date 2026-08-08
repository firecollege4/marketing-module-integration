# Marketing Manager browser tests

## Clickable images regression test

`clickable_images.py` opens all 17 Marketing Manager routes in headless Chromium
and verifies that every interactive image, image-button, thumbnail and icon
control is still clickable:

- the interactive trigger (and its ancestors) is not `pointer-events: none`,
  hidden or display-none
- the image's centre point hit-tests back to itself or its trigger (nothing
  overlays it)
- a real click on an image-button on the Creatives screen is not intercepted

An icon with `pointer-events: none` *inside* a button is expected (shadcn sets
this) and is not a failure, as long as the button itself receives the click.

Run against the dev server:

```bash
python tests/e2e/clickable_images.py            # http://localhost:8080
python tests/e2e/clickable_images.py <base_url> # any other origin
```

Exit code is non-zero on failure; screenshots of failing routes land in
`tests/e2e/screenshots/`.
