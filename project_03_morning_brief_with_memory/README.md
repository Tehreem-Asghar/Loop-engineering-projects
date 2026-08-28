# The Morning Brief (with a Memory)

A small scheduled loop that gives you a daily digest of your project — and
*remembers* what it already told you, so it never repeats itself.

- **Difficulty:** medium
- **Concepts used:**
  - **Concept 6 — Unattended schedule:** the brief is meant to run on its own
    (e.g. once a day via cron) without you watching it.
  - **Concept 12 — The spine:** a persistent memory file (`progress.md`) that
    every run reads *before* it does anything and writes *after* it finishes.

---

## What it does

Each run:

1. **Reads its memory** — opens `progress.md` to see what it already reported.
2. **Scans the repo** — greps every `.py` file for open `TODO` comments.
3. **Compares** — only flags TODOs that are *new* since the last run; skips
   anything already recorded.
4. **Reports** — tells you how many TODOs exist, which are new, which are known.
5. **Updates memory** — rewrites `progress.md` with today's date and the
   current findings, so the next run has a baseline to build on.

The "something simple from the repo" this project gathers is **open TODO
comments**. (You could swap in last day's commits, open issues, etc. — the
spine is the same.)

---

## Files

| File | Purpose |
|------|---------|
| `progress.md` | The memory / spine. What was found, last run date, done items. |
| `app.py` | Sample app code containing TODO comments to be found. |
| `database.py` | Sample DB code containing TODO comments to be found. |
| `.claude/skills/morning-brief/SKILL.md` | The skill that defines the 5-step loop. |

---

## How to run

Invoke the skill from the project root:

```
/morning-brief
```

or just ask Claude to *"run the morning-brief skill."* It will read
`progress.md`, scan the `.py` files, and update `progress.md` in place.

To make it truly unattended (Concept 6), schedule it — e.g. with cron:

```cron
0 8 * * *  cd "/path/to/project_03_morning_brief_with_memory" && claude -p "run the morning-brief skill"
```

---

## How you know the spine works

> **Done when you run it twice and the second run clearly builds on the first,
> meaning it does not repeat what it already recorded. That proves your spine
> works. If the second run starts from nothing, your loop has no memory yet.**

This project already demonstrates that:

- **Run 1 (first run):** found 3 TODOs, all new (memory was empty).
- **Run 2:** found the same 3, reported **0 new / 3 known** — it read the
  memory and did *not* re-report old findings.
- **Run 3:** a 4th TODO had been added; reported **1 new / 3 known** — it
  built on the previous runs instead of starting blank.

Because Run 2 and Run 3 leaned on `progress.md` instead of starting from
nothing, the memory spine is proven to work.
