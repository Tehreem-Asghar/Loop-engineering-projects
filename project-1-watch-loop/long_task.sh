#!/bin/bash
echo "Task has started..."
sleep 120        # wait for 2 minutes (this simulates a long running task)
echo "Task finished!" > task_done.txt
echo "File written: task_done.txt"