# Contributing

Thank you for helping turn a fragile installation into a reliable, evidence-based compatibility record.

## Before opening an issue

Please read the [hardware inventory](docs/01-HARDWARE.md), [status matrix](docs/02-WHAT-WORKS.md), and [backlight case study](docs/03-GRAPHICS-BACKLIGHT-FIX.md).

- Confirm your **exact HP model**, BIOS version, macOS build, CPU, iGPU PCI ID, display panel, Wi-Fi and audio codec.
- Separate **reproduced results**, **hypotheses**, and **experiments that failed**.
- Provide step-by-step reproduction with whether **login/backlight** worked at cold boot, restart and wake.
- Redact serials, MLB, ROM, SystemUUID, account IDs, private paths, MACs and tokens before attaching any output.
- **Do not upload your complete EFI, raw config.plist, DSDT dump or macOS installer** to issues.

## Preferred contributions

1. Reproducible hardware compatibility tests with objective evidence.
2. Corrected, properly sourced technical documentation (upstream references encouraged).
3. A test log showing how a proposed change affects **login backlight, acceleration, speakers, Wi-Fi and Windows isolation**.
4. Read-only diagnostics, sanitization improvements, or documentation link fixes.

## Pull request checklist

- [ ] I tested or explicitly marked the change **untested**.
- [ ] I documented the machine/panel/macOS version relevant to the change.
- [ ] I explained any risk to the current bootable setup.
- [ ] I have not included private identifiers, binary EFI files, installers or firmware dumps.
- [ ] I ran `python3 tools/check_share_safety.py .` and `python3 tools/check_docs.py .`.
- [ ] I kept the independent Windows NVMe untouched.

## No universal compatibility claims

The repository owner tested one ZBook Fury 17 G7. Do not change “pending” to “working” merely because a device appears in System Information or because an upstream guide describes an available driver.

See [SECURITY.md](SECURITY.md) for reporting accidentally exposed secrets.
