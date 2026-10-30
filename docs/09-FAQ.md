# Frequently asked questions

## Is this a ready-to-install EFI?

**No.** The repository documents one machine's real results. The final USB configuration requires repeated boot stability tests and a private-data audit before an example EFI could even be considered for publication. A config.plist often contains unique SMBIOS identifiers.

## Can I use this on HP ZBook Fury 15 G7 or another 17 G7?

Not safely without checking **the exact CPU, GPU PCI ID, display panel/EDID, BIOS revision, wireless module, audio codec and ACPI device paths**. Graphics data that works on LGD063F can produce a black screen or panic on a different display.

## The Apple logo appears, then the display goes black. Did macOS fail to boot?

Not necessarily. On the tested machine, the **login and desktop were visible with a flashlight**, and audio played. This showed a backlight failure while the panel still rendered an image. Other black screens can have entirely different causes, so diagnose first.

## Why use -igfxblr rather than -igfxblt?

WhateverGreen documents two related but different backlight register fixes. The [official FAQ](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md) explains why the alternative fix was developed for macOS 13.4 and later. Despite that upstream rationale, this exact Comet Lake/Sequoia setup showed **dark login backlight with -igfxblt** and a **positive brightness session with -igfxblr**. **This is empirical and device-specific, not a universal prescription.**

## Why is Metal acceleration important?

An earlier VESA fallback displayed the desktop but reported roughly 7 MB graphics memory and no Metal. Native acceleration yielded **Metal 3 and 1536 MB dynamic VRAM**, enabling an ordinary responsive macOS desktop.

## The backlight is working once. Is it fixed?

**Not yet proven.** Repeat **3 restarts**, **2 complete power-offs/cold starts**, a lid sleep/wake cycle, and an unplugged/plugged power transition. The login must be readable **without a flashlight** every time.

## Is the NVIDIA Quadro RTX 3000 fully powered off?

**Not established.** `-wegnoegpu` prevents macOS from using the unsupported dGPU but does not prove electrical power gating. Actual power state needs inspection, especially during thermal diagnosis.

## Why does the ZBook feel warm if the audit reports 2.61 watts?

That **2.61W** was a **derived estimate of CPU-package power at one moment**, not total system consumption or CPU temperature. The audit did not read actual degrees Celsius or fan RPM. Check ventilation, firmware fan behavior, current workloads and credible sensors before making thermal changes.

## Is battery reporting / Bluetooth / touchpad / webcam working?

Their **end-to-end functional status has not been established**, even when a device was detected in System Information. Use the [test checklist](05-NEXT-STEPS.md) to avoid assuming success.

## Why not copy the EFI from the USB to the Windows drive?

Windows and macOS occupy **separate physical SSDs**. The safe target, when ready, is the **256GB macOS SATA SSD**, not the **512GB Windows NVMe**. See [internal EFI safeguards](06-INTERNAL-EFI.md).

## What about Arabic keyboard layout?

Choose **Arabic – PC** in macOS **System Settings → Keyboard → Input Sources** to match standard Windows Arabic key positions more closely. The tested machine's owner confirmed this works.

## Where are the real SMBIOS values?

They are **intentionally omitted**. Never publish SystemSerialNumber, MLB, ROM, SystemUUID or private machine firmware data.

## Can I contribute a fix?

Yes. Follow [CONTRIBUTING.md](../CONTRIBUTING.md), and supply the machine's exact **non-personal** hardware identifiers plus a **redacted** reproducible test. Device and panel variations matter.
