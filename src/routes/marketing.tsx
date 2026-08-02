import { createFileRoute, Link, Outlet, useRouterState } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { Activity, Bell } from "lucide-react";

import { marketingNav } from "@/components/marketing/nav";
import { StatusBadge } from "@/components/marketing/kit";
import { Toaster } from "@/components/ui/sonner";
import { tableQuery } from "@/lib/marketing/api";
import { cn } from "@/lib/utils";

export const Route = createFileRoute("/marketing")({
  component: MarketingLayout,
});

function MarketingLayout() {
  const pathname = useRouterState({ select: (s) => s.location.pathname });
  const alerts = useQuery(tableQuery("marketing_alerts", { column: "created_at" }));

  const openAlerts = (alerts.data ?? []).filter((a) => a.status === "open");
  const critical = openAlerts.some((a) => a.severity === "critical");
  const health = critical ? "critical" : openAlerts.length > 0 ? "warning" : "active";
  const active = marketingNav.find((item) => item.to === pathname) ?? marketingNav[0];

  return (
    <div className="flex min-h-screen bg-background text-foreground">
      <aside className="fixed hidden h-screen w-64 flex-col border-r border-sidebar-border bg-sidebar lg:flex">
        <div className="border-b border-sidebar-border p-4">
          <p className="text-xs uppercase tracking-widest text-muted-foreground">Software Vala</p>
          <h1 className="mt-1 text-lg font-bold text-gradient-aurora">Marketing Manager</h1>
          <p className="text-xs text-muted-foreground">Campaign Control Centre</p>
        </div>

        <nav className="flex-1 space-y-1 overflow-y-auto p-3">
          {marketingNav.map((item) => {
            const isActive = pathname === item.to;
            return (
              <Link
                key={item.to}
                to={item.to}
                className={cn(
                  "flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors",
                  isActive
                    ? "bg-primary text-primary-foreground shadow-[var(--shadow-glow)]"
                    : "text-sidebar-foreground/80 hover:bg-sidebar-accent hover:text-sidebar-accent-foreground",
                )}
              >
                <item.icon className="h-4.5 w-4.5 shrink-0" />
                <span className="truncate">{item.label}</span>
              </Link>
            );
          })}
        </nav>

        <div className="border-t border-sidebar-border p-4">
          <div className="flex items-center justify-between text-xs">
            <span className="flex items-center gap-2 text-muted-foreground">
              <Activity className="h-3.5 w-3.5" /> Campaign health
            </span>
            <StatusBadge value={health} />
          </div>
        </div>
      </aside>

      <div className="flex min-w-0 flex-1 flex-col lg:ml-64">
        <header className="sticky top-0 z-20 flex items-center justify-between gap-4 border-b border-border/60 bg-background/80 px-5 py-3 backdrop-blur-xl">
          <div className="min-w-0">
            <p className="text-xs text-muted-foreground">Marketing Manager</p>
            <p className="truncate text-sm font-semibold">{active?.label}</p>
          </div>
          <div className="flex items-center gap-3">
            <span className="relative rounded-lg border border-border/60 p-2">
              <Bell className="h-4 w-4 text-muted-foreground" />
              {openAlerts.length > 0 ? (
                <span className="absolute -right-1 -top-1 flex h-4 min-w-4 items-center justify-center rounded-full bg-destructive px-1 text-[10px] font-semibold text-destructive-foreground">
                  {openAlerts.length}
                </span>
              ) : null}
            </span>
          </div>
        </header>

        <nav className="flex gap-2 overflow-x-auto border-b border-border/60 px-4 py-2 lg:hidden">
          {marketingNav.map((item) => (
            <Link
              key={item.to}
              to={item.to}
              className={cn(
                "whitespace-nowrap rounded-full px-3 py-1.5 text-xs font-medium",
                pathname === item.to
                  ? "bg-primary text-primary-foreground"
                  : "bg-secondary text-secondary-foreground",
              )}
            >
              {item.label}
            </Link>
          ))}
        </nav>

        <main className="flex-1 space-y-6 p-5">
          <Outlet />
        </main>
      </div>

      <Toaster />
    </div>
  );
}
