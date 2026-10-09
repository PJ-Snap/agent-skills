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
`openspec-propose`. This workflow is read-only; proposal artifacts, detailed
design, and implementation tasks belong to the user-invoked proposal workflow.

## Workflow

### 1. Establish the current position

1. Identify the requirements source: path, paste, URL, or OpenSpec change.
   Ask for it when absent from the request and available context.
2. Establish intent, priorities, and cross-cutting constraints. Distinguish
   requirements, suggested solutions, and assumptions.
3. Inspect project instructions, relevant code and tests, OpenSpec context,
   accepted specs, and active changes far enough to bound the increment.
   Honour the selected project and planning store, including external stores.
4. Identify implemented, in-progress, and remaining behaviour. Code establishes
   current behaviour; requirements establish intended behaviour.
5. Surface conflicts between requirements, decisions, and observed behaviour.
   Ask about unresolved choices that materially affect this increment.

### 2. Select and bound the increment

1. Follow the user's priority. Otherwise compare complete user workflows,
   backend/service capabilities, and focused prerequisites by value,
   consequential uncertainty, and actual dependencies.
2. Define the increment type, terminal state, and who can use it after merge.
   A user-facing slice delivers independent value. A backend capability or
   prerequisite is complete and verifiable at a named immediate consumer's
   boundary; identify the outcome it unlocks and deferred product integration.
   Judge completeness by usable outcomes, not technical layers crossed.
3. Target one coherent, verifiable PR that merges safely onto the stated
   baseline. Include required failure handling, security, data integrity, and
   compatibility, including behind feature flags.
4. Size by conceptual complexity and verification burden. Explain what makes
   a broader candidate unsuitable, accounting for shared work retained by a
   smaller slice. Keep tightly coupled behaviour together and scope supporting
   work to the selected outcome.
5. Reduce scope through narrower scenarios, a different delivery boundary, or
   the smallest useful prerequisite. An intermediate workflow stage qualifies
   when it delivers independent value or a complete prerequisite for a named
   immediate consumer.
6. Check overlap with active changes. Use merged code as the available baseline
   and identify dependencies on unmerged work explicitly, distinguishing agreed
   dependencies from blockers.
7. When an unknown prevents credible scoping, recommend a bounded investigation
   with a question, required evidence, and stopping condition.

### 3. Keep later work adaptable

1. Detail the selected increment. Record remaining outcomes as a short
   provisional list linked to source sections; future sequencing stays open.
2. Reassess each invocation against current requirements, merged code, active
   work, and implementation feedback. Name invalidated assumptions and recommend
   the smallest necessary revision.
3. Identify results from this increment that would change subsequent scope or
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

Evidence of completion: <observable outcomes that establish completion>

Assumptions and decision points: <confirmed constraints versus provisional
assumptions, and the evidence that would require revisiting scope>

Revalidate this scope against current sources and surface material conflicts
before expanding it. Create proposal artifacts for this increment only, with
detailed design and implementation tasks developed in the proposal workflow.
```

After the block, list the provisional remaining outcomes and the next
reassessment checkpoint, marked as context rather than instructions for
`openspec-propose`.

Return the specific question or investigation brief in place of the handoff
when an unknown blocks credible scoping.

## Guardrails

- Access OpenSpec artifacts, source documents, application code, and PRs
  read-only.
- `openspec-propose` runs when the user invokes it.
- Every claim about current state carries a path, symbol, or requirement
  section; unavailable sources are reported as gaps.
- Preserve explicit requirements and user constraints until the user changes
  them; label inferred assumptions separately.
- Deferred outcomes remain live; the provisional list records them for later
  reassessment.
