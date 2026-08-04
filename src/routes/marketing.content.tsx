import { createFileRoute } from "@tanstack/react-router";
import { CalendarClock, FileText, PenLine, Send } from "lucide-react";

import { DataScreen } from "@/components/marketing/data-screen";
import { StatusBadge } from "@/components/marketing/kit";
import { dateTime, num, titleCase } from "@/lib/marketing/format";

export const Route = createFileRoute("/marketing/content")({
  head: () => ({
    meta: [
      { title: "Content Library — Software Vala Marketing Manager" },
      {
        name: "description",
        content:
          "Plan, write and schedule blogs, landing pages, emails and social copy across every marketing channel.",
      },
      { property: "og:title", content: "Content Library — Software Vala" },
      {
        property: "og:description",
        content: "Editorial calendar and content pipeline with live scheduling and status tracking.",
      },
    ],
  }),
  component: ContentScreen,
});

const CONTENT_TYPES = [
  "blog",
  "landing_page",
  "email",
  "social_post",
  "case_study",
  "whitepaper",
  "video_script",
  "ad_copy",
] as const;
const CHANNELS = [
  "Website",
  "Blog",
  "Email",
  "Instagram",
  "LinkedIn",
  "YouTube",
  "WhatsApp",
  "SMS",
] as const;
const STATUSES = ["idea", "draft", "in_review", "approved", "scheduled", "published", "archived"] as const;

function ContentScreen() {
  return (
    <DataScreen
      table="marketing_content_items"
      title="Content Library"
      description="Editorial pipeline from idea to published, with scheduling and channel routing."
      module="Content"
      entityLabel="Content item"
      order={{ column: "created_at" }}
      searchKeys={["title", "content_type", "channel", "author"]}
      filterKey="status"
      filterOptions={STATUSES}
      minWidth={1080}
      stats={[
        { label: "Total pieces", icon: FileText, tone: "violet", value: (r) => num(r.length) },
        {
          label: "Published",
          icon: Send,
          tone: "green",
          value: (r) => num(r.filter((x) => x.status === "published").length),
        },
        {
          label: "Scheduled",
          icon: CalendarClock,
          tone: "blue",
          value: (r) => num(r.filter((x) => x.status === "scheduled").length),
        },
        {
          label: "Words written",
          icon: PenLine,
          tone: "gold",
          value: (r) => num(r.reduce((s, x) => s + Number(x.word_count ?? 0), 0)),
        },
      ]}
      columns={[
        { key: "title", header: "Title", render: (r) => <span className="font-medium">{r.title}</span> },
        { key: "content_type", header: "Type", render: (r) => titleCase(r.content_type) },
        { key: "channel", header: "Channel", render: (r) => r.channel },
        { key: "status", header: "Status", render: (r) => <StatusBadge value={r.status} /> },
        { key: "author", header: "Author", render: (r) => r.author ?? "—" },
        {
          key: "word_count",
          header: "Words",
          align: "right",
          render: (r) => num(r.word_count),
        },
        { key: "tags", header: "Tags", render: (r) => (r.tags?.length ? r.tags.join(", ") : "—") },
        { key: "scheduled_for", header: "Scheduled", render: (r) => dateTime(r.scheduled_for) },
      ]}
      fields={[
        { key: "title", label: "Title", kind: "text", required: true, full: true },
        { key: "content_type", label: "Content type", kind: "select", options: CONTENT_TYPES },
        { key: "channel", label: "Channel", kind: "select", options: CHANNELS },
        { key: "status", label: "Status", kind: "select", options: STATUSES },
        { key: "author", label: "Author", kind: "text" },
        { key: "word_count", label: "Word count", kind: "number" },
        { key: "scheduled_for", label: "Scheduled for", kind: "datetime" },
        { key: "tags", label: "Tags", kind: "tags", full: true },
        { key: "body", label: "Body", kind: "textarea", full: true },
      ]}
    />
  );
}
