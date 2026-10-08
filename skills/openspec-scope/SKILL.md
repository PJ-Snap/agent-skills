---
name: openspec-scope
description: >-
  Selects the next useful, reviewable increment from requirements and existing
  code, then returns a copyable handoff block for openspec-propose. Use when
  the user invokes openspec-scope, or asks to scope the next change, next PR,
  next slice, or next increment from a spec, PRD, requirements document, or
  OpenSpec change set that may be partly implemented or unstarted.
disable-model-invocation: true
---

# OpenSpec Scope

Select the next useful, reviewable increment and return a handoff for
`openspec-propose`. Keep this workflow read-only; leave proposal,
specification, design, and task creation to that skill, and let the user
invoke it.

## Workflow

### 1. Establish the current position

1. Identify the requirements source — a path, paste, URL, or OpenSpec
   change — and ask the user for it when the request names none.
2. Read the requirements for overall intent, priorities, and cross-cutting
   constraints. Distinguish explicit requirements from suggested solutions and
   unverified assumptions; a firm requirement stays firm.
3. Inspect applicable project instructions, relevant implementation, tests,
   available OpenSpec context, accepted specs, and active changes. Honour an
   explicitly selected project or planning store — the planning home may sit
   outside the codebase.
4. Inspect only far enough to select and bound the increment; leave detailed
   implementation discovery to `openspec-propose`.
5. Identify what is implemented, what is in progress, and what remains. Treat
   code as evidence of current behaviour, not proof of intended behaviour.
   Cite concrete paths, symbols, and requirement sections. Report unavailable
   sources as gaps.
6. Surface conflicts between requirements, current decisions, and observed
   behaviour. Ask only about unresolved choices that materially affect this
   increment; leave unrelated questions for later.

### 2. Select and bound the increment

1. Follow the user's stated priority. Otherwise compare plausible outcomes
   across supported scenarios and delivery boundaries: a complete user workflow
   for a narrower scenario, a complete backend or service capability with a
   named immediate consumer, or a focused prerequisite. Select on value,
   consequential uncertainty, and actual dependencies; do not assume every
   increment must include frontend delivery.
2. Define the increment type and terminal state after merge. A user-facing slice
   must deliver an independently useful outcome; a backend capability or other
   prerequisite must be complete and verifiable at its consumer boundary.
   Crossing technical layers alone does not establish a useful vertical slice.
   Split a workflow at an intermediate stage only when that stage has independent
   value or supplies a complete prerequisite for a named immediate consumer.
3. Aim for one coherent PR that can be verified and safely merged onto the
   current baseline. Include the failure handling, security, data integrity,
   and compatibility the selected behaviour requires; a feature flag leaves
   those invariants intact.
4. Choose a focused prerequisite when it genuinely unlocks the next outcome,
   and name its immediate consumer. State what that consumer can use after merge
   and which product integration remains deferred; backend foundation work need
   not introduce a partially usable frontend.
5. Recommend a bounded investigation — question, evidence needed, stopping
   condition — when an unknown prevents credible scoping.
6. Size by conceptual complexity and verification burden rather than line
   counts or agent coding speed. Explain the concrete complexity that makes a
   broader candidate unsuitable, accounting for shared work that a smaller slice
   would still require. Keep tightly coupled behaviour together; leave unrelated
   cleanup and speculative infrastructure out.
7. Narrow the supported scenario or change the delivery boundary when necessary
   to retain a complete outcome; alternatively select the smallest useful
   prerequisite. Do not cut workflow stages solely to reduce size.
8. Check active changes so the increment stays clear of work already in
   flight, and treat unmerged changes as unavailable. State the intended
   baseline and real dependencies, distinguishing an agreed dependency from a
   blocker.

### 3. Keep later work adaptable

1. Detail the selected increment only. Keep remaining outcomes as a short
   provisional list linked to their source sections, rather than numbered
   future PRs or a complete task and dependency plan.
2. Reassess on each invocation against the latest requirements, merged code,
   active work, and implementation feedback. Name the assumptions new evidence
   invalidates and recommend the smallest necessary revision. Preserve
   explicit user constraints and source requirements until the user changes
   them.
3. Record which result from this increment would change subsequent scope or
   sequencing.

## Output

Give a brief selection rationale explaining why this boundary is preferable to
the plausible alternatives, then one copyable Markdown block addressed to
`openspec-propose`, normally under 400 words:

```markdown
Scope this change: <short descriptive title>

Increment type and terminal state: <user-facing outcome, backend/service
capability, or prerequisite; what is complete and usable after merge and by whom>

Outcome: <one observable behaviour, or a concrete prerequisite and its purpose>

Sources and current state: <project/location, requirement sections, relevant
code and spec references, implemented behaviour, actual dependencies>

Scope boundary: <included scenarios, essential invariants, explicit exclusions,
safe state after merge>

Evidence of completion: <a few observable outcomes that establish this
increment works; no detailed test plan>

Assumptions and decision points: <confirmed constraints versus provisional
assumptions, and the evidence that would require revisiting scope>

Create proposal artifacts for this increment only. Revalidate the scope against
current sources and surface material conflicts before expanding it. Leave
detailed design and implementation tasks to the proposal workflow.
```

After the block, list the provisional remaining outcomes and the next
reassessment checkpoint, marked as context rather than instructions for
`openspec-propose`.

Return the specific question or investigation brief in place of the handoff
when an unknown blocks credible scoping.

## Guardrails

- This workflow reads: OpenSpec artifacts, source documents, application code,
  and PRs stay untouched.
- `openspec-propose` runs when the user invokes it.
- Every claim about current state carries a path, symbol, or requirement
  section; unavailable sources are reported as gaps.
- Requirement classification stays as written — firm requirements remain firm.
- Deferred outcomes remain live; the provisional list records them for later
  reassessment.
