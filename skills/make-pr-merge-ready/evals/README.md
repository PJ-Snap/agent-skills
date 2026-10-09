# Evaluation Protocol

Output quality and automatic activation are separate measurements. The files in
this directory retain cases and inputs; store execution evidence outside the
installable skill package.

## Output quality

Use `evals.json` and its fixture notes to provision disposable repositories and
a scripted PR-host adapter. The notes specify scenario state; they are not a
working host adapter. Before execution, freeze the adapter responses and expected
outcomes equally for candidate and baseline. Keep grading assertions away from
the worker. Supply only the prompt, repository, adapter access, and output path.

For each case, run a fresh isolated session with this skill, then a matched
baseline without it. Keep model, repository instructions, tools, and environment
equal. Shared dependencies remain equally available. Confirm the candidate's
`SKILL.md` was actually loaded, and that the baseline cannot discover it.

Inspect real diffs, tests, workflow actions, comment dispositions, and host state.
The adapter should record review pagination, replies, resolution, pushes, check
SHAs, and OpenSpec lifecycle events. Preserve transcripts, skill snapshots,
artifacts, and command results externally. Evidence precedes each pass/fail
judgment; runner errors are distinct from workflow failures.

Acceptance requires all assertions for each case and retained invariants: valid
coverage survives, unrelated work is preserved, only owned changes are finalized,
and readiness follows current host evidence. Plans alone cannot pass an execution
case. Repeat consequential or unstable behaviors before generalizing results.
Without a provisioned adapter or authorized live fixture PR, report runtime
output quality as untested rather than interpreting fixture prose as a pass.

## Activation

Register the skill in the real target client alongside neighboring skills.
Use fixed `triggers/train.json` and `triggers/validation.json` sets for description
experiments; hold `triggers/fresh.json` for the selected description's final check.
Keep body and resources fixed throughout activation experiments.

Each query starts in a fresh session without an explicit skill mention or its
body supplied. Observe a skill read or equivalent loading event. Before running,
choose a repeat count; the acceptance target is activation on all positive queries
and no activation on the narrowly scoped negatives. Report observed counts and
uncertainty, rather than inferring activation from keyword matches. Client
discovery problems and missing activation observability remain separate from
measured misses.
