# FiveM Codex Test Project

## Project Purpose

This repository is a small FiveM resource test workspace for Codex-assisted development.
It contains simple, readable resources that demonstrate safe standalone patterns, notification adapters, marker and blip logic, and guarded framework-specific job checks.

The project is intended for local testing, resource structure validation, and incremental FiveM scripting practice. It is not a production server pack.

## Resource List

| Resource | Type | What it does |
| --- | --- | --- |
| `standalone_test` | Standalone | Adds `/standalonetest`, shows a client notification, and optionally pings the server with a safe cooldown-protected event. |
| `msc_notify_adapter_test` | Standalone-compatible | Adds `/testnotify` and exposes a client `notify` export that can use native notifications or optional `ox_lib` notification fallback logic. |
| `msc_notify_consumer_test` | Standalone consumer | Adds `/consumernotify` and calls the `notify` export from `msc_notify_adapter_test`. |
| `msc_marker_blip_test` | Standalone | Shows one configurable map blip and one world marker with nearby help text. |
| `msc_multi_marker_test` | Standalone | Shows multiple configurable markers and blips, with client-only interaction notifications. |
| `msc_qb_job_check_test` | QBCore | Adds `/qbjobcheck`; the server safely reads the player's QBCore job and returns display-only job information. |
| `msc_esx_job_check_test` | ESX | Adds `/esxjobcheck`; the server safely reads the player's ESX job and returns display-only job information. |

## Dependencies

Most resources are standalone and do not require ESX, QBCore, ox_lib, ox_inventory, or a database.

Required dependencies:

- `msc_notify_consumer_test` requires `msc_notify_adapter_test` to be started first.
- `msc_qb_job_check_test` requires `qb-core`.
- `msc_esx_job_check_test` requires `es_extended`.

Optional dependency:

- `msc_notify_adapter_test` can use `ox_lib` notifications if `Config.NotifyProvider = 'ox_lib'` and `lib.notify` is available. It falls back to native notifications when unavailable.

## Recommended Ensure Order

For standalone-only testing:

```cfg
ensure standalone_test
ensure msc_notify_adapter_test
ensure msc_notify_consumer_test
ensure msc_marker_blip_test
ensure msc_multi_marker_test
```

For QBCore testing:

```cfg
ensure qb-core
ensure msc_qb_job_check_test
```

For ESX testing:

```cfg
ensure es_extended
ensure msc_esx_job_check_test
```

If testing everything in one server profile, keep framework resources before their dependent test resources:

```cfg
ensure qb-core
ensure es_extended

ensure standalone_test
ensure msc_notify_adapter_test
ensure msc_notify_consumer_test
ensure msc_marker_blip_test
ensure msc_multi_marker_test
ensure msc_qb_job_check_test
ensure msc_esx_job_check_test
```

Only ensure `qb-core` or `es_extended` if those frameworks are actually installed in that server.

## Safety Policy

Resources in this project should stay small, explicit, and safe.

- Do not add hidden behavior, obfuscated code, token logging, private data collection, or suspicious network requests.
- Do not create cheat menus, anti-cheat bypasses, ban evasion tools, griefing tools, or server crash tools.
- Do not trust client-submitted money, items, job, grade, permissions, vehicle ownership, rewards, or identity.
- Keep money, item, permission, database, job, and reward validation on the server.
- Use resource-specific event names such as `resource_name:server:action`.
- Add cooldowns or validation to server events that can be called by clients.
- Do not add external dependencies unless the resource clearly needs them and the README documents them.

## How To Test

1. Copy the desired resource folders into your FiveM server resources folder.
2. Add the matching `ensure` lines to `server.cfg`.
3. Start the server and join in-game.
4. Test the commands:

```text
/standalonetest
/testnotify
/consumernotify
/qbjobcheck
/esxjobcheck
```

5. For marker resources, open the map and visit the configured coordinates in each resource's `config.lua`.
6. Watch both the client console and server console for warnings.
7. For QBCore and ESX tests, confirm the relevant character/player data is loaded before running the job check command.

## What Not To Build Yet

Do not add these until explicitly requested and designed safely:

- money rewards or economy changes
- item grants or inventory integrations
- weapon grants
- admin commands
- permission systems
- database writes
- vehicle ownership logic
- anti-cheat bypasses or ban evasion behavior
- NUI dashboards or complex UI
- production framework integrations beyond simple guarded tests

## Notes For QBCore Resources

QBCore resources must document `qb-core` as a required dependency and ensure it starts first.

Server-side code should use `QBCore.Functions.GetPlayer(source)` for player data and should check that QBCore, `QBCore.Functions`, and `QBCore.Functions.GetPlayer` are available before use.

Clients must not send job names, grades, money, items, weapons, or permissions as trusted values. The server should read those values from QBCore and return only safe display data unless a future resource explicitly needs validated server-side actions.

## Notes For ESX Resources

ESX resources must document `es_extended` as a required dependency and ensure it starts first.

This project targets ESX Legacy export-based shared object access with:

```lua
exports['es_extended']:getSharedObject()
```

Server-side code should use `ESX.GetPlayerFromId(source)` for player data and should check that ESX and `ESX.GetPlayerFromId` are available before use.

Clients must not send job names, grades, money, items, weapons, or permissions as trusted values. The server should read those values from ESX and return only safe display data unless a future resource explicitly needs validated server-side actions.

## Development Notes

- Default target is standalone Lua with no external dependencies.
- Use `fx_version 'cerulean'`, `game 'gta5'`, and Lua 5.4 where appropriate.
- Keep resource README files accurate whenever a resource changes.
- Prefer small, focused resources over large rewrites.
- Do not modify unrelated resource code when updating documentation.
