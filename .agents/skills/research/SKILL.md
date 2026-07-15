---
name: research
description: Researches user specs from direct input or a spec file, then reports impacted areas by priority and complexity with side notes for unrelated issues found.
---

# Research

Research a user's requested spec before implementation. Use the user's direct input or
an referenced spec file as the source of truth, inspect the repository, and report the
impacted areas in priority order with complexity called out.

## Workflow

1. Identify the spec source:
   - Use the user's prompt when the spec is provided directly.
   - Read the referenced spec file when the user provides a path.
   - If the spec source is ambiguous, ask a short clarification before researching.

2. Understand the spec:
   - Extract the requested behavior, constraints, acceptance criteria, and implied
     non-goals.
   - Note dependencies on existing features, modules, data models, APIs, or UI flows.
   - Keep the user's stated requirements separate from assumptions.

3. Inspect impacted code and project context:
   - Search for files, modules, schemas, services, controllers, components, tests,
     documentation, configuration, and scripts likely affected by the spec.
   - Follow references far enough to understand integration points and risks.
   - Do not modify files while researching.

4. Prioritize impacted areas:
   - Order areas by implementation priority, with the highest-priority area first.
   - Break ties by complexity, placing the more complex area first.
   - For each area, include:
     - Impacted area name.
     - Priority: `High`, `Medium`, or `Low`.
     - Complexity: `High`, `Medium`, or `Low`.
     - Why the area is impacted.
     - Files grouped one-by-one with the expected changes inside each file group.
     - New snippets only when introducing new code.
     - `diff` snippets when describing modifications to existing code.
     - Short implementation comments when exact code is unnecessary, such as
       `// Insert a function that validates the generated set owner.`
     - Key risks, open questions, or dependencies.

5. Capture unrelated findings:
   - Add a final `Side Notes` section for unrelated issues noticed during research.
   - Include only meaningful issues that could affect correctness, safety,
     maintainability, or future work.
   - Keep side notes concise and clearly marked as unrelated to the requested spec.

6. Write the research file:
   - Derive a short kebab-case topic from the spec, such as `live-session`.
   - Write the final research output to `<topic>.research.md` in the repository
     root unless the user requests a different directory.
   - After writing the file, respond with the created file path only unless the
     user asks for the full contents in chat.

## Safety Rules

- Do not modify files while researching.
- Do not stage, commit, reset, checkout, or otherwise alter repository state.
- Do not use destructive git commands.
- Do not invent impacted areas or issues.
- Do not treat assumptions as requirements; label them as assumptions or questions.
- Skip minor style preferences unless they affect clarity, safety, correctness, or
  maintainability.

## File Output

- Write research results to `<topic>.research.md`.
- Use kebab-case for `<topic>`.
- Place the file in the repository root unless the user specifies another path.
- If the topic is ambiguous, ask for clarification or choose the shortest clear
  topic from the spec.

## Document Format

- `## Spec Summary`
- A concise summary of the requested spec and source used.
- `## Impacted Areas`
- `### <priority-number>. <area name>`
- `Priority: High|Medium|Low`
- `Complexity: High|Medium|Low`
- `Impact: <why this area is affected>`
- `Files / Expected Changes:`
- `#### <path/to/file>`
- A short description of the expected change in that file.
- For existing-code modifications, include a concise fenced `diff` snippet.
- For new code, include only the new snippet or a concise implementation comment.
- Do not list all files separately from proposed changes; keep each file path and
  its expected changes together.
- `Risks / Questions: <short list or None>`
- `## Side Notes`
- Concise bullets for unrelated issues found during research, or `No unrelated issues found.`
