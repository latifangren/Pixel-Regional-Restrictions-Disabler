# Changelog

## v1.2.3 - 2026-06-10
- Fix double-trigger behavior in installer selector by reacting only to `DOWN` volume key events
- Prevent one physical volume key press from being interpreted as both press and release navigation

## v1.2.2 - 2026-06-10
- Fix installer selector shell compatibility for KernelSU Legacy and other stricter installer shells
- Replace Bash-style array usage in `customize.sh` with shell-compatible positional argument handling

## v1.2.1 - 2026-06-10
- Replace installer yes/no chains with a volume-key selector UI (`Vol+` next, `Vol-` select)
- Improve install flow for preset selection, Wi-Fi region selection, telephony spoof selection, and optional add-ons
- Refresh README requirements and experimental notes for this fork, including Pixel 5 testing context

## v1.2.0 - 2026-06-10
- Fork metadata now points to `latifangren/Pixel-Regional-Restrictions-Disabler`
- Add install presets: `Wi-Fi only`, `Wi-Fi + telephony`, `Full unlock`
- Add selectable Wi-Fi spoof region during install
- Add optional telephony spoof toggle and selectable telephony region
- Default Wi-Fi spoof region changed to `AU`
- Add extra Wi-Fi 6 GHz unlock props in `system.prop` and `service.sh`

## v1.1.2 - 2026-03-21
- Add support for Writing Tools in Gboard

## v1.1.1 - 2026-03-21
- Add support for Body Temperature in Pixel Thermometer

## v1.1.0 - 2026-03-21
- Fix UWB support

## v1.0.0 - 2025-10-25
- Initial release
