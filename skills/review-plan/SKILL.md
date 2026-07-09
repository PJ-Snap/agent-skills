---
name: review-plan
description: Reviews an implementation plan for architectural soundness and LLM agent executability. Use when validating a plan before implementation, checking if a plan is one-shottable, or reviewing TDD plans.
disable-model-invocation: true
---

# Review Plan

Critically review the plan for poor design, ambiguity, and agent executability. A plan passes when a single LLM coding agent can execute it without human clarification.

If the plan references a spec, compare the plan against that spec before reviewing. Verify that the plan covers the spec's goals, constraints, requirements, and acceptance criteria. Call out gaps, contradictions, scope drift, or requirements only partially addressed.

## Architecture & Design

- Unverified assumptions
- Spec conformance when a spec is referenced
- Proper separation of concerns
- Edge cases and failure modes
- Missing or unclear architectural decisions
- Component responsibilities and boundaries
- Integration approaches
- Maintainable, extensible designs

## TDD Structure

- Behaviors describe observable outcomes through the public interface, not implementation details
- Behaviors are ordered: tracer bullet first, then happy path, then edge cases — with a stated rationale
- Each behavior maps to exactly one RED→GREEN cycle — not too coarse (bundled assertions) or too fine (testing internals)
- Order respects code dependencies (a behavior cannot be tested if it calls code introduced in a later step)

## Agent Executability

Flag any of the following as blocking one-shot execution:

**Missing concreteness:**
- File paths for every new or modified file are not specified
- Function/class signatures (name, params, return type) are absent
- Import paths or dependency wiring is left to the implementer

**Deferred decisions:**
- Vague language that forces a design choice ("use an appropriate structure", "handle errors gracefully")
- Multiple options presented without a selection
- Forward references ("we'll wire this in step 5") that require look-ahead

**Incomplete preconditions:**
- A behavior's test setup (fixtures, mocked responses, DB state) is not stated
- Shared state between steps is implicit rather than explicit

**Unclear scope boundaries:**
- No statement of what is NOT being changed (preserved interfaces, untouched files)
- Adjacent code that could be "helpfully" refactored without explicit instruction not to

**Missing verification:**
- Steps lack an exact command to confirm success (e.g., `pytest path/to/test.py::TestClass::test_name`)
- "Run the tests" without specifying which tests

## Guardrails

- Keep review to architectural, design, and executability guidance
- Verify assumptions using official documentation or the codebase
- Do not assume a referenced spec is satisfied just because it is cited; check that the plan materially implements it
- Do not rewrite the plan; identify problems and recommend fixes

## Output

**Overall Assessment:** [Approve / Revise]

**Spec Alignment:** [No spec referenced / Meets spec / Partially meets spec / Does not meet spec]

**TDD Alignment:** [Well-structured / Needs adjustment]

**Agent Executability:** [One-shottable / Needs clarification]

**Issues Identified:**
1. [Category]: [Specific problem]
   - Recommendation: [Concrete fix]

2. [Next issue...]
