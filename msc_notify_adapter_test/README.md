# msc_notify_adapter_test

## Description

Standalone-compatible FiveM notification adapter test resource.

It provides a `/testnotify` command that can use either native GTA notifications or `ox_lib` notifications depending on `Config.NotifyProvider`.

## Files

- `fxmanifest.lua` - Resource manifest.
- `config.lua` - Notification provider, command, and test message settings.
- `client.lua` - Client-side notification adapter and `/testnotify` command.
- `README.md` - Installation and usage notes.

## Installation

1. Place the `msc_notify_adapter_test` folder in your server resources folder.
2. Add this to `server.cfg`:

```cfg
ensure msc_notify_adapter_test
```

3. Restart the server or start the resource.

## Configuration

Edit `config.lua`.

```lua
Config.NotifyProvider = 'native' -- 'native' or 'ox_lib'
Config.Command = 'testnotify'
```

Provider behavior:

- `native` uses the built-in GTA feed notification.
- `ox_lib` uses `lib.notify` only when the `lib` table and `lib.notify` function are available.
- If `ox_lib` is selected but `lib.notify` is not available, the script falls back to native notification.

## Client Export

Other client resources can call the adapter with:

```lua
exports['msc_notify_adapter_test']:notify({
    title = 'Example',
    description = 'Called from another client resource.',
    type = 'inform'
})
```

The export uses the same `Config.NotifyProvider` setting and native fallback behavior as `/testnotify`.

Ensure this adapter before any resource that calls the export:

```cfg
ensure msc_notify_adapter_test
ensure your_other_resource
```

## Testing

1. Start the resource.
2. Run this command in chat:

```text
/testnotify
```

3. Confirm a notification appears.
4. Set `Config.NotifyProvider = 'ox_lib'` only if your environment exposes `lib.notify`.
5. If `lib.notify` is not available, confirm the native fallback notification appears.

## Dependencies

None by default.

`ox_lib` is optional. This resource does not require it unless you choose to expose and use `lib.notify` in your server environment.

## Safety Notes

- Client-side notification only.
- No money handling.
- No item handling.
- No job checks.
- No weapon logic.
- No permission system.
- No database access.
- No server events.
