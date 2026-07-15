---
name: update-plan
description: Updates the current agent's plan with recommendations.
disable-model-invocation: true
---

Update the current plan based on the supplied recommendations.

## Default mode

When multiple options exist, present the available choices, clearly explain
their trade-offs, and ask for my confirmation before proceeding. For the
cleanest architectural implementation (best for reducing complexity and
maintenance), tag that option as (Cleanest).

## Review-loop automation mode

Use this mode only when a parent workflow explicitly says the recommendations
are review findings to apply automatically.

- Apply every concrete correction that preserves the canonical plan, its
  acceptance contract, and verified repository constraints.
- Do not ask for confirmation for a correction with one clear compliant
  implementation. When equally compliant implementations exist, choose the
  cleanest one.
- Stop and report **Blocked** when a correction requires a choice that
  materially changes scope, a fixed contract, an acceptance criterion, or
  verified repository architecture. State the competing options and the exact
  information needed to proceed.
- Preserve every unaffected part of the implementation prompt. Do not weaken,
  remove, or renumber acceptance criteria unless the reviewer identifies a
  concrete canonical-plan mismatch that requires correction.
- Return the complete updated prompt and a concise list of applied findings.
