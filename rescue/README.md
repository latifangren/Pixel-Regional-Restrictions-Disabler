# Rescue tools

This folder contains **local recovery helpers** for situations where a bad module build causes boot trouble and you still have a short window with:

- Android able to boot far enough for `adb` to connect
- the host computer already authorized for USB debugging
- temporary `su` access available

## `adb-disable-module-race.bat`

Windows batch helper that repeatedly:

1. waits for an `adb` device
2. checks whether `su` is available
3. scans common Magisk / KernelSU module paths
4. tries to create `disable` and `remove` markers
5. then attempts `rm -rf` on the matching module directory

### Intended use

Use this only as an **emergency cleanup helper** when a module causes boot problems and the normal module manager cannot be opened safely.

### Current module names it checks

- `BypassRegionalPixelLatif`
- `BypassRegionalPixel`

### Output behavior

- Console output shows high-level status such as `FOUND`, `MISS`, and `CLEAN`
- Full command output is written to `adb-disable-module-race.log`

### Requirement

- `adb` available in `PATH`
- device already authorized for USB debugging
- temporary `su` access available during boot
