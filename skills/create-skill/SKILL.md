---
name: create-skill
description: Create a new Agent Skill in .cursor/skills/ following the agentskills.io specification. Use when the user asks to create, author, or scaffold a skill, or when a repeatable workflow emerges from conversation.
disable-model-invocation: true
---

# Create Skill

Scaffold a new skill in `.cursor/skills/` per the [agentskills.io spec](https://agentskills.io/specification).

## Workflow

### Step 1: Gather

1. Extract context from the current conversation first — tools used, sequence of steps, corrections the user made, input/output formats observed.
2. Infer the skill's purpose, scope, and triggers from extracted context.
3. Ask the user only when purpose, scope, or triggers remain ambiguous:
   - What should this skill enable the agent to do?
   - When should it trigger? (phrases, contexts, file types)
   - What is the expected output format?
4. Identify supporting files needed (scripts, references, assets).

### Step 2: Design

1. Derive the name: lowercase, hyphens, max 64 chars, task-descriptive.
2. Write the description: third-person, WHAT it does + WHEN to activate, max 1024 chars (~100 tokens).
   - List adjacent trigger terms generously — agents under-trigger by default.
   - Include near-miss phrases a user might say instead of the exact skill name.
   - Cover both formal and casual phrasings.
3. Outline body sections.

**Description examples:**

| Quality | Example |
|---------|---------|
| Weak | "Creates unit tests." |
| Strong | "Writes unit tests for Python code using pytest. Use when the user asks to write, add, or create tests, test a function, or improve test coverage. Not for integration tests." |

### Step 3: Create

1. Create `.cursor/skills/<name>/SKILL.md` with frontmatter and body.
2. Create supporting files for content that exceeds the body budget or that every invocation would reproduce:
   - `references/REFERENCE.md` for detailed documentation (>50 lines of reference content)
   - `scripts/` for executable utilities (logic every invocation would otherwise regenerate)
   - `assets/` for templates and static resources (boilerplate varying only by substitution)

### Step 4: Validate

1. Confirm body is under 500 lines and under 5000 tokens.
2. Confirm description includes WHAT and WHEN clauses.
3. Confirm file references are one level deep from SKILL.md.
4. Confirm terminology is consistent throughout.

### Step 5: Review

1. Draft 2-3 realistic user prompts that should trigger this skill.
2. Walk through the skill instructions against each prompt — verify the steps produce the intended output.
3. Read the skill with fresh eyes and tighten: remove instructions that add no value, consolidate redundant steps.
4. Present the draft to the user for approval.

## Frontmatter

```yaml
---
name: <lowercase-hyphenated-name>
description: <What it does>. <When to use it>.
---
```

| Field | Rules |
|-------|-------|
| `name` | 1-64 chars · lowercase alphanumeric + hyphens · matches directory name · no leading/trailing/consecutive hyphens |
| `description` | 1-1024 chars · third-person · specific trigger terms · WHAT + WHEN |

## Body Sections

Use applicable sections:

| Section | Content | Voice |
|---------|---------|-------|
| `## Workflow` / `## Instructions` | Step-by-step procedure | Imperative (verb-first) |
| `## Focus Areas` | Priorities to examine | Declarative |
| `## Guardrails` | Behavioral boundaries and validation rules | Declarative, affirmative |
| `## Output` | Expected deliverable format | Declarative |

## Writing Rules

1. Begin every procedural line with a verb (imperative mood).
2. Write guardrails as affirmative declarations ("Keep X under Y" rather than "X should not exceed Y").
3. Use affirmative prose throughout ("Ensure X" rather than "Avoid missing X").
4. Assume the agent knows general programming; supply only domain-specific or project-specific context.
5. Justify every token's presence; remove anything that adds no value.
6. Use one term per concept throughout (no synonyms for the same entity).
7. Explain the reasoning behind constraints rather than relying on rigid ALWAYS/NEVER directives — agents follow instructions better when they understand the intent.
8. Write for generality — instructions run against many prompts, not just the examples tested during authoring.

## Progressive Disclosure

| Layer | Budget | Loads |
|-------|--------|-------|
| Metadata | ~100 tokens | At startup for all skills |
| Body | <5000 tokens | On skill activation |
| Resources | As needed | On explicit reference |

Move examples, templates, and detailed reference material to separate files. Keep references one level deep.

## Guardrails

- Body stays under 500 lines and under 5000 tokens.
- `name` field matches the directory name exactly.
- Description is third-person with specific trigger terms.
- All prose uses affirmative language.
- File references remain one level deep from SKILL.md.
- Scripts are self-contained with documented dependencies.
- One term per concept throughout the skill (no synonyms for the same entity).
