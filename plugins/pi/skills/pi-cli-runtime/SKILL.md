---
name: pi-cli-runtime
description: "Core skill for running pi coding agent from Claude Code. Use pi-cc CLI wrapper to execute pi in non-interactive mode. All pi commands and agents MUST use this skill for pi invocation. Triggers when any /pi: command runs or when routing a task to pi."
---

# Pi CLI Runtime

Execute pi coding agent via the `pi-cc` wrapper. This is the single entry point for all pi invocations.

## Quick Reference

```bash
# Single-shot (foreground, blocks until done)
pi-cc run "your prompt here"

# Background (returns task-id immediately, pi runs detached)
pi-cc run "your prompt here" --bg

# Check status / get result / cancel
pi-cc status [task-id]
pi-cc result <task-id>
pi-cc cancel <task-id>

# Token usage
pi-cc usage statusline    # pi:i4.3k/o14
pi-cc usage json           # full JSON

# Health check
pi-cc check
```

## Choosing foreground vs background

| Use case | Mode | Why |
|----------|------|-----|
| `/pi:review`, `/pi:ask` | foreground | Quick, user waits for result |
| `/pi:rescue`, `/pi:super-pr` | `--bg` | Long-running, session-independent |
| `/pi:explore`, `/pi:test` | foreground or `--bg` | Depends on scope |
| `/pi:brainstorm` | foreground | Usually fast |
| `/pi:cross-verify` | foreground | User wants immediate feedback |

## Pi output format

Pi outputs JSONL with `--mode json`. Key events:
- `{"type":"agent_end","messages":[...]}` — final result with all messages and usage
- Each message has `content[].text` for the text response
- `usage` contains `input`, `output`, `totalTokens`, `cost`

## Extracting the answer

```bash
# Get the assistant's text response from pi output
pi-cc run "prompt" | grep '"type":"agent_end"' | python3 -c "
import sys, json
for line in sys.stdin:
    data = json.loads(line)
    for msg in data.get('messages', []):
        if msg.get('role') == 'assistant':
            for c in msg.get('content', []):
                if c.get('type') == 'text':
                    print(c['text'])
"
```

## Environment variables

- `PI_CC_MODEL` — default model (e.g., `google/gemini-2.5-pro`)
- `PI_CC_THINKING` — default thinking level (off/minimal/low/medium/high/xhigh)
- `PI_CC_TIMEOUT` — timeout seconds (default 300)
- `PI_CC_MAX_CONCURRENT` — max parallel pi processes (default 5)

## Error handling

- If `pi-cc check` fails → tell user to install pi
- If pi times out → report partial results if available
- If pi exits non-zero → check stderr.log in task dir
- Always return something to the caller, even on failure
