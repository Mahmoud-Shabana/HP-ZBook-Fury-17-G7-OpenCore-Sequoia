# Remaining acceptance tests and release checklist

The goal is a **stable everyday machine**, not a one-time successful desktop screenshot.

## A. Backlight and graphics — first priority

- [x] Metal 3 acceleration with Intel UHD 630 and 1536MB VRAM
- [x] Built-in 1920×1080 60Hz display
- [x] One successful -igfxblr session, brightness slider controls physical backlight
- [ ] 3 warm restarts: login and desktop illuminated without flashlight
- [ ] 2 cold boots: no intermittent black panel
- [ ] Display brightness after lid closing/reopening
- [ ] Sleep/wake screen, Wi-Fi, audio remain functional
- [ ] Test on battery power as well as AC power

## B. CPU, thermals and battery

- [x] X86PlatformPlugin loaded
- [x] Idle CPU load reasonable in a snapshot
- [ ] Record **actual temperature** (not derived package wattage)
- [ ] Record fan RPM if accessible on HP EC
- [ ] Check fan speeds/heat at 10 minutes idle, browser and mild sustained load
- [ ] Verify dGPU electrical power state
- [ ] Verify battery %, AC plug/unplug, suspend on low battery

## C. Everyday devices

- [x] Intel AX201 Wi-Fi internet
- [x] Realtek ALC285 speaker sound
- [x] Keyboard Arabic – PC input
- [ ] Touchpad / left-right click / scroll / multi-finger gestures
- [ ] Hardware Fn brightness keys
- [ ] Bluetooth controller can be powered on, and pair with a real device
- [ ] HP HD Camera captures actual video
- [ ] USB-A, USB-C and Thunderbolt functionality
- [ ] Headphones, HDMI / DisplayPort if needed
- [ ] Time synchronization and clean shutdown/reboot
- [ ] Built-in microphone: **intentionally not required**

## D. Final OpenCore and release

- [ ] Save known-good final USB EFI and its SHA-256
- [ ] Identify macOS **256GB SATA SSD** by size/model, not index alone
- [ ] Back up EFI already on that SSD
- [ ] Copy exact verified EFI from USB to **macOS SSD**, never Windows NVMe
- [ ] Compare checksums of OC/config.plist, OpenCore.efi, BOOTx64.efi and kext inventory
- [ ] Test **without USB inserted**, login screen and desktop visibly lit
- [ ] Sanitize private serials, MLB, UUID and ROM before any public EFI upload
- [ ] Scan public files and the exact archive to be released
- [ ] Only then consider a tagged release

## Regression log format

| Date | USB/internal | Cold/restart/wake | Backlight at login | Brightness slider | Audio/Wi-Fi | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| 2026-10-30 | OCUSB | Positive session | Intermittency not yet excluded | ✅ Worked | ✅ Worked | -igfxblr |

**Unknown means untested, not working.** Update this journal from observations only.
