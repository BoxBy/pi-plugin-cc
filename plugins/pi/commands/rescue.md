---
description: "Delegate a task to pi. Pi executes independently with full tool access (read, write, bash, edit), then returns results. Use for independent coding tasks you want to offload."
argument-hint: "<task description> [--model <model>] [--background] [--wait]"
---

# /pi:rescue

Delegate a coding task to pi.

## Steps

1. Extract task description from $ARGUMENTS.

2. Run pi with full tool access:
   ```bash
   pi-cc run "$TASK_DESCRIPTION" $(if BACKGROUND: --bg) $(if MODEL: --model $MODEL)
   ```

3. If `--background` (default for rescue): report task ID.
4. If `--wait`: block until done, present results.
5. When result is ready, review pi's work before presenting to user. Note any concerns.
