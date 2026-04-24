---
description: "Get the result of a completed pi task. Use after /pi:status shows a task is completed."
argument-hint: "<task-id>"
---

# /pi:result

Retrieve and present the result of a completed pi task.

## Steps

1. Run:
   ```bash
   pi-cc result $ARGUMENTS
   ```

2. Parse the JSONL output: extract assistant text from `agent_end` event.
3. Present the result in conversation with usage info.
4. If the task is still running, tell the user to wait or check `/pi:status`.
