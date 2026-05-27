# Apply the Smallest Safe Hardening Fix

Read `AGENTS.md` first.

Apply the smallest safe hardening fix to `<resource_path>` for this issue:

```text
<issue_or_risk>
```

Rules:

- Inspect the current resource structure first.
- Read existing `README.md`, `config.lua`, `fxmanifest.lua`, client files, and server files as needed.
- Do not change unrelated behavior.
- Do not rewrite the resource.
- Prefer server-side validation, cooldowns, resource-specific event names, and safe fallbacks.
- Do not add dependencies unless absolutely required and documented.
- Keep config values configurable when users may need to tune them.
- Update README only if behavior, setup, config, dependencies, or safety notes changed.

After editing:

- Show changed files.
- Run a Lua syntax check if available.
- Explain the risk fixed and why the change is minimal.
- Respond in Japanese using the required AGENTS.md final format.
