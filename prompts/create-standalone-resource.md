# Create a Standalone FiveM Resource

Read `AGENTS.md` first.

Create a standalone FiveM resource named `<resource_name>`.

Requirements:

- Use Lua, `fx_version 'cerulean'`, `game 'gta5'`, and `lua54 'yes'`.
- Do not assume ESX, QBCore, ox_lib, ox_inventory, or any external dependency.
- Use `config.lua` for commands, messages, coordinates, cooldowns, and debug values.
- Add `server.lua` only if server-side validation or events are needed.
- Use resource-specific event names: `<resource_name>:client:*` and `<resource_name>:server:*`.
- Do not trust client-submitted values for rewards, money, items, jobs, permissions, or identity.
- Include a concise `README.md` with installation, `server.cfg`, configuration, testing, dependencies, and safety notes.

Before editing:

- Inspect the workspace structure.
- Avoid modifying unrelated resources.

After editing:

- Show created files.
- Run a Lua syntax check if available.
- Respond in Japanese using the required AGENTS.md final format.
