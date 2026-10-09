# Output evaluation

## Define success

Start with a representative task, a materially different task, and an important
boundary. Store reusable cases in `evals/evals.json` with `skill_name` and `evals`.
Each case has `id`, a realistic `prompt`, `expected_output`, and fixture `files`
relative to the skill root. Add `assertions` for observable requirements.

Define expected outcomes from the user's requirements before execution. An
exploratory run may clarify checks; freeze the revised checks before comparing
configurations and apply them equally. Grade behavior and artifacts, using code
for mechanical checks. Exact wording matters only when it is an output contract.

## Control the comparison

Run the candidate and a baseline with the same task, fixtures, tools, model, and
environment. For creation, the baseline has the candidate skill unavailable; for
an update, it uses a snapshot of the prior version. Shared dependencies remain
available to both, isolating the candidate's contribution.

Use a fresh session and isolated output directory for every run. Give the worker
the task, inputs, output destination, and applicable skill; keep expected answers,
grading assertions, development history, and proposed fixes with the evaluator.
Confirm which skill version actually loaded. Output tests may invoke the skill
explicitly; automatic activation is measured separately.

Use the client's supported runner and available evaluation budget. When fresh
execution is unavailable, retain runnable cases and identify runtime claims as
untested. In-conversation rehearsal is a smoke check with disclosed limitations.

## Inspect evidence

Preserve artifacts, transcripts, skill snapshots, configuration, and available
token and timing measurements in an external evaluation workspace. Each assertion
record contains concrete evidence followed by its pass/fail judgment. Record
execution or grading errors separately from task failures.

Review per-case outcomes alongside quality gains and time/token costs. Repeat
unstable or consequential cases enough to expose variability. Retain critical
invariants even when both configurations pass; separate them from checks that
demonstrate added value. Small samples support observations, not reliability
claims. Review actual outputs with the user when subjective quality matters;
blind version comparison can reduce preference bias.

## Improve

Use failures, reviewer feedback, and traces to locate the cause. Change the owning
instruction or helper; address a class of failures rather than a fixture's wording.
Test removing low-value guidance. Keep acceptance checks stable across revisions;
document a changed requirement and regrade both configurations when a check changes.

Evaluate revisions in new workspace directories. Keep the simplest candidate that
meets acceptance and shows a useful tradeoff. If improvement stalls, reconsider
scope, evidence, tooling, or the need for the skill before adding more rules.
