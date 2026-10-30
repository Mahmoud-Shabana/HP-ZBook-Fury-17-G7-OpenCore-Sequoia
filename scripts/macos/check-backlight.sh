#!/bin/bash
# Read-only backlight status, no firmware or EFI modifications.
set -u
printf '=== macOS ===\n'
sw_vers -productVersion
printf '\n=== Running boot arguments ===\n'
nvram boot-args 2>&1 || true
printf '\n=== Display backlight service ===\n'
ioreg -r -c AppleBacklightDisplay -w0 2>&1 | head -n 12
printf '\n=== Intel graphics and panel ACPI names ===\n'
ioreg -p IOACPIPlane -w0 2>&1 | grep -Ei 'PCI0@|GFX0@|IGPU@|PNLF@|XNLF@' | head -n 30 || true
printf '\n=== Graphics support ===\n'
system_profiler SPDisplaysDataType 2>&1 | grep -Ei 'Graphics|Intel|VRAM|Metal|Resolution|Main Display|Connection Type|Refresh Rate' | head -n 30 || true
printf '\nPhysical brightness must be verified visually; an active service alone is not proof.\n'
