---
name: what-did-i-get-done
description: Summarizes shipped work over a user-specified time period using git commits, Linear issues, and Cursor chat history. Use when preparing updates or reflecting on completed work.
disable-model-invocation: true
---

# What did I get done

## Trigger

Need a clear, readable summary of work completed in a specific time range (e.g. yesterday, last 3 days, since Friday).

## Workflow

### 1. Resolve the time window
Convert the user's request into concrete start/end dates (inclusive). Today's date is provided in system context.

### 2. Identify the target author
Resolve the user's git author email before anything else:
```
git config user.email
```
Use this email in the `--author` flag for all git queries. Always filter by author email — pulling unfiltered commits will include teammates' work. If the user specifies a name/handle (e.g. "I uzair-snap"), cross-check it against the config email to confirm the right identity.

### 3. Pull Linear issues (preferred source of intent)
- Authenticate the Linear MCP if needed: call `mcp_auth` for server `plugin-linear-linear` with empty args
- After auth, use Linear MCP tools to fetch completed/done issues assigned to the current user within the date range
- Linear issues provide the "why" — the user-facing feature or bug being addressed

### 4. Pull git commits (author-filtered)
Run with the resolved email baked into the command:
```
git log --since='YYYY-MM-DD 00:00' --until='YYYY-MM-DD 23:59' --no-merges --author='<resolved email>' --pretty=format:'%H%x09%ad%x09%s' --date=short
```
For each significant commit inspect changed files with:
```
git show --name-only --pretty=format:'%h %ad %s' --date=short <hash>
```
- Exclude ruff/lint-only commits (subject is exactly "ruff" or similar)

### 5. Deepen with Cursor chat history
- The agent transcript folder path is provided in the `<agent_transcripts>` block of the system context at the start of every conversation — use that path directly rather than hardcoding it
- List all folders in that directory sorted by modification time; read every transcript that falls within the date range
- For each transcript, read **both** the first user message (to understand what was asked) and the final assistant message (to understand what was delivered)
- Skip transcripts where the user message is a cursor_commands automation prompt with no human-readable query
- Use chats to surface shipped things that don't appear clearly in commit messages alone

### 6. Synthesize the output
Cross-reference Linear issues, commits, and chat history to produce the final summary:
- Group related items under a short descriptive header (e.g. "Canvas bugs", "Drawer interactions") rather than one flat list
- Separate pure code-health / refactoring work into its own **Code health** section at the end. Keep refactoring summaries brief.
- Prefix each bullet with a label in square brackets — prefer the Linear issue label when one exists (`Bug`, `Feature`, `Improvement`, `Chore`); if none, pick the closest match (`Bug` for defects, `Improvement` for UI/UX polish, `Feature` for new capability, `Chore` for cleanup)
- Lead each bullet with the user-visible problem or behaviour change, not the implementation mechanism
- Explain *why it matters* in plain language — name internal constructs (nonces, handlers, state classes) only when they are the sole way to be concrete
- One bullet per distinct shipped thing — dedicate each bullet to a single change

## Guardrails

- **Author-only** — include only commits from the resolved author email
- **Readable over dense** — each bullet should be a sentence a non-technical stakeholder can follow
- **Why over what** — explain the problem solved or behaviour change, not the implementation mechanism
- **Concrete over vague** — name the feature, the bug, the behaviour that changed
- **Module names sparingly** — name a module only when it genuinely aids understanding
- **Omit cosmetic changes** — formatting, ruff passes, import reorders, minor renames
- **Evidence-based** — describe only what is confirmed by commits, Linear, or chat history
- **One thing per bullet** — dedicate each bullet to a single shipped item

## Output

**Date range:** _start_ – _end_

**[Thematic group, e.g. "Canvas bugs"]**
- [Bug] **[Fix/Feature name]** — what changed and why it matters. One sentence.
- [Improvement] **[Fix/Feature name]** — what changed and why it matters. One sentence.

**[Next group]**
- _(repeat)_

**Code health** — Super summarised bullet point of any refactoring, test improvements, or structural cleanup. Only include if there is genuine code-health work.

Keep the whole thing Slack-pasteable. Use bold headers to group, single-level bullets only, no code blocks.
