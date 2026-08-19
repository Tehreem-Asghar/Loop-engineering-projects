# Project 01 — Watch Loop (in-session loop)

## What this project is

A demo of an **in-session loop** (Concept 4). A long task runs in the background,
and we set up a loop that **checks every minute** whether the task has finished —
and the moment it has, it tells you **once**. The point: you never have to sit and
watch the terminal; the loop does the watching for you.

> "Done" criteria: the loop notices the task finished, says so **once**, you can
> stop it **cleanly**, and you never sat watching the terminal.

## Files

| File | Purpose |
|------|---------|
| `long_task.sh` | The long task — sleeps (default 90s) then writes `result.txt` |
| `result.txt` | The "task finished" signal, written by the task itself |
| `announced.txt` | Sentinel file — guarantees "DONE" is announced only **once** |
| `task.log` | Task output (stdout/stderr) |
| `readme.md` | This file |

## How it works

1. `long_task.sh` starts in the background and "works" for a while (sleep), then
   writes `result.txt` and exits.
2. A `/loop 1m` (every-minute) watch loop is scheduled. Each tick it checks:
   - `result.txt` **missing** → `⏳ still running` (stay quiet)
   - `result.txt` present but `announced.txt` **missing** → print `✅ DONE` and
     create `announced.txt` (so it won't repeat)
   - both present → print nothing (silent)
3. When the task finishes, the next 1-minute tick catches `result.txt` and
   announces `✅ DONE` — **exactly once**.

## Run it yourself

```bash
# 1) Start the long task (adjust duration; default 90s)
SLEEP_SECONDS=120 nohup bash long_task.sh > task.log 2>&1 &

# 2) Start the watch loop (checks every minute)
/loop 1m Check repo '<repo path>'. If result.txt missing -> 'still running'. \
If result.txt exists but announced.txt missing -> print 'DONE' + touch announced.txt. \
If both exist -> silent.

# 3) When DONE appears, stop the loop cleanly:
/loop          # toggle off
# or
CronDelete <job-id>
```

To just list running loops (without scheduling): `CronList`.

## Clean stop

The loop runs via the `/loop` skill (backed by `CronCreate`). To stop it:
- run `/loop` again (toggles off), or
- `CronDelete <job-id>` to cancel.

The loop used in this project was **session-only** — it dies when Claude exits and
auto-expires after 7 days.

## Verification (what actually happened here)

- First check: `⏳ still running` ✓
- Task finished → next check: `✅ DONE — Job finished at ...` ✓ (once)
- Second check: silent ✓ (did not repeat)
- Loop stopped cleanly via `CronDelete` ✓
- Final state: `result.txt` + `announced.txt` both present, no orphan loop.

## Notes

- Change task duration with the `SLEEP_SECONDS` env var (use a small value like
  `SLEEP_SECONDS=30` for quick testing).
- This demo uses a simple `sleep`. In practice you can monitor any real task
  (file processing, build, download) with the same loop — just change the
  condition that writes `result.txt`.
