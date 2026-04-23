---
description: "Delegate PR review-fix loop to pi. Pi reads review comments, fixes code, commits, pushes, and replies — repeating until resolved. Free compute for tedious review cycles."
argument-hint: "<PR number or branch> [--max-rounds N]"
---

# /pi:super-pr

Delegate the entire review-fix loop to pi.

## Steps

1. Get PR info:
   ```bash
   gh pr view $PR --json number,headRefName,body,comments,reviews
   ```

2. Collect unresolved review comments:
   ```bash
   gh api repos/{owner}/{repo}/pulls/{number}/comments --jq '[.[] | select(.position != null)]'
   ```

3. Run pi in background:
   ```bash
   pi-cc run "You are fixing PR review comments. For each unresolved comment:
   1. Read the relevant code
   2. Fix the issue
   3. Commit with a clear message referencing the comment
   4. Reply to the comment explaining the fix

   PR: #$PR_NUMBER
   Branch: $BRANCH

   Unresolved comments:
   $COMMENTS_JSON

   After fixing all comments, run the test suite to verify nothing broke.
   Max rounds: ${MAX_ROUNDS:-5}" --bg
   ```

4. Report task ID. User checks progress via `/pi:status`.
5. When complete, Claude reviews the final diff and reports.
