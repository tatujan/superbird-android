# Known issues

## Limits

- Some Car Things have a different panel (Holitech). The image uses the unit's own device tree,
  but only the ST7701S panel is tested.
- The stock software must be in slot A; `flash.py` refuses a unit whose stock software runs from
  slot B.
- USB-C audio adapters without a hub chip cannot give sound while the iPhone is connected: they
  switch between their sound card and their data port (`docs/bluetooth-audio.md`, "USB audio").
  Use a hub and a separate USB sound card.
- I tested PlayThing only on a Car Thing with the older Spotify U-Boot (`v1.0-57`). Car Things
  with the newer U-Boot (`v1.0-74`, with `fip_a`/`fip_b` in the partition table) have the same
  places for the partitions that PlayThing uses, and the same device-tree nodes; `flash.py`
  supports them since `0.1.0-beta.2`. Version `0.1.0-beta` of the tool stopped on them ("the
  partition table is still the superbird-tool one"). On a unit with the stock software v8
  (board revision 4), PlayThing up to `0.1.0-beta.4` started Android, but the screen showed
  noise: U-Boot applied the stock DRM overlay, so `/dev/graphics/fb0` was missing.
  `0.1.0-beta.5` skips that overlay (`docs/boot.md`, "Device-tree overlays"); with it, PlayThing
  works on that unit (a user's report).

## Logs

The image keeps its logs over a power cut: `logcatd` writes the Android and kernel logs to
`/data/misc/logd/` (16 files of 1 MB; `ro.logd.kernel=true`,
`persist.logd.logpersistd=logcatd`). After a problem, at the desk, as root:

```sh
adb pull /data/misc/logd/
```
