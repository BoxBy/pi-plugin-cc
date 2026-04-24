---
name: pi-result-handling
description: "Parse pi JSON output and inject results into Claude Code conversation. Use after pi-cc completes a task to extract the assistant response, tool results, and usage data."
---

# Pi Result Handling

Parse pi's JSONL output into a clean format for Claude Code conversation.

## Extraction pattern

Pi outputs JSONL. The final `agent_end` event contains the complete conversation:

```python
import json

def extract_pi_result(output_path):
    """Extract assistant text + usage from pi JSON output."""
    text_parts = []
    usage = None
    with open(output_path) as f:
        for line in f:
            data = json.loads(line)
            if data.get("type") == "agent_end":
                for msg in data.get("messages", []):
                    if msg.get("role") == "assistant":
                        for c in msg.get("content", []):
                            if c.get("type") == "text":
                                text_parts.append(c["text"])
                        usage = msg.get("usage")
    return "\n".join(text_parts), usage
```

## Presenting results

When showing pi results to the user:
1. Lead with pi's response text
2. If pi made tool calls (bash, edit, etc.), summarize what it did
3. Append usage: `(pi: input Xk, output Y tokens)`
4. If pi found issues, format them as actionable items

## For background tasks

```bash
# Check if done
pi-cc status <task-id>

# Get result when completed
pi-cc result <task-id>
```

The result command outputs the raw JSONL. Parse it with the extraction pattern above.
