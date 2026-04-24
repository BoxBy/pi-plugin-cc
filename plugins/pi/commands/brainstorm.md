---
description: "Have pi brainstorm ideas. Pi generates multiple approaches/ideas, then Claude refines and selects the best."
argument-hint: "<topic> [--count N]"
---

# /pi:brainstorm

Use pi for idea generation, Claude for selection.

## Steps

1. Extract topic and count (default 5) from $ARGUMENTS.

2. Run pi:
   ```bash
   pi-cc run "Brainstorm ${COUNT:-5} distinct approaches/ideas for the following topic. For each idea:
   - Name it concisely
   - Describe the approach (2-3 sentences)
   - List pros and cons
   - Rate complexity (low/medium/high)

   Topic: $TOPIC

   Be creative. Include at least one unconventional approach."
   ```

3. Parse pi's ideas. Claude then:
   - Evaluates each idea against project context
   - Selects top 3
   - Analyzes tradeoffs
   - Recommends one with reasoning
