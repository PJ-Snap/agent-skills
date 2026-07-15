---
name: review-plan
description: Review a self-contained TDD implementation prompt for canonical acceptance coverage, architectural soundness, vertical phasing, and coding-agent execution readiness. Use before implementation to approve or revise a plan produced by create-plan.
disable-model-invocation: true
---

Critically audit the prompt against its canonical Lavish plan, `AGENTS.md`, and
the repository. Approve only when it is complete, internally consistent, and
executable without unresolved decisions or human clarification.

If a canonical Lavish plan is supplied, treat its outcome, scope, requirements,
contracts, constraints, exclusions, and completion conditions as immutable.
Compare them directly against the implementation prompt; do not infer alignment
from a citation. If no canonical plan exists, use the prompt's Acceptance
contract as the source of truth.

## Acceptance coverage

- Every canonical requirement and acceptance criterion has one stable,
non-duplicated `AC-*` ID.
- Each criterion preserves the canonical meaning and is independently
understandable without opening the source plan.
- Every `AC-*` ID maps to at least one concrete task behavior or phase checkpoint.
- The mapped behavior or checkpoint provides falsifiable test evidence.
- Every standalone task repeats the full text of each criterion it owns.
- No criterion is orphaned, represented only by prose, weakened, contradicted,
deferred without an owner, or expanded beyond scope.



## Architecture and design

- Repository assertions, paths, contracts, and conventions are verified against
the codebase and `AGENTS.md`.
- Modules have single, explicit ownership boundaries and avoid duplicate
responsibilities.
- Public contracts minimize surface area, inject external dependencies, return
results where possible, and isolate unavoidable side effects at system
boundaries.
- Deep modules hide substantial complexity behind simple, stable interfaces;
wrappers and abstractions are justified by distinct responsibility.
- Error ownership, data contracts, dependency direction, integration behavior,
edge cases, and failure modes are resolved.
- Canonical contracts and constraints cannot be completed as deviations.



## Phases and tasks

- Phases are vertical product-capability milestones, never horizontal backend,
frontend, database, testing, or infrastructure layers.
- Every phase ends in a working, demonstrable integrated state with an exact
checkpoint.
- Keystone interfaces and tracer-bullet paths precede dependent behavior.
- Each task is a bounded, testable, reviewable change with one ownership
boundary, one concrete outcome, and independent verification.
- Dependencies are exact artifact contracts with verification methods, never
task-number-only references.
- Each task contains all context, constraints, decisions, criterion text,
commands, and TDD instructions needed when executed independently.



## TDD structure

- Each behavior describes one observable outcome through a public contract.
- The first behavior is a tracer bullet; later behaviors are the next smallest
useful increments, with an ordering rationale.
- Every behavior is one complete RED → GREEN → REFACTOR cycle.
- RED specifies concrete setup, public action, observable assertion, exact
command, and expected failure reason.
- GREEN requires minimal production code and forbids anticipating later behavior.
- REFACTOR runs only while green, preserves behavior, and reruns focused tests
after each step.
- Tests avoid private state and internal calls; mocks are limited to external
boundaries.
- Non-TDD work is isolated and explicitly justified as having no meaningful
observable behavior to test.



## Execution readiness

Flag any item below as blocking:

- Unresolved choices, vague instructions, hidden assumptions, or required human
input during execution.
- Missing paths, language-appropriate public contracts, imports, dependency
wiring, setup state, scope boundaries, or preserved interfaces.
- Forward references that require another task or plan section for context.
- Missing baseline preflight, prerequisite checks, dirty-worktree protection, or
relevant baseline tests.
- Commands not discovered in repository configuration or tools not verified as
available.
- Unsupported lint, type-check, build, quality, or `deslop` commands included
instead of being omitted.
- Unresolved placeholders, emitted HTML comments, or references to the source
plan, prior conversation, or implementation skills.
- Tasks that mix ownership boundaries or lack independent verification.
- Dependency ordering that cannot be executed from the verified repository state.



## Execution-time conformance

- The prompt requires a final `Verify acceptance conformance` todo.
- Every `AC-*` criterion is classified using test or checkpoint evidence as:
  - **Implemented** — satisfied as written.
  - **Missing** — returned to its owning TDD cycle.
  - **Blocked** — stopped with the exact unavailable or contradictory prerequisite.
- Acceptance criteria can never be classified as Deviated.
- Completion requires every criterion to be Implemented.



## Review guardrails

- Verify facts through the repository and official documentation.
- Report only concrete, actionable findings supported by prompt, source-plan, or
repository evidence.
- Do not rewrite the implementation prompt. Identify defects and recommend exact
corrections.
- Approve only when acceptance coverage is complete and no blocking issue remains.



## Output

**Overall assessment:** [Approve | Revise]

**Acceptance coverage:** [Complete | Incomplete]

**Architecture:** [Valid | Needs revision]

**TDD alignment:** [Valid | Needs revision]

**Execution readiness:** [Ready | Blocked]

**Blocking issues:**

1. **[Category]** — [Specific defect and evidence]
  - **Correction:** [Exact required change]

**Non-blocking improvements:**

1. **[Category]** — [Specific improvement]
  - **Recommendation:** [Concrete recommendation]

