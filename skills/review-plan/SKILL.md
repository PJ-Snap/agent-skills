---
name: review-plan
description: Review a self-contained TDD implementation prompt for acceptance coverage, concrete contracts, and coding-agent execution readiness. Use before implementation to approve or revise a plan produced by create-plan.
disable-model-invocation: true
---

Audit the prompt against its canonical Lavish plan (if supplied), `AGENTS.md`,
and the repository. Approve when an implementing agent can execute end to end
without unresolved decisions or human clarification.

If a canonical Lavish plan is supplied, treat its outcome, scope, requirements,
contracts, constraints, exclusions, and completion conditions as immutable.
Compare them directly against the implementation prompt; do not infer alignment
from a citation. If no canonical plan exists, use the prompt's Acceptance
contract as the source of truth.

Flag a finding as **blocking** only when it matches one of the three gates
below. Everything else is a non-blocking improvement.

## Blocking gates



### 1. Coverage

- Every canonical requirement and acceptance criterion has one stable `AC-*` ID.
- Each criterion preserves the canonical meaning.
- Every `AC-*` ID maps to at least one concrete task behavior or phase
checkpoint with falsifiable test or checkpoint evidence.
- No criterion is orphaned, represented only by prose, weakened, contradicted,
or deferred without an owner.



### 2. Contracts

- Every public interface the implementer must build is concrete: signature,
schema, route, command, event, or migration contract.
- Dependencies are exact artifact contracts with a verification method.
- Material design decisions are resolved; the prompt does not defer choices to
the implementer or use vague instructions such as “as needed” or “handle
appropriately.”
- Canonical contracts and constraints are not completed as deviations.



### 3. Runnable

- Named commands and tools exist in the repository, or unsupported checks are
omitted.
- Prerequisites (files, services, credentials, environments) are named and
verifiable, or explicitly called out as stop conditions.
- Task order is executable: required contracts exist before dependents use them.
- No human input or approval is required during execution.
- Repository assertions that matter to execution are verified against the
codebase and `AGENTS.md`.



## Review guardrails

- Verify facts through the repository and official documentation.
- Report only concrete, actionable findings supported by prompt, source-plan, or
repository evidence.
- Do not rewrite the implementation prompt. Identify defects and recommend
exact corrections.
- Approve when all three blocking gates pass. Non-blocking improvements must not
flip the assessment to Revise.



## Output

**Overall assessment:** [Approve | Revise]

**Coverage:** [Pass | Fail]

**Contracts:** [Pass | Fail]

**Runnable:** [Pass | Fail]

**Blocking issues:**

1. **[Coverage | Contracts | Runnable]** — [Specific defect and evidence]
  - **Correction:** [Exact required change]

**Non-blocking improvements:**

1. **[Category]** — [Specific improvement]
  - **Recommendation:** [Concrete recommendation]

