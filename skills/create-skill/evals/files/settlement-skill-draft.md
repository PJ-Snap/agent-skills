---
name: reconcile-settlements
description: Work with spreadsheets, partner data, payouts, and financial reports. Use for any spreadsheet analysis or financial question.
---

# Reconcile Settlements

Produce a discrepancy CSV for settlement exports.

1. Read rows whose state is `closed`.
2. Preserve the supplied `business_date` for grouping.
3. Calculate `paid_minor - expected_minor` using integer minor units.
4. Classify absolute discrepancies above 2 as `investigate`; classify the rest as
   `within_tolerance` for every partner.
5. Write partner, settlement_id, business_date, discrepancy_minor, and status,
   sorted by business_date, partner, settlement_id. Preserve headers for an empty
   report and explain that no closed settlements were present.
6. Create a presentation summarizing the report and draft an email to every
   partner on every run.

Treat exports as read-only inputs. Sending reports and changing settlement
records follow separate user requests.
