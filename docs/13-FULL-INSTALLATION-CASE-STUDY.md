# Full installation case study — HP ZBook Fury 17 G7 / Sequoia 15.8.1

> **Audience:** people researching this **exact HP ZBook hardware revision**. This is an **evidence-backed account of the steps taken**, not a guaranteed one-click install. A full macOS disk image or private SMBIOS data is not hosted here. Avoid writing raw images or partition tables to disks until you independently verify physical disk identity and have tested backups.

**Start here:** [Actual installer image download, SHA256 and upstream builder credits](10-INSTALLER-SOURCE.md) · [Scripts](12-SCRIPTS.md) · [Backlight deep dive](03-GRAPHICS-BACKLIGHT-FIX.md) · [Bug report](11-BUG-REPORTS-AND-SUPPORT.md).

## 0. Exact machine used

| Part | Observed hardware |
| --- | --- |
| Laptop | HP ZBook Fury **17 G7** |
| CPU | Intel i7-10850H, 6 cores / 12 threads, Comet Lake-H |
| Graphics | Intel UHD 630, **8086:9BC4**; NVIDIA Quadro RTX 3000 6GB unsupported for acceleration |
| Internal display | LGD063F, 1920×1080 60Hz |
| Wireless | Intel AX201, **8086:06F0** |
| Audio | Realtek ALC285, **10EC:0285** |
| BIOS | HP S92 01.25.00, **UMA Graphics** |
| macOS storage | Dedicated **SSDAS256 SATA 256GB** |
| Windows storage | Separate **MTFDHBA512TDV NVMe 512GB** |
| Emulated model | MacBookPro16,1, private serials excluded |

The SATA SSD was originally prepared using a USB enclosure and later connected internally to the motherboard. This **does not** mean the Windows SSD was reformatted.

## 1. Obtain the exact full installer

The installer came from **LongQT-sea's original open-source macos-iso-builder**, via a public GitHub Actions artifact in Leo213github08's fork:

