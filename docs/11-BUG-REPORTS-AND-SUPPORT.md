# Help, troubleshooting and bug reports

## Encountered a problem? Open a Bug Report.

**[Open a new Bug Report](https://github.com/Mahmoud-Shabana/HP-ZBook-Fury-17-G7-OpenCore-Sequoia/issues/new?template=bug-report.yml)**

The owner, **[Mahmoud-Shabana](https://github.com/Mahmoud-Shabana)**, welcomes reports and intends to **review and reply to submitted bugs when available**. Responses are best-effort community assistance; they are not guaranteed to happen within any specific time or result in a fix.

Check the [FAQ](09-FAQ.md), [tested compatibility list](02-WHAT-WORKS.md), and [existing issues](https://github.com/Mahmoud-Shabana/HP-ZBook-Fury-17-G7-OpenCore-Sequoia/issues) first.

## Include in the report

1. **Exact laptop model** and BIOS revision (not only "HP G7").
2. Intel CPU, iGPU PCI ID, panel ID and native resolution.
3. macOS version and OpenCore/WhateverGreen versions.
4. The boot entry used (OCUSB, internal SATA, other) and whether Windows is isolated on another disk.
5. What was expected, **what actually happened**, and how to reproduce it.
6. For black screen/backlight: Apple logo lit? Image visible under a flashlight? Display slider physically alters brightness? Was this at login, after login or wake?
7. Current exact **boot flags** (omit serials), proposed change and whether a backup exists.
8. Redacted logs or photos with personal information removed.

## Safety and privacy

Never upload a live EFI, unredacted OpenCore config.plist, SystemSerialNumber, MLB, ROM, SystemUUID, macOS installers, tokens, screenshots of signed-in accounts, complete `nvram -p` output, or raw system dumps.

Never modify or format the separate Windows NVMe EFI as a troubleshooting shortcut. A screenshot of the desktop alone cannot confirm that the *physical* panel backlight is illuminated.

## Triage policy

Bug reports should be labeled *reproduced*, *needs diagnostics*, *configuration-specific*, or *unverified* based on evidence. The maintainer may request additional redacted data and update the technical guide if a proposed fix is reproduced. Unconfirmed community suggestions are never automatically described as guaranteed solutions.
