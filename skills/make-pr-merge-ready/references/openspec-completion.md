# OpenSpec Completion

Complete only changes owned by this PR. Load the repository's installed
`openspec-verify-change`, `openspec-archive-change`, and `openspec-sync-specs`
workflows when present and execute them with explicit change names. If those
generated skills are absent, perform the bundled workflow below with the CLI
and project artifacts; it supplies the same completion responsibilities without
requiring separate skill packages. Report which workflow was executed.

Use installed CLI help and schema instructions for version-specific arguments.
Respect the selected project/store root and schema-defined artifact paths.
Typical paths are `openspec/specs/` and `openspec/changes/`; CLI-resolved paths
take precedence. Optional or explicitly skipped artifacts are not missing work.
An unavailable required CLI or unreadable required contract is a concrete blocker.

## Verify before completion

For an active change, read `openspec status --change <name> --json` and
`openspec instructions apply --change <name> --json`, then their artifact files.
These commands provide context; task status or syntax validation alone does not
verify implementation. Assess completeness of tracked tasks and requirements,
correctness of behavior and scenario coverage, and coherence with design and
repository patterns. Map findings to code and test evidence. Apply the effective
delta contract from the test-quality reference, including removals and renames.

Accept previous verification only when its evidence covers the current relevant
implementation and artifacts. Otherwise execute verification. For an archived
change, verify using its preserved artifacts and current main specs; leave its
archive intact. Separate applicable checks lacking evidence from checks that the
schema makes inapplicable. Fix valid findings, explain false positives, and rerun
affected verification; disputed intent remains unresolved.

This readiness workflow requires completed implementation and resolved applicable
verification findings before archiving, even where native archive permits
warnings. Mark tracked tasks complete only when their work is demonstrated.
Preserve a concise verification report tied to the checked revision or diff.

The verification dimensions follow the official
[verify workflow](https://github.com/Fission-AI/OpenSpec/blob/main/src/core/templates/workflows/verify-change.ts).

## Sync, then archive

Inspect the owning change's delta specs against main specs for semantic sync.
Already-applied operations need no duplicate rewrite. Apply ADDED, MODIFIED,
REMOVED, and RENAMED operations while preserving unrelated content and scenarios.
Main specs contain requirements rather than delta operation headings. Preserve
existing authored Purpose text. A missing baseline for MODIFIED or RENAMED is a
blocker rather than an invented requirement. New capabilities require ADDED
requirements and a meaningful Purpose. Retirement of a whole capability follows
the installed workflow's explicit retirement rules and path checks.

Read current `openspec instructions specs --change <name> --json` rules before
main-spec writes when the installed CLI supports that contract. A failed required
lookup is a blocker. Validate main specs with `openspec validate --specs` and
compare every owned delta again to confirm the intended result.

Use the installed archive workflow to finish a completed active change; choose
sync when needed, since the user requested both actions. Routine archive/sync
confirmation is already authorized by invoking this skill. When executing inline,
wait for sync to finish and validate it before moving the change. Preserve all
artifacts and metadata, use the resolved archive destination, and check for a
collision before moving. An existing archive is inspected, not overwritten.
For inline archive, use the selected changes root's `archive/` directory and a
`YYYY-MM-DD-<change-name>` folder, retaining an existing date prefix. Check the
resolved source and destination stay within that planning root before moving.
Verify the resulting archive and synchronized specs, and include them in the PR.

For an already-archived change with missing sync, reconcile its owned deltas
against current main specs without replaying obsolete wording over subsequent
changes. Conflicting later changes require a contract decision. Preserve the
existing archive and validate the repaired specs. Multiple owned changes sharing
a capability are reconciled in their dependency order; ambiguous order is surfaced.

Native sync and archive behavior is documented in the official
[sync workflow](https://github.com/Fission-AI/OpenSpec/blob/main/src/core/templates/workflows/sync-specs.ts)
and [archive workflow](https://github.com/Fission-AI/OpenSpec/blob/main/src/core/templates/workflows/archive-change.ts).
Chat workflows such as `/opsx:verify` are not shell commands, and
`openspec validate` is not a substitute for behavioral verification.

Later code or test repairs invalidate affected verification evidence. Reverify
those areas before the final readiness verdict, even if the change is archived.
Report change names, verification findings and resolution, main-spec validation,
sync status, and archive paths. Failed sync leaves an active change unarchived.
