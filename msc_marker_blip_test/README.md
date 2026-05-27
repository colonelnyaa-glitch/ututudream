# MSC Marker Blip Test

## Description

Standalone FiveM test resource that shows one configurable map blip and one configurable world marker.

When a player is near the marker, a simple help notification is shown.

## Files

- `fxmanifest.lua` - FiveM resource manifest.
- `config.lua` - Configurable marker position, blip settings, draw distance, marker color, and help text.
- `client.lua` - Creates the blip, draws the marker, and shows the help notification.
- `README.md` - Installation, configuration, and test instructions.

## Installation

1. Place the `msc_marker_blip_test` folder in your server resources folder.
2. Add this to `server.cfg`:

```cfg
ensure msc_marker_blip_test
```

3. Restart the server or start the resource.

## Configuration

Edit `config.lua`:

- `Config.Marker.Position` - Marker world position.
- `Config.Marker.DrawDistance` - Distance where the marker starts drawing.
- `Config.Marker.InteractDistance` - Distance where the help notification appears.
- `Config.Marker.Type` - FiveM marker type.
- `Config.Marker.Size` - Marker size.
- `Config.Marker.Color` - Marker RGBA color.
- `Config.Marker.HelpText` - Help notification text.
- `Config.Blip.Enabled` - Enables or disables the map blip.
- `Config.Blip.Position` - Blip world position.
- `Config.Blip.Sprite` - Blip icon sprite.
- `Config.Blip.Display` - Blip display mode.
- `Config.Blip.Scale` - Blip size on the map.
- `Config.Blip.Color` - Blip color ID.
- `Config.Blip.ShortRange` - Whether the blip only appears nearby.
- `Config.Blip.Name` - Blip label.

## Testing

1. Start the resource:

```cfg
ensure msc_marker_blip_test
```

2. Join the server.
3. Open the map and confirm the `Marker Blip Test` blip appears.
4. Go to the configured marker position.
5. Confirm the marker is visible within `Config.Marker.DrawDistance`.
6. Walk near the marker and confirm the help notification appears.

## Dependencies

None.

This resource is standalone and does not require ESX, QBCore, ox_lib, ox_inventory, or any external resource.

## Notes

- This resource only uses client-side display logic.
- No money, items, jobs, weapons, permissions, or database logic is included.
- No server events are registered.
- Very large `Config.Marker.DrawDistance` values can increase client-side rendering cost because markers are drawn every frame while the player is in range.
- `server.lua` is not included because server-side logic is not needed for marker, blip, or local help notification display.
