# Create an ESX FiveM Resource

Read `AGENTS.md` first.

Create an ESX resource named `<resource_name>`.

Requirements:

- Document `es_extended` as a required dependency.
- Ensure `es_extended` starts before this resource.
- Target ESX Legacy export-based shared object access unless told otherwise.
- Use `exports['es_extended']:getSharedObject()` safely.
- Use `ESX.GetPlayerFromId(source)` on the server for player data.
- Check that ESX, `ESX.GetPlayerFromId`, and any xPlayer methods are available before use.
- If ESX is unavailable, send a safe player message and print a clear server warning.
- Never trust client-submitted job, grade, money, item, weapon, or permission values.
- Do not add money, items, weapons, job changes, grade changes, permissions, or database logic unless explicitly requested and safely validated.
- Use resource-specific event names.
- Include `README.md` with dependencies, ensure order, configuration, testing, and safety notes.

After editing:

- Show created files.
- Run a Lua syntax check if available.
- Respond in Japanese using the required AGENTS.md final format.
