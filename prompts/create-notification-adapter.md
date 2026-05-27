# Create a FiveM Notification Adapter

Read `AGENTS.md` first.

Create a notification adapter resource named `<resource_name>`.

Requirements:

- Default to standalone with native GTA notifications.
- Do not require ox_lib unless explicitly requested.
- If optional `ox_lib` support is added, fall back safely to native notifications when `lib.notify` is unavailable.
- Put provider, command name, title, message, and debug mode in `config.lua`.
- Expose a clear client export such as `notify(data)`.
- Validate export input types before using title, description, or notification type.
- Add a test command such as `/testnotify`.
- Do not add server logic unless needed.
- Do not handle money, items, jobs, permissions, weapons, or database records.
- Include `README.md` with export usage, ensure order for consumer resources, configuration, testing, dependencies, and safety notes.

After editing:

- Show created files.
- Run a Lua syntax check if available.
- Respond in Japanese using the required AGENTS.md final format.
