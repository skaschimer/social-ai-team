---
name: weekly-content-run
version: 1.0.0
description: Weekly Content Run. The unattended weekly routine — ingests new ideas from Notion, keeps the Posting Calendar filled two weeks ahead, drafts next week's posts into Notion for review, and reports what needs the operator's attention. Never publishes. Designed to be fired by a scheduled cloud Routine; also safe to run by hand.
---

# Weekly Content Run

You are the social media manager doing the Monday prep. You work through four steps in order, unattended, and finish with a short report. You never publish, never approve, and never touch rows the operator has approved or posted.

Read `CLAUDE.md` first — it holds the Notion IDs, cadence, editorial rules and brand voice.

If the Notion connector is unavailable, stop immediately and report: "Weekly run skipped — Notion connector not available to this session."

---

## Step 1 — Intake

Run `/idea-intake` in unattended mode (write creates and non-destructive updates without asking).

## Step 2 — Fill the calendar (rolling two weeks)

1. Query Posting Calendar for rows with Publish Date from today through today + 14 days.
2. For each platform in the cadence table, list the slots that should exist (default days) and are missing.
3. Fill missing slots with `/content-calendar` rules:
   - Pick Ready ideas by Priority, follow the editorial rhythm, skip `Parked`, respect "hold until" notes.
   - Don't repeat the same idea on the same platform within 30 days.
   - DEV Community slot in a week → schedule that idea's LinkedIn + Threads companions the same week.
   - Facebook gets the most accessible idea of the week, not the most technical.
4. Create rows with Status `Planned`, Pillar, Format, Hook (angle), and the `Idea` relation. Set newly used ideas to `Scheduled`.
5. If there are not enough Ready ideas, leave slots empty and say so in the report (never invent filler topics, and never promote `New` ideas to `Ready` yourself — list candidates for the operator instead).

## Step 3 — Draft next week

For every row with Publish Date in the next 7 days and Status `Planned`:

- LinkedIn → `/linkedin-writer`; Threads → `/threads-writer`; Facebook → `/caption-writer` (Facebook format); DEV Community → `/devto-writer`.
- Writers follow Notion mode in `CLAUDE.md`: draft into the row's page body, fill Hook/CTA/Char Count/Visual Direction, set Status `Needs review`.
- Unattended: skip the writers' confirmation pauses; apply all their quality checks (char limits, no fabricated stats, `[NEEDS SOURCE]` markers).
- Cap the run at 12 drafts; leave the rest `Planned` and mention it.

## Step 4 — Report

Finish with this report (it is what the operator reads in the session / notification):

```
Weekly content run — [date]

Ideas: +[n] new, [n] updated, [n] Ready in backlog
Calendar (next 14 days): [n] slots filled / [n] expected — gaps: [platform/date list or "none"]
Drafted for review: [n]
  - [date] [platform] — [post title]   (Notion link)
Needs your attention:
  - [n] drafts in "Needs review"
  - [n] rows past their date still not marked Posted/Skipped
  - New ideas that look ready — mark them Ready in Content Ideas if you want them scheduled: [titles]
  - [any NEEDS SOURCE / RESULT markers, low Ready-idea backlog, schema drift]
```

Do not commit anything to git. All state lives in Notion.
