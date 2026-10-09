# Description optimization

## Define the boundary

Connect the requested outcome to the skill's distinctive value. Describe contexts
where that value helps, including indirect requests. Use a short capability
statement and clear invocation guidance. Distinguish likely neighboring skills
through concrete scope. Optimize for useful activation, with false-positive and
missed-trigger costs appropriate to the workflow.

Keep the body and resources fixed during description experiments. User-selected
invocation policy determines whether automatic activation is relevant.

## Build the test set

Store realistic queries with `query` and `should_trigger`. Include indirect
positives, terse and detailed requests, varied phrasing, and tasks embedded in a
larger request. Negative cases are close neighbors sharing vocabulary but
requiring another capability. Label the intended scope before evaluating.

Partition both labels into separate, fixed training and validation files; reserve
fresh queries for a final check. Give the reviser only training examples and
outcomes; keep held-out queries and per-query diagnostics with the evaluator.
Repeated candidate selection can itself overfit validation, so the fresh set
checks the selected candidate once. This skill's sets live in `evals/triggers/`.

## Measure real activation

Verify the candidate is registered and the expected metadata is visible in the
target client, alongside relevant competing skills. Each automatic-trigger test
starts in a fresh context with a natural user query. Explicit skill mentions,
forced loading, and providing the body turn it into a different test.

Observe a `SKILL.md` read, activation tool call, or equivalent client load event.
Self-reported intent and keyword similarity are insufficient evidence. In clients
without activation observability, record this limitation and classify the result
as unmeasured. Client errors are separate from observed non-activation.

Choose repeat count and acceptance thresholds before the run, using the available
budget and cost of incorrect activation. Record per-query load events and trigger
rates, plus false positives and missed positives by configuration. Report counts
alongside precision and recall; mark a zero denominator as undefined.

## Revise and select

Use training failures to clarify the underlying intent category or boundary.
Generalize the wording; adding every failed query's keywords grows the catalog
without proving generalization. Recheck the 1024-character limit after editing.

Compare candidates on the fixed validation set; prefer the shortest candidate
meeting the chosen acceptance criteria. Stop on success, plateau, or budget.
Evaluate the selection on fresh queries and retain the evidence. Apply the chosen
description, validate the package, and report measured changes in activation.
Unavailable runtime evidence leaves the description a candidate awaiting testing.
