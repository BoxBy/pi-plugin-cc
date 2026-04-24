---
description: "Ask pi for a second opinion. Use when you want an independent perspective on code, architecture, or approach. Pi is free — ask liberally."
argument-hint: "<question>"
---

# /pi:ask

Get a second opinion from pi on anything.

## Steps

1. Gather context automatically:
   - Current file (if editing one)
   - Recent git diff (if changes exist)
   - The user's question from $ARGUMENTS

2. Run pi:
   ```bash
   pi-cc run "You are giving a second opinion to another developer. Answer concisely and directly.

   Context:
   $AUTO_CONTEXT

   Question: $ARGUMENTS"
   ```

3. Present pi's response in conversation. If pi disagrees with Claude's approach, note the disagreement and let the user decide.
