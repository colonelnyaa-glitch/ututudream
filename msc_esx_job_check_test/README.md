# MSC ESX Job Check Test

## Description

Safe ESX job check test resource.

It adds the `/esxjobcheck` command. When used in-game, the client asks the server to check the player's ESX job. The server reads the ESX player object and sends only a safe display message back to that same player.

## Files

- `fxmanifest.lua` - FiveM resource manifest with `es_extended` dependency.
- `config.lua` - Configurable command, cooldown, messages, and debug mode.
- `client.lua` - Registers `/esxjobcheck`, asks the server to check the job, and displays the returned message.
- `server.lua` - Gets the ESX player object safely, applies a per-source cooldown, and returns job display text to the same player.
- `README.md` - Installation, configuration, testing, dependencies, and safety notes.

## Installation

1. Place the `msc_esx_job_check_test` folder in your server resources folder.
2. Make sure `es_extended` is installed and starts before this resource.
3. Add the ensure lines below to `server.cfg`.
4. Restart the server or start the resource.

## server.cfg

```cfg
ensure es_extended
ensure msc_esx_job_check_test
```

## Configuration

Edit `config.lua`:

- `Config.Command` - Command players use in chat. Default: `esxjobcheck`.
- `Config.ServerCooldownSeconds` - Server-side cooldown per player source. Default: `5` seconds.
- `Config.Debug` - Prints server debug output when enabled.
- `Config.Messages` - Notification text shown to players.

## Testing

1. Start `es_extended`.
2. Start `msc_esx_job_check_test`.
3. Join the server with an ESX character loaded.
4. Run this command in chat:

```text
/esxjobcheck
```

5. Confirm the client shows a request message.
6. Confirm the server returns your job label, job name, grade level, and grade name.
7. Run `/esxjobcheck` several times quickly and confirm the cooldown message appears.
8. Wait at least the configured cooldown time, then run `/esxjobcheck` again.
9. If ESX becomes unavailable at runtime, confirm the guard returns a safe warning message instead of an error.

Note: `fxmanifest.lua` declares `dependency 'es_extended'`, so some servers may not start or keep this resource running if `es_extended` is stopped.

## Dependencies

- `es_extended`

This resource targets ESX Legacy versions that support:

- `exports['es_extended']:getSharedObject()`

This resource uses:

- `exports['es_extended']:getSharedObject()`
- `ESX.GetPlayerFromId(source)`
- `xPlayer.getJob()` when available

Older ESX versions that only provide the `esx:getSharedObject` event are not supported unless a fallback is added.

No QBCore, ox_lib, ox_inventory, database resource, or other dependency is used.

## Safety Notes

- The client never sends job names or grades.
- The server reads job data only from the ESX player object.
- The server sends the result only to the same source that requested it.
- A small per-source server cooldown is included.
- `playerDropped` cleans up stored cooldown data.
- ESX object lookup is protected with a resource state check and `pcall`.
- If ESX becomes unavailable at runtime or `GetPlayerFromId` is missing, the server sends a safe error message to the requesting player.
- The server also prints a warning to the console when ESX is unavailable or `GetPlayerFromId` is missing.
- This resource does not add money.
- This resource does not add items.
- This resource does not add weapons.
- This resource does not change jobs.
- This resource does not change grades.
- This resource does not grant permissions.
- This resource does not write to a database.
