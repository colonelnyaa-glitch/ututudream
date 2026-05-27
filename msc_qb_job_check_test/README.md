# MSC QBCore Job Check Test

## Description

Safe QBCore job check test resource.

It adds the `/qbjobcheck` command. When used in-game, the client asks the server to check the player's QBCore job. The server reads the QBCore player object and sends only a safe display message back to that same player.

## Files

- `fxmanifest.lua` - FiveM resource manifest with `qb-core` dependency.
- `config.lua` - Configurable command, cooldown, messages, and debug mode.
- `client.lua` - Registers `/qbjobcheck`, asks the server to check the job, and displays the returned message.
- `server.lua` - Gets the QBCore player object safely, applies a per-source cooldown, and returns job display text to the same player.
- `README.md` - Installation, configuration, testing, dependencies, and safety notes.

## Installation

1. Place the `msc_qb_job_check_test` folder in your server resources folder.
2. Make sure `qb-core` is installed and starts before this resource.
3. Add the ensure lines below to `server.cfg`.
4. Restart the server or start the resource.

## server.cfg

```cfg
ensure qb-core
ensure msc_qb_job_check_test
```

## Configuration

Edit `config.lua`:

- `Config.Command` - Command players use in chat. Default: `qbjobcheck`.
- `Config.ServerCooldownSeconds` - Server-side cooldown per player source. Default: `5` seconds.
- `Config.Debug` - Prints server debug output when enabled.
- `Config.Messages` - Notification text shown to players.

## Testing

1. Start `qb-core`.
2. Start `msc_qb_job_check_test`.
3. Join the server with a QBCore character loaded.
4. Run this command in chat:

```text
/qbjobcheck
```

5. Confirm the client shows a request message.
6. Confirm the server returns your job label, job name, grade level, and grade name.
7. Run `/qbjobcheck` several times quickly and confirm the cooldown message appears.
8. Wait at least the configured cooldown time, then run `/qbjobcheck` again.

## Dependencies

- `qb-core`

This resource uses:

- `exports['qb-core']:GetCoreObject()`
- `QBCore.Functions.GetPlayer(source)`

No ESX, ox_lib, ox_inventory, database resource, or other dependency is used.

## Safety Notes

- The client never sends job names or grades.
- The server reads job data only from the QBCore player object.
- The server sends the result only to the same source that requested it.
- A small per-source server cooldown is included.
- QBCore object lookup is protected with a resource state check and `pcall`.
- If `qb-core` is unavailable or `GetPlayer` is missing, the server sends a safe error message to the requesting player.
- The server also prints a warning to the console when QBCore is unavailable.
- This resource does not add money.
- This resource does not add items.
- This resource does not add weapons.
- This resource does not change jobs.
- This resource does not change grades.
- This resource does not grant permissions.
- This resource does not write to a database.
