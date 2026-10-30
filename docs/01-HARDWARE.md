# Tested hardware inventory

This is a **single-device** record. A similarly named HP ZBook may have a different panel, BIOS, EC, audio codec or wireless card.

| Field | Value | Evidence |
| --- | --- | --- |
| Product | HP ZBook Fury **17 G7** | Owner's Windows/BIOS inventory |
| BIOS | HP S92, **01.25.00** | BIOS inspection |
| BIOS graphics | **UMA Graphics** | Configured by owner |
| CPU | Intel Core **i7-10850H**, Comet Lake-H, 6C/12T, 2.70 GHz base | macOS sysctl and Windows |
| iGPU | Intel UHD Graphics 630, **8086:9BC4** | Windows hardware ID and macOS |
| dGPU | NVIDIA Quadro RTX 3000 6GB | Windows; macOS uses Intel instead |
| Display panel | LGD063F | Panel EDID inventory |
| Native display | **1920×1080 60Hz** | macOS System Settings / system_profiler |
| RAM | **16 GB** | System inventory |
| Wi-Fi | Intel AX201, **8086:06F0** | Windows PCI ID; Wi-Fi tested in macOS |
| Sound | Realtek ALC285, **10EC:0285** | Windows PCI ID; AppleALC tested |
| macOS drive | SATA **SSDAS256**, 256,060,514,304 bytes | macOS diskutil / Windows disk |
| Windows drive | NVMe **MTFDHBA512TDV**, ~512 GB | Separate Windows disk |
| macOS EFI | ~209.7 MB partition on 256 GB SATA disk, previously disk0s1 | Verified in prior diskutil session; **disk numbers are not permanent** |
| macOS | Sequoia **15.8.1 (24H32)** | macOS health audit |
| Emulated Mac | **MacBookPro16,1** | macOS system identity; no serial IDs published |

## Architecture and disk safety

The macOS SATA SSD and Windows NVMe SSD are **different physical devices**. Never assume that a drive number, EFI partition index, or firmware boot entry remains the same across OS versions or computers.

- The **256 GB SATA** disk holds macOS and a previously copied OpenCore EFI.
- The **512 GB NVMe** disk holds Windows and **must not** be repartitioned or have its EFI overwritten.
- An 8 GB FAT32 USB drive labeled **OCUSB** contains the OpenCore bootloader used for the positively tested macOS session.
- The final **-igfxblr** change has not been independently proven bootable from the internal SATA EFI.

## Installed/observed OpenCore-related kernel extensions

| Kext | Version observed |
| --- | --- |
| Lilu | 1.7.2 |
| WhateverGreen | 1.7.1 |
| VirtualSMC | 1.3.8 |
| AppleALC | 1.9.8 |
| AirportItlwm | 2.4.0 (Sequoia build) |
| USBToolBox | 1.2.0 |

There may be additional kexts in the private working EFI. This table lists only versions confirmed from macOS diagnostics.

## Privacy

No platform serial numbers, MLB, ROM, SystemUUID, NVRAM dumps or actual config.plist are published here.
