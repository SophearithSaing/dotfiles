---
name: catch-up
description: Refresh stale repository context after the user has made changes between turns, especially when earlier agent assumptions may no longer match the working tree.
---

# Catch Up 

Refresh context after the user has changed files, switched direction, or modified work the agent previously produced. Use this before continuing implementation when the user says they made changes, asks the agent to catch up, or stale context is likely.

## Workflow

1. Inspect repository state:
   - Run `git status --short`.
   - Identify modified, staged, untracked, deleted, and renamed files.
   - Do not assume all changes were made by the agent.

2. Review relevant diffs:
   - Run `git diff` for unstaged changes.
   - Run `git diff --cached` when staged files exist.
   - Focus on files related to the current task or files changed since the last agent action.

3. Re-read current source files:
   - Use `read` for files that affect the requested work.
   - Prefer current file contents over memory from previous turns.
   - Check related DTOs, schemas, tests, modules, and service/controller wiring when applicable.

4. Update the working understanding:
   - Summarize what changed in concise bullets.
   - Call out API signatures, route names, model fields, DTO fields, or behavior that differs from prior assumptions.
   - Mention build/test status only if verified.

5. Continue safely:
   - Preserve user changes.
   - Base new edits on the latest file contents.
   - If changes conflict with the requested next step, ask a focused clarification before editing.

## Safety Rules

- Do not modify files while catching up unless the user also asks for an implementation change.
- Do not stage, commit, reset, checkout, or discard changes.
- Never overwrite user edits to restore prior agent output unless explicitly requested.
- Avoid destructive git commands.
- Keep the summary factual; do not infer intent beyond what the diff and files show.

## Output Format

Use a concise response with these sections when helpful:

- `Current State`
- `Notable Changes`
- `Potential Issues`
- `Verified`

If there are no concerns, say so briefly.
