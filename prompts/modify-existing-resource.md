# Modify Existing FiveM Resource

Use this prompt when modifying or evolving an existing FiveM resource or a specific file.

## Target
- Resource or file:
- Relevant framework, if any:
- Existing behavior to preserve:

## Goal
Describe the exact change needed and why it is needed.

Start with review-only. Inspect the existing code, explain the current behavior, identify the safest change, and wait for approval before modifying files unless modification was explicitly requested in the same task.

## Requirements
- Keep the change scoped to the stated target.
- Preserve existing APIs, exports, commands, events, config names, and database schema unless a breaking change is explicitly requested.
- Reuse existing project patterns and helpers.
- Update README only if behavior changes.

## Do Not
- Do not rewrite unrelated code.
- Do not refactor unrelated structure.
- Do not add dependencies unless explicitly requested.
- Do not add server events unless necessary.
- Do not trust client-provided values.
- Do not add money, items, weapons, job changes, permissions, or database logic unless explicitly requested and safely validated server-side.

## Compatibility
- Keep compatibility with the existing fxmanifest, framework version, database driver, inventory, targeting, menu, and notification systems.
- If compatibility cannot be preserved, explain the tradeoff before changing code.

## Verification
- Show the diff.
- Run a Lua syntax check for changed Lua files.
- Explain the safety impact, including server-side validation and any client trust boundaries.
- Note any checks that could not be run.

## Output Format
1. Review summary
2. Proposed change
3. Files changed
4. Diff
5. Verification results
6. Safety impact