- [**Original builder and instructions — credit to LongQT-sea**](https://github.com/LongQT-sea/macos-iso-builder)
- [**Image used — Sequoia 15.8.1 DMG artifact #12594984907**](https://github.com/Leo213github08/macos-iso-builder/actions/runs/40181607639/artifacts/12594984907)
- Exact size: **17,658,073,088 bytes**
- SHA256: **1e288befa2e851ece653850cecaf06de8e808e1376b13cf20fc5768699ba146e**

**Important:** the download artifact is ephemeral, not a permanent CDN address. The source records its expiry as **2026-11-09**, and downloading may require a GitHub session. To rebuild a new full installer, follow the upstream [GitHub Actions workflow instructions](https://github.com/LongQT-sea/macos-iso-builder/blob/main/README.md). If rebuilt, do not assume its checksum is identical.

On Windows, a **read-only hash check** is:

~~~powershell
Get-FileHash -Algorithm SHA256 -LiteralPath "C:\path\to\macOS_Sequoia_15.8.1.dmg.img"
~~~

## 2. Prepare physically separate disks

The process involved two distinct types of boot media:

1. **256GB SATA SSD:** holds the macOS full offline installer and eventual macOS installation. At preparation time the image supplied an EFI partition and installer HFS+ volume; a separate region was intended for the eventual APFS installation target.
2. **FAT32 OCUSB flash drive:** holds the OpenCore bootloader, ACPI tables, required drivers and kexts. Its presence was needed during troubleshooting and booting the installer.

**This repo deliberately provides no automatic disk-write script.** Historically, Windows disk numbers changed as the SSD moved from USB adapter to internal SATA. The separate Windows **512GB NVMe drive must remain entirely untouched**; do not reuse Windows Drive 0/1 numbering from someone else's report.

The upstream builder's [README](https://github.com/LongQT-sea/macos-iso-builder) explains working with DMG boot images (including Rufus where appropriate). Always confirm that the target is the **macOS SSD** before imaging anything. Back up every existing partition first.

## 3. Boot through OpenCore, install Sequoia, and select the correct APFS destination

On the HP, firmware boot selection uses **F9**. Select the **OCUSB UEFI** entry, then the actual **Install macOS Sequoia** entry in OpenCore's picker. A visible installer name does not prove macOS is already installed.

Once the installer interface loads, use Disk Utility's **Show All Devices** view and verify **physical drive model, capacity and partition**. Format only the intended empty macOS destination region/partition as APFS, rather than erasing the Windows drive or a whole physical device indiscriminately.

The original installation required multiple boot attempts due to OpenCore/graphics issues. During installation reboots, the desired boot entry can change; do not guess between a macOS installer and installed system.

## 4. Configure Intel graphics for accelerated display output

This machine's iGPU is Intel UHD 630 **8086:9BC4**. An early `-igfxvesa` fallback booted to the desktop but only showed about **7MB VRAM** and lacked Metal acceleration. That was useful for isolation, **not** the finished configuration.

The working Intel DeviceProperties combination recorded on OCUSB used:

~~~text
PciRoot(0x0)/Pci(0x2,0x0)
AAPL,ig-platform-id                 00009b3e
framebuffer-fbmem                   00009000
framebuffer-patch-enable            01000000
framebuffer-stolenmem               00003001
enable-dpcd-max-link-rate-fix       01000000
dpcd-max-link-rate                  0a000000
AAPL00,override-no-connect          [128-byte LGD063F-specific EDID; not published]
~~~

**Why these values matter:** one earlier panic named `AppleIntelCFLGraphicsFramebuffer::SetupDPTimings`. The DPCD correction and panel-specific EDID were part of eventually reaching **1536 MB dynamic VRAM, Metal 3 and 1920×1080 60Hz**. Blindly reusing the EDID on a different display could make it worse.

## 5. Fix the black screen after the illuminated Apple logo

**Symptom:** the logo and progress bar were bright, then the internal panel seemed to go fully black, even though **audio played and the keyboard worked**. A flashlight revealed login fields and the Dock. The Mac was rendering an image; the LCD **backlight** was off.

Experiments with a PNLF ACPI table, `igfxonln=1` and the alternative WhateverGreen `-igfxblt` did not reliably light the login. The actual ACPI GPU path showed **PCI0 → GFX0**, even though some driver-facing tools referred to IGPU.

A community-inspired isolated change replaced `-igfxblt` with **`-igfxblr`** while preserving the accelerated graphics/DPCD setup:

~~~text
keepsyms=1 debug=0x100 -wegnoegpu -igfxblr igfxonln=1
~~~

The user verified these **running** boot flags, saw an illuminated desktop and physically changed brightness through **System Settings → Displays**. The later health audit found **AppleBacklightDisplay active**.

**Acceptance still pending:** 3 warm restarts, 2 cold boots, and lid sleep/wake without any flashlight at login. One successful session is not sufficient to claim permanent stability. Read the [complete graphics/backlight case study](03-GRAPHICS-BACKLIGHT-FIX.md).

## 6. Restore Wi-Fi, speakers and the Windows-like Arabic keyboard

- **Wi-Fi:** Intel AX201 with the tested Sequoia-compatible **AirportItlwm 2.4.0**. Verified connected.
- **Speakers:** Realtek ALC285 with **AppleALC 1.9.8** and little-endian layout-id **33** (hex value 21000000). Verified audible output.
- **Keyboard:** Input source **Arabic – PC** in macOS System Settings → Keyboard, matching familiar Windows Arabic key locations. Owner confirmed.
- Built-in microphone is intentionally out of scope.

Only versions observed in the macOS session are claimed here; no universal plugin compatibility is implied.

## 7. Validate thermals and peripherals honestly

The 30 October read-only report showed `X86PlatformPlugin` active, **84.24% CPU idle** in one snapshot, and a **2.61W derived CPU package estimate**, but actual temperature and fan RPM were not available due to SMC invalid-key notices. The Quadro's electrical power-off state is also not verified.

No unsupported claims are made about battery, Bluetooth pairing, trackpad gestures, webcam, ports, Sleep/Wake or long-term temperature. See [power and thermals](04-POWER-THERMALS.md) and [read-only scripts](12-SCRIPTS.md).

## 8. Transfer final EFI to SATA only **after** validation

A historical USB-to-internal copy was attempted and reached an Apple logo on internal boot, but the **old backlight issue persisted**. Later, the USB received the positive **-igfxblr** change. **The final USB contents have not yet been proven bootable from internal SATA without the USB.**

The archived original script is published as non-executable text solely for record keeping, because it **performs privileged EFI writes** and had an incorrect `/usr/bin/sync` path. **Do not execute or repurpose it on another PC.**

When the setup is stable, first back up the **correct 256GB SATA SSD** EFI, verify hashes, copy the proven final USB files *only to that disk*, disconnect the USB and validate the login backlight, Wi-Fi and speakers. Keep the **512GB Windows NVMe** completely out of scope. See [internal EFI guide](06-INTERNAL-EFI.md).

## 9. Help other ZBook owners

If your machine has the same flashlight-visible black screen, or a different failure, use the bilingual **[Bug Report form](https://github.com/Mahmoud-Shabana/HP-ZBook-Fury-17-G7-OpenCore-Sequoia/issues/new?template=bug-report.yml)** and include hardware, boot mode, observed behavior, and redacted logs. The repository maintainer will review and reply as available. See [support policy](11-BUG-REPORTS-AND-SUPPORT.md).

---

**References:** [Original installer builder](https://github.com/LongQT-sea/macos-iso-builder) · [Dortania OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/) · [WhateverGreen](https://github.com/acidanthera/WhateverGreen) · [VirtualSMC](https://github.com/acidanthera/VirtualSMC). No proprietary macOS installer, raw EFI with unique identifiers, or device firmware image is redistributed in this repository.
