---
name: create-pr
description: Creates a Pull Request using GitHub CLI, drafting a detailed description based on changes. Use when finishing a feature or fix to submit code for review.
---

# Create Pull Request

Create a Pull Request that summarizes the current branch clearly and avoids submitting anything before the user approves the title and body.

## Workflow

1. Analyze the current branch:
   - Review the staged and committed changes in the current branch.
   - Generate the PR content based on the current branch's commit history and file modifications.

2. Draft the PR title and body:
   - Draft a concise PR description following the project's standards.
   - Include a `Description` section that summarizes what changed.
   - Include a `Summary of Changes` section with a short bulleted list.
   - Use verb + subject summary bullets, such as `Add {modelName}`, `Remove {fileName}`, or `Refactor {serviceName}`.
   - List added changes before modified changes.

3. Get approval before creating the PR:
   - Show the PR title and body to the user.
   - Wait for explicit user approval before running `gh pr create`.

4. Create the Pull Request:
   - Save the approved PR body to a temporary file.
   - Run `gh pr create --title "<Title>" --body-file <temp-file>`.

5. Clean up temporary files:
   - Delete the temporary PR description file with `rm <temp-file>`.

## Safety Rules

- Do not create a Pull Request until the user explicitly approves the final title and body.
- Do not include unrelated changes in the PR description.
- Do not modify commits, branches, or working tree files while creating the PR.
- Prefer non-interactive GitHub CLI commands.
