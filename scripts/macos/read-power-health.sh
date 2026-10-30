#!/bin/bash
# Read-only: no sleep changes, fan overrides, or ACPI/EFI writes.
set -u
echo '=== CPU / macOS ==='
sysctl -n machdep.cpu.brand_string
sw_vers -productVersion
echo '=== Power management ==='
ioreg -r -c X86PlatformPlugin -w0 | head -n 5
echo '=== CPU activity snapshot ==='
top -l 1 -n 8 -o cpu -stats pid,command,cpu,mem | head -n 20
echo '=== Battery ==='
pmset -g batt
echo '=== AppleSmartBattery ==='
ioreg -r -c AppleSmartBattery -w0 | head -n 5
echo '=== Loaded relevant kexts ==='
kmutil showloaded 2>/dev/null | grep -Ei 'VirtualSMC|SMCProcessor|SMCSuperIO|SMCBatteryManager|Lilu|WhateverGreen|AppleALC|AirportItlwm' || true
echo 'CPU package watts are NOT CPU temperature in Celsius.'
