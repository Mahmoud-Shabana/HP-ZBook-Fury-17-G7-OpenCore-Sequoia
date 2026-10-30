# Changelog

All technical statuses refer to **this particular HP ZBook Fury 17 G7**. Dates are observations, not release announcements.

## [Unreleased] — documentation and validation phase

### Added
- Bilingual, visually redesigned project homepage and hardware overview.
- Reproducible diagnostics, practical FAQ, contribution and privacy policy.
- Explicit verification gates for repeated LCD backlight starts, cooling, battery, sleep and SATA EFI.
- Privacy and relative-document-link checks for pull requests.

### Still pending
- Repeat warm/cold starts with `-igfxblr`; sleep/wake stability.
- Actual CPU temperature and fan tachometers.
- Bluetooth pairing, camera, trackpad, battery and port tests.
- Sanitized example EFI only **after** reliable independent SATA boot and privacy checks.

## 2026-10-30 — successful working macOS session

- Confirmed macOS **Sequoia 15.8.1 (24H32)**, Intel UHD 630 **Metal 3**, 1536 MB dynamic VRAM, native Full HD display, Intel AX201 Wi-Fi and Realtek ALC285 speaker output.
- Reproduced an intermittent **black LCD backlight with visible macOS image under flashlight**.
- Verified `-igfxblr` in boot-args during an illuminated session; macOS brightness slider physically dimmed/brightened the display.
- Measured CPU power and workload snapshot; **could not obtain actual thermal sensors** via the available SMC interface.
- Confirmed separate Windows 512GB NVMe and macOS 256GB SATA drives.

## Principles

A positive boot is not a stable release. The README and status table only mark features *tested* when an end-to-end test actually happened.
