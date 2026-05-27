# Create a QBCore FiveM Resource

Read `AGENTS.md` first.

Create a QBCore resource named `<resource_name>`.

Requirements:

- Document `qb-core` as a required dependency.
- Ensure `qb-core` starts before this resource.
- Use `exports['qb-core']:GetCoreObject()` only after checking `qb-core` is available.
- Use `QBCore.Functions.GetPlayer(source)` on the server for player data.
- Check that QBCore, `QBCore.Functions`, and `QBCore.Functions.GetPlayer` exist before use.
- If QBCore is unavailable, send a safe player message and print a clear server warning.
- Never trust client-submitted job, grade, money, item, weapon, or permission values.
- Do not add money, items, weapons, job changes, grade changes, permissions, or database logic unless explicitly requested and safely validated.
- Use resource-specific event names.
- Include `README.md` with dependencies, ensure order, configuration, testing, and safety notes.

After editing:

- Show created files.
- Run a Lua syntax check if available.
- Respond in Japanese using the required AGENTS.md final format.
