# AGENTS.md

## Repo type
- Flashable Android root module repo, not normal app/library repo.
- Main behavior lives in shell scripts and packaged payload files.
- No tracked test runner, linter, formatter, package manifest, or lockfile in repo root.

## Read first
- `README.md` — install flow, release flow, safe-baseline notes.
- `CHANGELOG.md` — recent behavior changes and shell-compat fixes.
- `META-INF/com/google/android/update-binary` — Magisk installer bootstrap.
- `customize.sh` — installer UI, preset selection, region selection, optional payload install.
- `service.sh` — boot-time runtime behavior.
- `system.prop` — static prop payload.
- `module.prop` + `update.json` — shipped version/update metadata.
- `.github/workflows/release.yml` — exact release packaging behavior.
- `rescue/README.md` — emergency cleanup path for bad builds.

## Real wiring
- Install-time choices are written by `customize.sh` to `region.conf` in module path.
- Runtime `service.sh` sources `region.conf`, waits for `sys.boot_completed=1`, then applies Wi-Fi country spoof and optional telephony ISO spoof.
- UWB payloads come from `uwb/uwb_67`, `uwb/uwb_89`, `uwb/uwb_10` based on `ro.product.device`.
- Optional app-data payloads:
  - `thermometer/thermometer.xml`
  - `gboard/flags_jetpack_data_store.pb`
- `customize.sh` deletes bundled payload directories from installed module at end: `uwb`, `thermometer`, `gboard`.

## Release flow
- Exact documented tag flow:
  - `git tag v1.2.0`
  - `git push origin v1.2.0`
- CI workflow builds release zip with:
  - `zip -r dist/Pixel-Regional-Restrictions-Disabler-latifangren.zip . -x ".git/*" -x ".github/*" -x "dist/*"`
- Packaging is near-verbatim repo zip. Any tracked root file can ship unless excluded.
- When bumping release, keep these aligned:
  - `module.prop`: `version`, `versionCode`
  - `update.json`: `version`, `versionCode`, `zipUrl`
  - workflow asset name: `Pixel-Regional-Restrictions-Disabler-latifangren.zip`

## Known gotchas
- Current safe baseline is `v1.2.4`.
- Do not reintroduce forced extra 6 GHz props by default unless user explicitly asks for experimental behavior. `CHANGELOG.md` and `README.md` record boot issues on at least one tested Pixel 5 (`redfin`) setup.
- Installer UI is volume-key driven: `Vol+` cycles, `Vol-` selects. `customize.sh` intentionally reacts to `KEY_VOLUMEUP ... DOWN` / `KEY_VOLUMEDOWN ... DOWN` only.
- Keep installer shell compatibility conservative. `v1.2.2` removed Bash-style arrays for stricter installer shells such as KernelSU Legacy.
- `module.prop` description still mentions `6 GHz Wi‑Fi unlock props`, but runtime-safe baseline has those forced props removed from `service.sh` and `system.prop`. Treat README/CHANGELOG/runtime files as source of truth.

## Verification by change scope
- `customize.sh` changes:
  - Verify each install mode still writes expected `region.conf` keys.
  - Verify UWB subfolder mapping and optional app-data file paths still match payload filenames.
- `service.sh` changes:
  - Keep boot wait loop.
  - Keep `cmd wifi force-country-code enabled "$WIFI_REGION"` path intact unless intentionally changing runtime design.
  - Gate telephony spoof behind `TELEPHONY_SPOOF=true`.
- `system.prop` changes:
  - Re-read `README.md` and `CHANGELOG.md` for safety expectations before changing runtime props.
- Release metadata changes:
  - Re-check `module.prop`, `update.json`, and `.github/workflows/release.yml` together.

## Rescue / recovery context
- `rescue/adb-disable-module-race.bat` is Windows-only emergency cleanup helper.
- Assumes `adb` already authorized and temporary `su` available during boot.
- Checks both module IDs:
  - `BypassRegionalPixelLatif`
  - `BypassRegionalPixel`

## Important repo quirk
- `META-INF/com/google/android/update-binary` explicitly extracts and sources `install.sh`, `uninstall.sh`, and `common/*`, but those files are not tracked in this checkout.
- Before changing installer bootstrap behavior or release packaging assumptions, verify whether those files are generated elsewhere or missing from current repo state.
