# msc_notify_consumer_test

## Description

Standalone FiveM consumer test resource for calling the `notify` export from `msc_notify_adapter_test`.

It adds a `/consumernotify` command that triggers a notification through the adapter resource.

## Files

- `fxmanifest.lua` - Resource manifest.
- `client.lua` - Client-side `/consumernotify` command and export call.
- `README.md` - Installation, testing, and safety notes.

## Installation

1. Place the `msc_notify_consumer_test` folder in your server resources folder.
2. Make sure `msc_notify_adapter_test` is also installed.
3. Add the resources to `server.cfg` in the order shown below.
4. Restart the server or start both resources.

## server.cfg

```cfg
ensure msc_notify_adapter_test
ensure msc_notify_consumer_test
```

## Configuration

No `config.lua` is included because this resource is a fixed consumer test for one command and one export call.

To change notification behavior, configure `msc_notify_adapter_test`.

## Testing

1. Start `msc_notify_adapter_test`.
2. Start `msc_notify_consumer_test`.
3. Join the server.
4. Run this command in chat:

```text
/consumernotify
```

5. Confirm that a notification appears with:

```text
Consumer Test: This notification was called from another resource.
```

## Dependencies

- Required resource: `msc_notify_adapter_test`
- External dependencies: none
- Framework: standalone

## Notes

- Client-side notification test only.
- No `server.lua` is included because no server logic is needed.
- No money handling.
- No item handling.
- No job checks.
- No weapon logic.
- No permission system.
- No database access.
- No server events.
