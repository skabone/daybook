# Daybook — Pencil Me In

A day planner that lives in **one HTML file**. No accounts, no backend, no build step, no tracking — open it and plan your day. Works offline, and your data never leaves your own storage.

**Try it:** https://skabone.github.io/daybook/

## Features

- **Today view** — a focused daily page: top priorities, a master task list, Morning / Afternoon / Evening blocks, an Anytime list, Someday parking lot, habits, and daily notes. Every section is collapsible.
- **Natural-language capture** — type `Call the bank tomorrow @errands @morning` and it lands on the right day, block, and project. `@project` and `@time` tags work in every input.
- **Subtasks** — break any task into a checklist with progress shown at a glance.
- **Drag & drop everywhere** — reorder lists, or drag a task onto the drop dock to move it to a time block, another date, Someday, or a different project.
- **Day-by-day history** — flip back through any previous day to see what was completed, plus a running completed log and a carried-over panel for anything that slipped.
- **Task rollover** — unfinished tasks follow you to today automatically, marked with how long they've been carried.
- **Projects, milestones & phases** — kanban-style project cards, a color-coded calendar (month / week / work-week / 3-day / year), and a zoomable timeline (months / weeks / days).
- **Recurring tasks** — daily, weekly by weekday, or every N days.
- **People / follow-ups** — lightweight CRM for staying in touch on a cadence.
- **Habits & streaks** — daily habit dots with streak tracking.
- **Smart suggestions** — local, explainable nudges from your own patterns (aged tasks, quiet projects, weekday routines). No AI calls, nothing sent anywhere.
- **Calendar import** — subscribe to iCal/webcal feeds or import `.ics` files.
- **Light/dark themes** with several color skins and a print-friendly layout.

## Where your data lives

Everything is stored in your browser's `localStorage`. The site itself stores nothing and has no server. Three ways to move or protect your data:

1. **Export / Import** — one-click JSON backup.
2. **Sync file** — auto-save to a local file (Chrome/Edge), handy with a synced drive folder.
3. **Cloud sync (optional)** — connect a GitHub personal access token (gist scope only) and Daybook auto-saves to a secret gist on *your* account, so you can pick up on any browser or computer. The token never leaves your browser and is never included in exports.

## Run it yourself

Download `index.html` and double-click it — that's the whole install. Or fork this repo and enable GitHub Pages to host your own copy.

## License

**Free for personal & noncommercial use · created by Mintay Misgano · commercial use by permission.**

Daybook is licensed under the [PolyForm Noncommercial License 1.0.0](LICENSE):

- ✅ Use it, change it, and share it freely for any **noncommercial** purpose.
- 🏷️ Keep the credit — every shared copy or derivative must retain the notice
  `Required Notice: Copyright (c) 2026 Mintay Misgano (https://github.com/skabone)`.
- 💼 **Commercial use** (selling it, paid products/services built on it, etc.) requires written permission — [open an issue](https://github.com/skabone/daybook/issues) to ask.
- 💌 Building something on top of it? A heads-up is appreciated.
