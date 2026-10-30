# Scripts and reproducibility pack

This repo contains **actual diagnostic scripts recovered from the tested OCUSB**, plus additional read-only verifiers written for public documentation.

| File | Purpose | Safety |
| --- | --- | --- |
| [macos/mac_graphics_diagnostics.sh](../scripts/macos/mac_graphics_diagnostics.sh) | Graphics and backlight diagnostic used during troubleshooting | Collects logs; report may contain sensitive data; writes to OCUSB only |
| [macos/check-backlight.sh](../scripts/macos/check-backlight.sh) | Read AppleBacklightDisplay, PNLF/GFX0 and boot flags | Read-only |
| [macos/read-power-health.sh](../scripts/macos/read-power-health.sh) | System power and kext snapshot | Read-only |
| [macos/verify-ocusb-config.sh](../scripts/macos/verify-ocusb-config.sh) | Check present USB EFI and expected graphics boot flags | Read-only |
| [windows/verify-installer.ps1](../scripts/windows/verify-installer.ps1) | Check exact image SHA256 | Read-only |
| [windows/check-disks-readonly.ps1](../scripts/windows/check-disks-readonly.ps1) | Show connected storage model/size without modifying disks | Read-only |
| [historical/INSTALL_INTERNAL_EFI_20261030.sh.txt](../scripts/historical/INSTALL_INTERNAL_EFI_20261030.sh.txt) | Original script preserved solely to explain what was run and the final sync error | **Dangerous historical artifact — NEVER EXECUTE** |

**Important distinction:** The USB graphics diagnostic was used in the original experiment. Some read-only verification scripts were authored **after** installation as reproducibility aids and are not presented as original installer steps.

## Scripts that changed disks or boot configuration

We used additional machine-specific Python and shell scripts while debugging. Some scripts from those experimental iterations contain raw-disk writes, old EFI values, fragile path assumptions, or could cause data loss on another laptop. They are **not provided as a convenient run-all installer**. The historically used internal EFI transfer is included in non-executable text form with a severe warning and bug explanation.

See the [exact third-party full-installer source and credit](10-INSTALLER-SOURCE.md). We link to the upstream image builder instead of copying that GPL-3.0 project and redistributing an Apple installer.

## Data safety

The original graphics script captures crash reports and unified logs; those **outputs are potentially sensitive**. Its public source code is safe to read, but *never upload the generated full report without manual redaction*.

The working USB EFI includes private SMBIOS/PlatformInfo fields and is deliberately **not** published. Always back up the known-good USB before any experiment.
