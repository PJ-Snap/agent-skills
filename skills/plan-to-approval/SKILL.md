---
name: plan-to-approval
description: Creates or accepts a TDD implementation prompt, then repeatedly reviews and automatically corrects it until it is approved. Use when a plan must be implementation-ready without manually alternating create-plan, review-plan, and update-plan.
disable-model-invocation: true
---

# Plan to Approval

Produce an approved, self-contained implementation prompt. This workflow owns
the loop; the plan author, reviewer, and updater retain their existing
responsibilities.

## Inputs

- A canonical Lavish plan, if one exists; its outcome, scope, requirements,
  contracts, constraints, exclusions, and completion conditions are immutable.
- Either a freeform feature description or an existing implementation prompt.
- Repository access for validating plan and review assertions.

If neither a canonical plan nor an existing prompt is supplied, create the
initial prompt from the feature description. If no canonical plan exists, use
the prompt's Acceptance contract as the source of truth.

## Workflow

1. Create the initial implementation prompt when one was not supplied. Follow
   the `create-plan` workflow in full.
2. Review the current prompt against the canonical plan, `AGENTS.md`, and the
   repository using the `review-plan` workflow in full.
3. If the review's **Overall assessment** is `Approve`, return the approved
   current prompt followed by the review result. Do not make further changes.
4. If the assessment is `Revise`, apply every blocking correction using
   `update-plan` in **Review-loop automation mode**. Preserve the canonical
   plan and all unaffected prompt content.
5. Re-review the complete updated prompt. Repeat steps 3–5 for at most five
   total reviews.

## Stop conditions

- Stop immediately and report **Blocked** if a correction requires human input,
  an unresolved material design choice, a missing canonical decision, an
  unavailable prerequisite, or a conflict between the canonical plan and the
  verified repository. Include the exact review finding and the decision or
  prerequisite required.
- Stop and report **Not approved** if the fifth review is still `Revise`.
  Return the latest complete prompt, every remaining blocking finding, and the
  review count. Do not claim approval.
- Do not silently discard findings, weaken acceptance criteria, alter
  canonical scope, or turn a fixed constraint into an implementation
  deviation.

## Loop evidence

For each iteration, record:

- review number;
- review assessment;
- blocking findings and their exact corrections;
- changes made to the prompt; and
- the final review output.

The final response must contain the complete final prompt and clearly state
either **Approved** with the approving review evidence, **Blocked**, or
**Not approved**.
