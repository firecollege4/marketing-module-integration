export const inr = (value: number | null | undefined) =>
  new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency: "INR",
    maximumFractionDigits: 0,
  }).format(Number(value ?? 0));

export const compactInr = (value: number | null | undefined) => {
  const n = Number(value ?? 0);
  if (n >= 10000000) return `₹${(n / 10000000).toFixed(2)} Cr`;
  if (n >= 100000) return `₹${(n / 100000).toFixed(2)} L`;
  if (n >= 1000) return `₹${(n / 1000).toFixed(1)}K`;
  return `₹${n.toFixed(0)}`;
};

export const num = (value: number | null | undefined) =>
  new Intl.NumberFormat("en-IN").format(Number(value ?? 0));

export const compactNum = (value: number | null | undefined) => {
  const n = Number(value ?? 0);
  if (n >= 10000000) return `${(n / 10000000).toFixed(2)}Cr`;
  if (n >= 100000) return `${(n / 100000).toFixed(2)}L`;
  if (n >= 1000) return `${(n / 1000).toFixed(1)}K`;
  return `${n}`;
};

export const pct = (value: number | null | undefined, digits = 1) =>
  `${Number(value ?? 0).toFixed(digits)}%`;

export const shortDate = (value: string | null | undefined) =>
  value
    ? new Date(value).toLocaleDateString("en-IN", {
        day: "2-digit",
        month: "short",
        year: "numeric",
      })
    : "—";

export const dateTime = (value: string | null | undefined) =>
  value
    ? new Date(value).toLocaleString("en-IN", {
        day: "2-digit",
        month: "short",
        hour: "2-digit",
        minute: "2-digit",
      })
    : "—";

export const titleCase = (value: string | null | undefined) =>
  (value ?? "")
    .replace(/[_-]/g, " ")
    .replace(/\b\w/g, (c) => c.toUpperCase())
    .trim();

export const ctr = (clicks: number, impressions: number) =>
  impressions > 0 ? (clicks / impressions) * 100 : 0;

export const roas = (revenue: number, spend: number) => (spend > 0 ? revenue / spend : 0);

export const cpl = (spend: number, leads: number) => (leads > 0 ? spend / leads : 0);
