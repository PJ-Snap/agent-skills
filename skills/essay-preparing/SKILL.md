---
name: essay-preparing
description: Turn an essay question, short answer, and brain dump into grouped claims in logical order, plus sources for review. Does not draft the essay. Use when the user invokes essay-preparing, wants to outline or prepare an essay, or asks to structure ramblings into claims before writing.
---

# Essay Preparing

Help the user through the **preparing** stage only: organize ideas into claims, order them, and surface sources. Then stop.

## Hard rules

- **Never write the essay.** No paragraphs, no intro/body/conclusion prose, no "here's a draft," no ghostwriting sentences they could paste.
- **Never rewrite their voice.** Do not polish their 1–2 sentence answer into essay prose.
- Output is structure and research for *their* review — they write next.

## Required inputs

If any are missing, ask once for what's missing, then proceed:

1. **Essay question** (prompt or topic they're answering)
2. **1–2 sentence answer** (their thesis / core take)
3. **Brain dump** (messy notes, tangents, examples — anything potentially relevant)

Optional: audience, length target, or "must include / must avoid."

## Workflow



### 1. Restate the spine

In 2–3 lines, restate:

- the question they're answering
- their core answer (keep their meaning; tighten only for clarity of structure)

Flag if the brain dump pulls away from the answer. Ask whether to narrow or revise the answer before grouping.

### 2. Group related ideas

From the brain dump:

- Cluster related points, examples, and asides
- Drop or park noise (duplicates, off-thesis tangents) in a short **Parked** list — do not discard silently
- Prefer fewer strong groups over many thin ones



### 3. Turn each group into a claim

Each group becomes **one claim**, not a topic label.


| Weak (topic)   | Strong (claim)                                                   |
| -------------- | ---------------------------------------------------------------- |
| "Remote work"  | "Remote work fails when trust is replaced by surveillance."      |
| "History of X" | "X's history shows Y, which undermines the usual story about Z." |


Claims should be:

- **Contestable** — someone thoughtful could disagree
- **Useful** — true, important, and as strong as honesty allows ([Paul Graham](https://paulgraham.com/useful.html): useful writing is bold but true; avoid vague correctness)
- **Sayable** — something they'd say out loud to a friend ([Jason Fried](https://tryathens.com/blog/jason-fried-writing-advice): clear writing = clear thinking; just say it)

One claim per group. If a group needs two claims, split the group.

### 4. Order the claims

Arrange claims in the sequence that best serves the thesis. Prefer:

1. What the reader must accept first
2. Dependencies (B only lands after A)
3. Escalation or narrowing toward the strongest point
4. Necessary contrast / objection only if it clarifies the claim that follows

State the ordering rationale in one short paragraph (why this sequence, not another).

### 5. Research and present sources for review

Find sources that could support, complicate, or sharpen each claim. Present for **review**, not as mandatory citations.

**Default citation style (Substack):** informal links — title, URL, and one line on relevance. No MLA/APA/Chicago unless the user asks.

For each source:

- Claim it relates to (or "general background")
- Title + link
- Why it might help (evidence, counterpoint, vivid example, authority)
- Confidence: high / medium / low (how well it actually fits)

Prefer primary or high-signal sources over SEO fluff. Mark weak or contested sources honestly.

## Output template

Use this shape every time:

```markdown
## Spine
- Question: …
- Answer: …

## Claim outline (in order)
1. **[Claim]**
   - From dump: (bullet fragments that belong here)
2. **[Claim]**
   - From dump: …

## Ordering rationale
…

## Parked
- … (idea + why it's out for now)

## Sources for review
### For claim 1
- [Title](url) — relevance. Confidence: …

### For claim 2
- …

### Background / optional
- …
```

After delivering this, ask what to adjust (merge/split claims, reorder, drop parked items, dig deeper on a source). Do **not** start drafting.

