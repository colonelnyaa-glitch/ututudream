# Review a FiveM Resource

Read `AGENTS.md` first.

Review the FiveM resource at `<resource_path>`.

Check in this order:

- folder/resource name
- `fxmanifest.lua`
- file loading order
- missing files
- Lua syntax issues
- client/server separation
- event names
- framework assumptions
- config usage
- unsafe server events
- README accuracy

Report:

- what works
- what may break
- unsafe event handling
- framework or dependency assumptions
- missing config values
- missing dependencies
- minimal recommended fixes

Rules:

- Do not modify files unless explicitly asked.
- Do not rewrite the resource.
- If a syntax check cannot be run, say so clearly.
- Respond in Japanese using the AGENTS.md review format.
