# HP ZBook Fury 17 G7 — OpenCore macOS Sequoia 15.8.1

**Real-world installation notes, compatibility report and troubleshooting diary for an HP mobile workstation.**

[العربية — Arabic guide](README.ar.md) · [Hardware](docs/01-HARDWARE.md) · [Backlight fix](docs/03-GRAPHICS-BACKLIGHT-FIX.md) · [What works](docs/02-WHAT-WORKS.md)

![macOS Sequoia](https://img.shields.io/badge/macOS-Sequoia%2015.8.1-blue)
![Intel UHD 630](https://img.shields.io/badge/Intel%20UHD%20630-Metal%203-success)
![State](https://img.shields.io/badge/status-working%20USB%20boot%20%7C%20testing-yellow)

> **Status — 30 October 2026:** macOS Sequoia runs on this machine with Metal 3 graphics acceleration, Intel Wi-Fi, internal speakers, and a working built-in 1080p panel. A real backlight problem showed a positive result with WhateverGreen **-igfxblr**, including a working brightness slider. **Repeat-boot stability, thermal sensors, battery features, sleep/wake, and final USB-free SSD boot still require verification.**
>
> **No ready-to-flash EFI is distributed yet.** Every machine requires its own configuration and unique identifiers.

![HP ZBook Fury 17 G7 boot drive layout](assets/boot-layout.svg)

## Exact tested hardware

| Component | Configuration |
| --- | --- |
| Laptop | **HP ZBook Fury 17 G7** |
| Processor | Intel Core i7-10850H, 6 cores / 12 threads, 2.70 GHz base |
| Integrated graphics | Intel UHD Graphics 630, **8086:9BC4** |
| Discrete GPU | NVIDIA Quadro RTX 3000 6 GB, not supported for macOS acceleration |
| RAM | 16 GB |
| Internal display | LG Display **LGD063F**, 1920 × 1080, 60 Hz |
| Wi-Fi | Intel AX201, **8086:06F0** |
| Sound | Realtek ALC285, **10EC:0285** |
| macOS storage | Dedicated 256 GB SATA SSD, SSDAS256 |
| Windows storage | Separate 512 GB NVMe SSD, MTFDHBA512TDV |
| BIOS | HP S92 **01.25.00**, graphics option **UMA** |
| OpenCore model identity | **MacBookPro16,1**, identifiers intentionally omitted |
| OS | macOS Sequoia **15.8.1**, build **24H32** |

## Compatibility matrix

| Feature | Status | Evidence / caveat |
| --- | --- | --- |
| Boot from OpenCore USB | ✅ Tested | Working macOS desktop |
| Intel UHD 630 acceleration | ✅ Tested | **Metal 3, 1536 MB dynamic VRAM** |
| Built-in display | ✅ Tested | Native 1920 × 1080 at 60 Hz |
| Backlight and brightness slider | 🟡 Positive | The -igfxblr session was illuminated and the slider changed actual panel brightness; cold-boot repetition pending |
| Intel AX201 Wi-Fi | ✅ Tested | AirportItlwm 2.4.0 |
| Built-in audio output | ✅ Tested | AppleALC 1.9.8, layout-id 33 |
| Windows-like Arabic keyboard | ✅ Tested | macOS **Arabic – PC** input source |
| CPU power management | ✅ Driver active | X86PlatformPlugin loaded |
| USB-free internal SSD boot | ⏳ Pending | Internal EFI holds an older configuration; final backlight fix not independently verified |
| Touchpad, battery, Bluetooth, webcam | ⏳ Incomplete | See [test checklist](docs/05-NEXT-STEPS.md) |
| CPU temperature, fan speed | ⏳ Incomplete | VirtualSMC sensor interface returned invalid-key errors |
| Sleep/wake | ⏳ Not tested | Needs backlight stability first |
| Microphone | ➖ Out of scope | Owner does not require the built-in mic |

## The hardest problem: black screen after the Apple logo

The boot logo and progress bar were clearly visible. Then the internal LCD appeared black. However, a flashlight revealed the macOS login screen, Dock, and desktop; the machine also produced audio. **The panel was displaying an image without a working backlight**, rather than failing to boot entirely.

There were multiple unsuccessful attempts involving framebuffer initialization, EDID, DisplayPort DPCD, PNLF ACPI configuration and the alternative WhateverGreen backlight fix. The best observed result came from switching the WhateverGreen boot argument from **-igfxblt** to **-igfxblr**, while retaining the exact graphics properties already proven to deliver Metal 3 acceleration.

**Boot arguments observed in the positive macOS session:**

~~~text
keepsyms=1 debug=0x100 -wegnoegpu -igfxblr igfxonln=1
~~~

After boot, the owner confirmed the argument with the macOS nvram command, displayed an illuminated desktop and verified that **System Settings → Displays → Brightness** actually dimmed and brightened the physical panel. The diagnostic report also showed **AppleBacklightDisplay active**.

**Do not claim a permanent cure based on this single successful session.** Cold-start, restart, lid close/open, and wake must be validated repeatedly.

Read the [full graphics and backlight troubleshooting record](docs/03-GRAPHICS-BACKLIGHT-FIX.md).

## Observed kext versions

| Driver | Version |
| --- | --- |
| Lilu | 1.7.2 |
| WhateverGreen | 1.7.1 |
| VirtualSMC | 1.3.8 |
| AppleALC | 1.9.8 |
| AirportItlwm | 2.4.0 (Sequoia-compatible build) |
| USBToolBox | 1.2.0 |

See [non-bootable graphics settings excerpt](examples/graphics-boot-settings.json). **It intentionally excludes EDID bytes and private SMBIOS fields.**

## Documentation

- [01 — Verified hardware inventory](docs/01-HARDWARE.md)
- [02 — Working and untested functions](docs/02-WHAT-WORKS.md)
- [03 — Full graphics/backlight fix journal](docs/03-GRAPHICS-BACKLIGHT-FIX.md)
- [04 — Power and thermals: readings versus hypotheses](docs/04-POWER-THERMALS.md)
- [05 — Next steps and acceptance tests](docs/05-NEXT-STEPS.md)
- [06 — Safe internal EFI transfer](docs/06-INTERNAL-EFI.md)
- [07 — Privacy and publication safety](docs/07-PRIVACY-BEFORE-PUBLISHING.md)
- [Arabic version](README.ar.md)

## Next verification milestones

1. Verify a lit login screen and brightness controls over several **cold starts and warm restarts**, then sleep/wake.
2. Enable compatible temperature/fan readouts **without assuming that reported package power equals CPU temperature**; inspect GPU power-off state.
3. Test Bluetooth pairing, camera, touchpad, battery behavior and ports.
4. Copy the **exact final known-good** OpenCore EFI to the **macOS 256 GB SATA disk** and verify standalone boot. **Never modify the Windows 512 GB NVMe EFI.**
5. Consider publishing only a **tested and sanitized example EFI** after removing sensitive SMBIOS/ROM/UUID data, and checking the exact public ZIP.

## Upstream references

- [Dortania: OpenCore laptop guide](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/coffee-lake-plus.html)
- [Dortania: ACPI](https://dortania.github.io/Getting-Started-With-ACPI/)
- [WhateverGreen source and README](https://github.com/acidanthera/WhateverGreen)
- [VirtualSMC](https://github.com/acidanthera/VirtualSMC)
- [OpenIntelWireless / itlwm](https://github.com/OpenIntelWireless/itlwm)

## Legal and privacy

Personal hardware compatibility research; not affiliated with Apple, HP or Dortania. macOS has license restrictions; check the applicable terms. No Apple installers, proprietary Apple binaries, private SMBIOS identifiers or firmware dumps are distributed. A sanitized example EFI is **not** automatically bootable on other machines.

**Contributions are welcome:** include full hardware IDs, a reproducible test case and redacted diagnostics. Never post serial numbers, ROM/MLB/UUID, tokens or unredacted config.plist files.
