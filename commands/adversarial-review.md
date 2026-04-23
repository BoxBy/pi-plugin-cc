---
description: "Aggressive code review via pi. Challenges design decisions, tradeoffs, and assumptions. Use when you want a devil's advocate review."
argument-hint: "[--base <ref>] [--focus <text>]"
---

# /pi:adversarial-review

Have pi aggressively challenge the code changes.

## Steps

1. Collect diff (same as /pi:review).

2. Run pi:
   ```bash
   pi-cc run "You are a senior staff engineer doing an adversarial code review. Your job is to find problems, not be nice.

   For each change, challenge:
   - Why this approach over alternatives?
   - What assumptions could be wrong?
   - What breaks under load/edge cases?
   - What's the maintenance cost in 6 months?
   - Are there simpler solutions?

   <diff>
   $DIFF_CONTENT
   </diff>

   $(if FOCUS: Focus especially on: $FOCUS)

   Be specific: file:line, what's wrong, why it matters, what to do instead."
   ```

3. Present pi's adversarial feedback. Note areas where pi's concerns may not apply (Claude judges).
