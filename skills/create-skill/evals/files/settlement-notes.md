# Settlement operating notes

Fictional evaluation fixture. These rules are authoritative for this test task.

Exports contain `partner`, `settlement_id`, `business_date`, `state`,
`expected_minor`, and `paid_minor`. Amounts are integer minor units in the
partner's settlement currency. Rows from different partners remain separate.

Compare rows whose state is `closed`. Other states are outside this report.
Use the exported `business_date`: the settlement service assigns the business day
after its cutoff, so deriving a date from a timestamp changes grouping.

The discrepancy is `paid_minor - expected_minor`. A row requires investigation
when the absolute discrepancy exceeds its partner's tolerance. Equal-to-tolerance
rows pass. Known tolerances are Atlas: 2 minor units; Cedar: 5 minor units.
An unknown partner's tolerance is missing input to resolve before classification.

The local CSV report contains partner, settlement_id, business_date,
discrepancy_minor, and status (`within_tolerance` or `investigate`). Sort by
business_date, partner, settlement_id. A report with no eligible rows retains
its headers and states that no closed settlements were present.

This workflow produces a local report. Source exports are read-only inputs.
Sending reports and changing settlement records are separate user requests.

Reviewer feedback from earlier work:

- Converting to floating-point major units misclassified boundary amounts.
- A single tolerance of 2 incorrectly flagged Cedar discrepancies of 3 through 5.
- Deriving business dates from timestamps assigned some settlements to the wrong day.
- Slides and draft emails added cost to requests that asked only for a CSV report.
