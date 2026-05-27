# msc_multi_marker_test

## Description

Standalone FiveM resource that creates multiple configurable map blips and world markers.

## Files

- `fxmanifest.lua` - Resource manifest.
- `config.lua` - Location, marker, blip, message, and wait-time settings.
- `client.lua` - Client-side blip creation, marker drawing, help notification display, and blip cleanup.
- `README.md` - Installation and usage notes.

## Installation

1. Place the `msc_multi_marker_test` folder in your server resources folder.
2. Add this to `server.cfg`:

```cfg
ensure msc_multi_marker_test
```

3. Restart the server or start the resource from the console:

```cfg
start msc_multi_marker_test
```

## Configuration

Edit `config.lua` and update `Config.Locations`.

`Config.Locations = {}` is valid and simply disables all configured markers and blips. Each enabled location must include valid `coords` as `vector3(x, y, z)`. Locations with missing or invalid `coords` are skipped by the client script.

Each location supports:

- `name` - Blip name and readable location label.
- `coords` - Marker and blip position as `vector3(x, y, z)`.
- `helpMessage` - Help text shown near the marker.
- `marker.enabled` - Enables or disables marker drawing.
- `marker.drawDistance` - Distance where the marker starts drawing.
- `marker.interactDistance` - Distance where the help message appears.
- `marker.type` - GTA marker type.
- `marker.size` - Marker size table with `x`, `y`, and `z`.
- `marker.color` - Marker color table with `r`, `g`, `b`, and `a`.
- `blip.enabled` - Enables or disables the map blip.
- `blip.sprite` - Blip sprite ID.
- `blip.display` - Blip display mode.
- `blip.scale` - Blip scale.
- `blip.color` - Blip color ID.
- `blip.shortRange` - Whether the blip is short range.

Global interaction settings:

- `Config.Interaction.Control` - FiveM control ID used for client-only interaction. The default is `38` for E.
- `Config.Interaction.KeyLabel` - Key label inserted into help messages using `{key}`.
- `Config.Interaction.NotificationMessage` - Client-only notification shown when the interaction key is pressed near the nearest valid marker.

## Testing

1. Start the resource.
2. Check the map for enabled blips.
3. Visit one of the configured locations.
4. Confirm the marker only appears when close enough.
5. Move near the marker and confirm the help notification appears.
6. Press E near the marker and confirm the client-only notification appears.
7. Stop or restart the resource and confirm created blips are removed.

## Dependencies

None. This resource is standalone and does not require ESX, QBCore, ox_lib, ox_inventory, or a database.

## Performance Notes

- Uses one thread for initial blip creation and one loop for marker checks.
- Uses `Config.FarWait` while the player is away from all markers.
- Switches to `Config.NearWait` only while within marker draw distance.
- Markers are drawn only when the player is within each location's configured draw distance.

## Safety Notes

- No money handling.
- No item handling.
- No job checks.
- No weapon logic.
- No permission system.
- No database access.
- No server events.
- Interaction is client-only and does not grant money, items, weapons, jobs, or permissions.
