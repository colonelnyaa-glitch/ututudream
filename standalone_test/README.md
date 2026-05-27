# Standalone Test

## Description

Small standalone FiveM test resource.

It adds the `/standalonetest` command. When used in-game, the client shows a notification and optionally sends a safe ping to the server. The server replies with a configured message.

## Files

- `fxmanifest.lua` - FiveM resource manifest.
- `config.lua` - Configurable command name, messages, server ping toggle, and debug mode.
- `client.lua` - Registers the command, shows notifications, and triggers the server ping.
- `server.lua` - Handles the resource-specific ping event and sends a response back to the same player.

## Installation

1. Place the `standalone_test` folder in your server resources folder.
2. Add this to `server.cfg`:

```cfg
ensure standalone_test
```

3. Restart the server or start the resource.

## Configuration

Edit `config.lua`:

- `Config.Command` - Command players use in chat.
- `Config.ClientMessage` - Message shown immediately on the client.
- `Config.ServerMessage` - Message sent back from the server.
- `Config.EnableServerPing` - Enables or disables the test server event.
- `Config.ServerPingCooldownSeconds` - Sets the server-side cooldown between ping responses for each player. Default: `3` seconds.
- `Config.Debug` - Prints server debug output when enabled.

## Testing

1. Start the server.
2. Join the server.
3. Run this command in chat:

```text
/standalonetest
```

4. Confirm the client notification appears.
5. If `Config.EnableServerPing` is enabled, confirm the server response notification appears.
6. Run `/standalonetest` multiple times quickly. The server response should only appear once per player during the default `3` second cooldown.
7. Wait at least `3` seconds, then run `/standalonetest` again and confirm the server response appears again.

## Dependencies

None.

This resource is standalone and does not require ESX, QBCore, ox_lib, ox_inventory, or any external resource.

## Notes

- Event names are resource-specific.
- The server event does not trust client-provided reward, money, item, job, or permission values.
- This resource does not modify money, inventory, permissions, vehicles, or database records.
