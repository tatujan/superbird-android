# Known issues

## Limits

- `screencap` gives a distorted image (the landscape frame in a portrait buffer).
- Some Car Things have a different panel (Holitech). The image uses the unit's own device tree,
  but only the ST7701S panel is tested.
- The stock software must be in slot A; `flash.py` refuses a unit whose stock software runs from
  slot B.

## Logs

The image keeps its logs over a power cut: `logcatd` writes the Android and kernel logs to
`/data/misc/logd/` (16 files of 1 MB; `ro.logd.kernel=true`,
`persist.logd.logpersistd=logcatd`). After a problem, at the desk, as root:

```sh
adb pull /data/misc/logd/
```
