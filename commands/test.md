---
description: "Delegate test generation and execution to pi. Pi analyzes code, writes tests, and runs them. Free compute — use for test coverage."
argument-hint: "<target path or module> [--type unit|integration]"
---

# /pi:test

Have pi generate and run tests.

## Steps

1. Run pi:
   ```bash
   pi-cc run "Analyze the code at $TARGET and generate comprehensive tests.

   Type: ${TYPE:-unit}

   Steps:
   1. Read the target code and understand its behavior
   2. Identify edge cases and error paths
   3. Write tests following the project's existing test patterns
   4. Run the tests and fix any failures
   5. Report: tests written, coverage areas, any issues found

   Target: $ARGUMENTS"
   ```

2. Review pi's test code before presenting. Check for:
   - Tests actually test meaningful behavior (not just calling functions)
   - Edge cases covered
   - Consistent with project test patterns
3. Present results. Offer to apply the tests.
