---
name: catch-up
description: Compare recent user edits with the agent's last known changes after review cycles, refresh stale repository context, and raise potential issues before continuing.
---

# Catch Up

Refresh context after the user has changed files, switched direction, or modified work the agent previously produced. Use this before continuing implementation when the user says they reviewed and changed something, asks whether the agent can compare against the previous turn, asks the agent to catch up, or stale context is likely.

The core job is to compare the current file contents with the agent's last known version from the prior turn, then call out concrete behavioral or implementation conflicts. Example: if the user changes an AI prompt from four MCQ options to three options, check related validation and prompt instructions for code that still expects four options, then report the mismatch.

This skill must not rely only on Git. Git diffs are useful and should normally be checked first, but they miss important cases when changes are already staged/committed or when the user wants comparison against the agent's last known file contents rather than repository state.

## Workflow

1. Identify likely changed files:
   - Ask the user which files they edited if it is not obvious.
   - Prioritize files the agent recently read or wrote in the conversation.
   - Prioritize files relevant to the requested next task.
   - Use lightweight file inspection commands such as `find`, `ls`, or targeted reads when needed.
   - `wc -l -c` or timestamps may be used only as quick hints, not as proof of what changed.
   - If the user names a file imprecisely, search for the likely exact path and mention the resolved filename.

2. Inspect Git state:
   - Run `git status --short`.
   - Identify modified, staged, untracked, deleted, and renamed files.
   - Do not assume all changes were made by the agent.

3. Review Git diffs when useful:
   - Run `git diff` for unstaged changes.
   - Run `git diff --cached` when staged files exist.
   - Focus on files related to the current task or files changed since the last agent action.
   - Treat Git diff as one source of evidence, not the only source.

4. Re-read current source files:
   - Use `read` for files that affect the requested work.
   - Always prefer current file contents over memory from previous turns.
   - Re-read files before editing them if the user may have changed them.
   - Check related DTOs, schemas, tests, modules, and service/controller wiring when applicable.

5. Compare against the agent's last known contents when possible:
   - Compare the current file contents to the exact content the agent previously read or wrote in the conversation.
   - Use content-based comparison, not just line counts or byte counts.
   - Detect changes to existing lines, additions, deletions, reordering, and same-length edits when the prior content is available in context.
   - If the previous exact content is no longer available or the file is too large to compare reliably, say so and summarize only what can be verified from the current file/Git state.
   - For recently written files, explicitly check whether the current content still matches what the agent wrote.
   - Pay special attention to changed constants, prompts, DTO fields, route names, schema fields, enum values, validation rules, and service logic.
   - Search related files for assumptions that may now conflict with the user's changes.

6. Update the working understanding:
   - Summarize what changed in concise bullets.
   - Distinguish between:
     - verified Git changes,
     - verified content differences from the agent's last known version,
     - current file facts that could not be compared to a baseline.
   - Call out API signatures, route names, model fields, DTO fields, or behavior that differs from prior assumptions.
   - Raise potential issues caused by mismatches between the user's changed file and related code.
   - Mention build/test status only if verified.

7. Continue safely:
   - Preserve user changes.
   - Base all new edits on the latest file contents.
   - If user changes conflict with the requested next step, ask a focused clarification before editing.

## Safety Rules

- Do not modify files while catching up unless the user also asks for an implementation change.
- Do not stage, commit, reset, checkout, or discard changes.
- Never overwrite user edits to restore prior agent output unless explicitly requested.
- Avoid destructive Git commands.
- Do not rely only on `git diff`; direct file re-read and prior-content comparison are required when relevant.
- Do not rely only on `wc`, file size, or timestamps; they are hints only.
- Keep the summary factual; do not infer intent beyond the diff, current file contents, and known prior contents.

## Output Format

Use a concise response with these sections when helpful:

- `Current State`
- `Detected Changes`
- `Potential Issues`
- `Verified`

In `Detected Changes`, separate sources when useful:

- `Git diff`
- `Compared with last known agent version`
- `Current file facts`

If there are no concerns, say so briefly.
