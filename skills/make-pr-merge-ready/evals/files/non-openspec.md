# Repository without OpenSpec fixture

PR #74 targets `release`. This repository has no OpenSpec installation or change
artifacts. Its public API documentation and existing valid regressions define the
contract. A changed test asserts incidental diagnostic wording; a retained test
asserts a documented stable error code. They must receive different treatment.

An expected lint check has failed since before this PR, but the cause is within
the scoped changed module and can be fixed. After the first repair and push, a
bot discovers an observable empty-input defect. The adapter provides that new
comment only after the push; a second push triggers final checks.

One optional CI job returns neutral by documented policy for this PR's path set.
All required jobs run and pass at the final head. Required approvals are current,
the PR is open, non-draft, mergeable, and up to date. One old thread is resolved;
one incorrect unresolved comment receives evidence without approval dismissal.
