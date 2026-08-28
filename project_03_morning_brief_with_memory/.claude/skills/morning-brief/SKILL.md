---
name: morning-brief
description: >-
  Reads progress.md to see what was found before. Then scans all Python 
  files for TODO comments. Compares with last run — only reports NEW 
  findings. Updates progress.md with today's date and findings.
---

# Morning Brief Skill

Do these steps in order:

## Step 1 — Read Your Memory
Open progress.md. Read "What Was Found" section carefully.
This is what you already reported — do NOT repeat it.

## Step 2 — Scan The Repo
Run this command to find all TODO comments in Python files:
grep -rn "TODO" --include="*.py" .

## Step 3 — Compare
Compare what you found NOW with what was in progress.md.
- Already reported before = skip it
- New finding = report it

## Step 4 — Write Your Brief
Tell the user:
- How many TODOs exist total
- Which ones are NEW since last run
- Which ones were already known

## Step 5 — Update Memory
Update progress.md:
- Today's date and what was found in "Last Run"
- All current TODOs in "What Was Found"
- Move completed items to "Done" if any were fixed

Always update progress.md before finishing.
