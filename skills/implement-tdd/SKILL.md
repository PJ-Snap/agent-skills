---
name: implement-tdd
description: Test-driven development with red-green-refactor loop. Use when user wants to build features or fix bugs using TDD, mentions "red-green-refactor", wants integration tests, or asks for test-first development.
---

# Test-Driven Development

## Philosophy

Tests verify behavior through public interfaces, not implementation details. Code
can change entirely; tests shouldn't break unless behavior changes.

See [tests.md](references/tests.md) for good vs bad test examples and
[mocking.md](references/mocking.md) for mocking guidelines.

## Anti-Pattern: Horizontal Slices

**DO NOT write all tests first, then all implementation.**

Horizontal slicing produces tests that verify _imagined_ behavior rather than
_actual_ behavior. Tests become insensitive to real changes — they pass when
behavior breaks and fail when behavior is fine.

```
WRONG (horizontal):
  RED:      test1, test2, test3, test4, test5
  GREEN:    impl1, impl2, impl3, impl4, impl5
  REFACTOR: one cleanup pass after all GREEN

RIGHT (vertical):
  RED → GREEN → REFACTOR: test1 → impl1 → refactor1
  RED → GREEN → REFACTOR: test2 → impl2 → refactor2
  RED → GREEN → REFACTOR: test3 → impl3 → refactor3
```

## Workflow

The plan is already specced. Go straight into the loop.

### 1. Tracer Bullet

Write ONE test that confirms ONE behavior through the public interface:

```
RED:      Write test → run it → test fails (confirms the test is meaningful)
GREEN:    Write minimal code to pass → run it → test passes
REFACTOR: Clean up this slice → tests still pass
```

This proves the path works end-to-end before building out further.

### 2. Incremental Loop

For each remaining behavior:

```
RED:      Write next test → fails
GREEN:    Minimal code to pass → passes
REFACTOR: Clean up → tests still pass
```

- One test at a time. Only enough code to pass that test.
- Don't anticipate future tests.
- Each test must use the public interface only.

### 3. Refactor

After all tests pass, read
[references/refactoring.md](references/refactoring.md) and apply. Run tests
after each refactor step. **Never refactor while RED.**

#### 3a. Deslop

After manual refactoring is complete and tests are GREEN, run the slop report
scoped to the touched files:

```bash
deslop --uncommitted-only --path <module-path>
```

Where `<module-path>` is the directory or file being worked on.

Then scope findings to only the code you wrote:

1. Run `git diff --unified=0` to get the exact changed line ranges.
2. Read `.deslop/report.md` and discard any finding whose line number falls
   **outside** the changed ranges from the diff. Pre-existing findings in
   untouched lines are not your responsibility.
3. Fix remaining findings using the report guidelines.
4. Re-run the report and repeat the diff filter. If no findings remain in your
   changed lines, continue.

Run tests after each fix to stay GREEN. Do not proceed to step 4 until findings
in your changed lines are resolved.

### 4. Plan Conformance Check

Re-read the original plan. For every specified behavior, requirement, and edge
case, classify it as one of:

- **Implemented** — delivered as planned.
- **Deviated** — delivered differently. State why (e.g., existing code already
  covers it, the plan's approach conflicted with the actual codebase, a better
  pattern emerged during implementation).
- **Missing** — not yet done. Loop back to step 2 and complete it through
  RED→GREEN before finishing.

Do not declare the task complete until every plan item is either Implemented or
Deviated-with-justification. Silent omissions are not acceptable.

## Per-Cycle Check

Before moving to the next cycle, verify:

- Test describes behavior, not implementation
- Test uses public interface only
- Test would survive an internal refactor
- Code is minimal for this test
- No speculative features added
- Slop report is clean for lines you changed (step 3a)

## Gotchas

- If a test breaks during refactoring but behavior hasn't changed, the test was
  testing implementation. Rewrite the test, don't revert the refactor.
- "Minimal code to pass" means exactly that — resist cleaning up during GREEN.
  Cleanup belongs in the REFACTOR step.
- If you can't write a failing test for a behavior, either the behavior already
  exists or the test isn't testing through the right interface.
- The slop report runs linters on entire files. Ignore findings on lines you
  did not change — only fix slop you introduced.

## References

- If the task introduces new classes, function signatures, or dependency wiring,
  read [references/interface-design.md](references/interface-design.md).
- If the task adds a new module or expands a public API surface, read
  [references/deep-modules.md](references/deep-modules.md).
- If the task requires mocking external services or system boundaries, read
  [references/mocking.md](references/mocking.md).
- If the task adds or modifies tests, read
  [references/tests.md](references/tests.md).
- If the task adds or changes exception handling, read
  [references/error-handling.md](references/error-handling.md).
