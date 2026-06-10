> [!CAUTION]
> ### ⚖️ Legal Disclaimer & Responsibility
> If certain functions (e.g., **UWB**, **6GHz**) are restricted or illegal in your country, their activation and use are **your sole responsibility**. 
> 
> The author is **not responsible** for any misuse, legal consequences, or device instability. By installing this module, you acknowledge that you are using it at your own risk.



# Pixel Regional Restrictions Disabler (Latif Fork)

A Magisk Module to enable VoLTE, VoWiFi, 5G, UWB, 5/6 GHz hotspot, Wi-Fi repeater, Body Temperature and Writing Tools for Google Pixel in countries not officially supported by Google.

This is an all-in-one mod for convenience.

This fork adds installer presets, selectable Wi-Fi spoof regions, optional telephony spoofing, and fork-owned update/release metadata so Magisk and KernelSU do not point back to the upstream project.

## Features

In countries [not officially supported](https://pixel.withgoogle.com/5G/) by Google, this module enables and gives you:

- VoLTE
- VoWiFi (Wi-Fi calling)
- 5G (SA+NSA)
- 5 GHz & 6 GHz hotspot
- Wi-Fi repeater (hotspot while connected to Wi-Fi)
- UWB (Tablet, Pro & Fold models only)
- Body Temperature in Pixel Thermometer (Pro models of 8-10 series only)
- Writing Tools in Gboard

### Fork additions

- Install preset selection:
  - `Wi-Fi only`
  - `Wi-Fi + telephony`
  - `Full unlock`
- Selectable Wi-Fi spoof region during install:
  - `AU`, `GB`, `JP`, `DE`, `NL`, `US`, `CN`, `ID`
- Optional telephony spoof with separate region selection:
  - `US`, `AU`, `GB`, `JP`, `DE`, `NL`, `CN`, `ID`
- Default Wi-Fi spoof region changed to `AU`
- Extra 6 GHz Wi-Fi unlock props applied in both `system.prop` and `service.sh`

## Requirements

- Google Pixel 6 or higher (Google Tensor SoC)
- Rooted with Magisk / KernelSU / Apatch
- A brain

### Experimental note for this fork

This fork may also be useful outside the upstream target matrix for Wi-Fi regulatory spoofing experiments. If you use it on unsupported models such as Pixel 5, treat it as experimental and verify behavior yourself.

## Installation

1. Download the zip from this fork's [release page](https://github.com/latifangren/Pixel-Regional-Restrictions-Disabler/releases).
2. Flash it using Magisk, KernelSU, or Apatch.
3. During installation, choose an install preset:
   - `Wi-Fi only` for regulatory Wi-Fi spoof only
   - `Wi-Fi + telephony` for Wi-Fi plus telephony country spoof
   - `Full unlock` for Wi-Fi, telephony, and optional app/device extras
4. Choose Wi-Fi spoof region when prompted. Recommended starting points for Indonesia: `AU`, `GB`, `JP`, `DE`, `NL`.
5. If telephony spoof is enabled, choose telephony region separately.
6. Reboot your phone.
7. Enable VoLTE, VoWiFi, 5G, and UWB in device settings if applicable.
8. You may need to toggle hotspot once after installation for new frequency options to appear.

## Release workflow for this fork

This fork includes a GitHub Actions release workflow that:

- packages the module into `Pixel-Regional-Restrictions-Disabler-latifangren.zip`
- attaches the ZIP to a GitHub release
- can be triggered by pushing a tag like `v1.2.0` or by manual dispatch with an existing tag name

Suggested release flow:

1. Update `module.prop`, `update.json`, and `CHANGELOG.md`
2. Commit changes
3. Create and push a tag, for example:
   - `git tag v1.2.0`
   - `git push origin v1.2.0`
4. GitHub Actions builds and uploads release asset automatically

Manual release flow:

1. Make sure the version tag already exists on GitHub
2. Open **Actions** -> **Release module zip** -> **Run workflow**
3. Enter the tag name, for example `v1.2.0`
4. Run the workflow to rebuild and attach the ZIP for that tag

## See also

- [Pixel Modem Fix](https://github.com/vchikalkin/Pixel-Modem-Fix) for better signal quality.

- [Carrier IMS](https://github.com/ryfineZ/carrier-ims-for-pixel) for more IMS-related features.

- [Always-On Fingerprint](https://github.com/klab7/AlwaysOnFingerprint) for fingerprint unlock with screen off on Pixels with optical scanner.

- [Battery Info Enabler](https://github.com/klab7/BatteryInfoEnabler) for unlocking battery info in settings on all Pixels.

## License

This project is licensed under the [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

## Credits

- [esteban](https://github.com/EstebanForge/Pixel-VoLTE-VoWIFI-5G-Enabler) for original VoLTE, VoWiFi & 5G enabler module.

- [aside](https://4pda.to/forum/index.php?showtopic=1093998&st=220#entry136638452) for idea on how to enable UWB.

- [sbeygi67](https://xdaforums.com/t/guide-root-change-wifi-hotspot-country-to-bypass-regional-restrictions-on-android-10.4703941/) for Wi-Fi country code idea.

- [ypsten](https://xdaforums.com/t/allow-thermometer-app-to-read-body-temperature-in-not-allowed-regions.4652872/page-2#post-89308062) for Body Temperature in Pixel Thermometer.

- [Arsto](https://t.me/GappsLeaksChat/98622) for Gboard flags file.

- [SukkaW](https://github.com/SukkaW) for PR discussion and ideas around AU Wi-Fi country spoofing, 1-second boot checks, and extra 6 GHz-related props.
