# Publishing and maintenance

This project begins with accurate documentation, not a claim of universal compatibility.

## Repository philosophy

- State **tested**, **not tested** and **failed** separately.
- Keep a working fallback USB and record the precise boot configuration before editing.
- Do not upload a raw OpenCore EFI until it is both proven stable and sanitized.
- Preserve the separate Windows NVMe installation; only touch the explicitly identified macOS SATA disk.
- Document any correction to the technical record instead of rewriting history.
- Prefer screenshots cropped to the relevant hardware window; never expose account UI or serials.

## What to contribute

A new contributor should provide their **exact device model**, BIOS revision, iGPU PCI ID, physical panel ID and resolution, macOS build, versions of relevant kexts, reproduction steps, and **redacted** relevant logs. Attach a photo of the flashlight-test symptom if useful; an ordinary screen capture cannot prove the LCD backlight is on.

## Release gates

A version can be tagged stable only after reliable repeated cold and warm boots; functioning login backlight, brightness control, audio and Wi-Fi; verified independent SATA boot; cooling and battery checks; and privacy review of the exact released artifacts.

## Project scope

This is a single machine's OpenCore research diary. It does not contain a macOS installer, proprietary operating system images, or guarantees for other ZBook variants.
