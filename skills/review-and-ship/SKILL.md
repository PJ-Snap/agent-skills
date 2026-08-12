---
name: review-and-ship
description: Runs a structured review, closes key issues, and ships changes via PR. Use when changes are ready to review and merge.
disable-model-invocation: true
---

# Review and ship

## Trigger

Reviewing changes before shipping. Close key issues and open/update PR.

## Workflow

1. Review diff against base branch and identify behavior-impacting risks.
2. Run or update tests for changed behavior, ensuring that unit test coverage for testable code is above 70%.
3. Fix critical issues before finalizing.
4. Commit selective files with a concise message.
5. Push branch and open or update a PR.

## Focus Areas

Review the provided code changes (diffs) for the following:

1. **Critical Issues (Bugs & Logic):**
  - Race conditions, unhandled inconsistencies, and logic errors.
  - Off-by-one errors, infinite loops, or resource leaks.
  - Edge cases (null inputs, empty arrays, etc.).
2. **Security:**
  - Hardcoded secrets/credentials (API keys, tokens).
  - SQL injection, XSS, or other injection vulnerabilities.
  - PII leakage in logs.
3. **Performance:**
  - N+1 queries or inefficient database usage.
  - Expensive computations inside loops.
  - Blocking/synchronous hot-path work (e.g., network or file I/O on request paths, synchronous DB access in latency-sensitive code, missing timeouts/retry limits, or heavy CPU work not offloaded); flag cases likely to block >100ms on request paths and prefer async/non-blocking APIs, bounded retries/timeouts, or background jobs.
4. **Clean Code/Architecture:**
  - Modules/Files that violate separation of concerns
  - Functions that violate principle of least surprise
  - Functions that exhibit leaky abstractions
  - Functions that violate Law of Demeter
  - Code smells



## Guardrails

- Keep commits focused and avoid unrelated file changes.
- If pre-commit checks fail, fix the issues rather than bypassing hooks.
- Favor fix-forward changes over adding legacy compatibility shims.
- Testable-code-adjusted coverage for changes is >70%



## Output

- Findings summary (critical, warning, note)
- Tests run and outcomes
- PR URL

