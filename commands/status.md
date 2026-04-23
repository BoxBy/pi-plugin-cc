---
description: "Show running and recent pi tasks. Use to check on background pi executions."
argument-hint: "[task-id]"
---

# /pi:status

Show status of pi tasks.

## Steps

1. Run:
   ```bash
   pi-cc status $ARGUMENTS
   ```

2. If task-id provided: show detailed status for that task.
3. If no task-id: show all tasks with their status (running/completed/failed/queued/cancelled).
4. For running tasks, note how long they've been running.
