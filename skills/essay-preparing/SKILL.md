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
- Include Writing under every claim, plus Introduction and Conclusion sections; leave every sentence prompt unfinished for the user to complete.
- Deliver the final outline as plain text for paste into a word processor: no markdown headings, bold, links, or blockquotes. Use ALL-CAPS section labels, plain numbers, and full URLs in parentheses.
- Put a blank line after every section label, between every sentence prompt, after every source, and between claims. Dense blocks of text without blank lines are unusable.
- Under each claim, YOUR NOTES lists short fragments copied from the user's brain dump (trim only for placement). Do not paraphrase or rewrite them.



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

One claim = one Why. If Why needs two answers, write two claims.

### 4. Order the claims

Arrange claims in the sequence that best serves the thesis. Prefer:

1. What the reader must accept first
2. Dependencies (B only lands after A)
3. Escalation or narrowing toward the strongest point
4. Necessary contrast / objection only if it clarifies the claim that follows

State the ordering rationale in one short paragraph (why this sequence, not another).

### 5. Research and present sources under each claim

Find sources that could support, complicate, or sharpen each claim. Put them **directly under that claim** so claim, dump fragments, and sources read as one unit. Present for **review**, not as mandatory citations.

**Default citation style:** plain text — title, full URL in parentheses, relevance, and a quote. No MLA/APA/Chicago unless the user asks.

For each source:

1. **Open and read it** (fetch the page / transcript). Do not cite from titles or snippets alone.
2. Title + link
3. Why it might help (evidence, counterpoint, vivid example, authority) — one line
4. **Quote:** the single most relevant passage, verbatim, short (1–3 sentences). Pick the line that most directly supports, complicates, or sharpens *this claim* — not a generic lede or abstract.
5. Confidence: high / medium / low (how well it actually fits)

If you cannot access the full text, say so and either replace the source or mark confidence low with no invented quote.

**Source preference**

- Cite operator writing: Substack, personal blogs, LinkedIn posts, founder/practitioner essays, interview transcripts — people describing what they did or observed.
- Use a vendor or product post only when it is the primary artifact under discussion; label it `vendor` and keep searching for an operator source.

Background sources that don't attach cleanly to one claim go in a short **Background / optional** list after the outline — keep that list rare. Same quote rules apply.

## Output template

Use this shape every time (plain text, word-processor ready). Blank lines shown below are required — keep them.

```text
SPINE

Question: …

Answer: …


INTRODUCTION

Context → We are entering a period where...

Change → Historically..., but now...

Problem → This creates a problem because...

Question → The important question is...

Thesis → This essay argues that...

Roadmap → To show this, I will argue that...


CLAIM OUTLINE (in order)


1. [Claim]

NOTES

- …

- …

Sources:

- Title (https://…) — relevance. Confidence: …
  Quote: "Verbatim quote most relevant to this claim."

- Title (https://…) — relevance. Confidence: …
  Quote: "…"

Writing:

Claim → The point I am trying to prove is...

Why → This is true because...

Example → A good example of this is...

Evidence → Evidence for this can be seen in...

Interpretation → This tells us that...

So what → This matters because...

Thesis connection → This supports my overall argument because...


2. [Claim]


NOTES:

- …

Sources:

- …

Writing:

Claim → The point I am trying to prove is...

Why → This is true because...

Example → A good example of this is...

Evidence → Evidence for this can be seen in...

Interpretation → This tells us that...

So what → This matters because...

Thesis connection → This supports my overall argument because...


ORDERING RATIONALE

…


CONCLUSION

Answer → Ultimately...

Main finding → The argument presented here shows that...

Synthesis → Taken together, these points suggest that...

Implication → This means that...

Why it matters → The broader significance is...

Final thought → …


PARKED

- … (idea + why it's out for now)


BACKGROUND / OPTIONAL

- … (only if needed; include quote)
```

After delivering this, ask what to adjust (merge/split claims, reorder, drop parked items, dig deeper on a source). Do not start drafting. Do not complete any sentence prompts.