---
name: pi-cross-verify
description: "Cross-verify Claude's work with pi. After Claude makes changes, pi independently reviews for bugs, missed edge cases, and improvements. Use after completing code changes to get a free second opinion. Triggers when Claude finishes writing or editing code."
---

# Pi Cross-Verify

After Claude makes code changes, have pi independently verify them.

## When to trigger

- After completing a refactoring
- After implementing a new feature
- After fixing a bug
- When the user asks for verification
- When the review gate hook fires (Stop hook)

## Execution

1. Collect recent changes:
   ```bash
   git diff HEAD~1  # or git diff / git diff --cached
   ```

2. Send to pi for independent review:
   ```bash
   pi-cc run "You are an independent reviewer. Another AI made these changes.
   Assume nothing is correct. Verify:
   - Logic errors, off-by-one
   - Missing edge cases
   - Security issues
   - Breaking changes to callers
   - Test coverage gaps

   Changes:
   $DIFF

   file:line format for each finding."
   ```

3. Present findings to main Claude session
4. If critical issues: fix immediately
5. If clean: report "pi verification passed"

## Not a blocker

Pi cross-verify is advisory. Claude makes the final call on whether to act on pi's findings.
