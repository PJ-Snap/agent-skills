---
name: update-plan
description: Updates the current agent's plan with recommendations.
disable-model-invocation: true
---

Update the current plan based on the supplied recommendations.

- Apply every concrete correction that preserves the canonical plan, its
acceptance contract, and verified repository constraints.
- Do not ask for confirmation for a correction with one clear compliant
implementation. When equally compliant implementations exist, choose the
cleanest one.
- Stop and report **Blocked** when a correction requires a choice that materially changes scope, a fixed contract, an acceptance criterion, or verified repository architecture. State the competing options and the exact information needed to proceed along with one of the options being annoted (recommended)
- Preserve every unaffected part of the implementation prompt. Do not weaken,
remove, or renumber acceptance criteria unless the reviewer identifies a
concrete canonical-plan mismatch that requires correction.
- Return the complete updated prompt and a concise list of applied findings.

