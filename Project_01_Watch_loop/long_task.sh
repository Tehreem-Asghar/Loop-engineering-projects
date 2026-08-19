#!/usr/bin/env bash
set -euo pipefail

REPO="/mnt/d/marathone/loop engineering projects/Project_01_Watch_loop"
SLEEP_SECONDS="${SLEEP_SECONDS:-120}"   # default 2 min; override via env if needed

echo "Long task started, will finish in ~${SLEEP_SECONDS}s" >&2
sleep "$SLEEP_SECONDS"
echo "Job finished at $(date)" > "$REPO/result.txt"
echo "Long task done -> wrote result.txt" >&2
