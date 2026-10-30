#!/bin/bash
# Read-only diagnostic for HP ZBook Fury 17 G7 / macOS Sequoia Hackintosh.
# This exact health-audit script produced the October 30 2026 report.
# Logs can contain user-specific output; NEVER commit/share without manual redaction.
# Does not install, remove, configure, reboot, or change firmware/EFI settings.
set -u
umask 077
if [ -d /Volumes/OCUSB ] && [ -w /Volumes/OCUSB ]; then
    REPORT='/Volumes/OCUSB/ZBOOK_HEALTH_AUDIT.txt'
else
    REPORT="$HOME/Desktop/ZBOOK_HEALTH_AUDIT.txt"
fi
: > "$REPORT" || { printf 'Cannot write diagnostic report: %s\n' "$REPORT" >&2; exit 1; }
exec > >(tee "$REPORT") 2>&1
section() { printf '\n======== %s ========\n' "$1"; }
section 'ZBOOK FURY 17 G7 - HARDWARE AND HEALTH AUDIT (READ ONLY)'
printf 'Date: '; date
printf 'macOS version: '; sw_vers -productVersion 2>/dev/null || true
printf 'macOS build: '; sw_vers -buildVersion 2>/dev/null || true
printf 'CPU model: '; sysctl -n machdep.cpu.brand_string 2>/dev/null || true
printf 'Logical CPU threads: '; sysctl -n hw.logicalcpu 2>/dev/null || true
printf 'Mac model presented: '; sysctl -n hw.model 2>/dev/null || true
printf 'Uptime: '; uptime
section 'CURRENT BOOT FLAGS (NO HARDWARE SERIAL NUMBERS)'
nvram boot-args 2>&1 || true
section 'CPU POWER MANAGEMENT DRIVERS'
printf 'X86PlatformPlugin service (should exist):\n'
ioreg -r -c X86PlatformPlugin -w0 2>/dev/null | head -n 9 || true
printf 'X86PlatformShim service (informational):\n'
ioreg -r -c X86PlatformShim -w0 2>/dev/null | head -n 7 || true
section 'CURRENT CPU AND MEMORY LOAD'
top -l 1 -n 14 -o cpu -stats pid,command,cpu,mem 2>&1 | head -n 29 || true
printf '\nMemory pressure: \n'
memory_pressure -Q 2>/dev/null | tail -n 7 || true
section 'POWER AND BATTERY'
pmset -g batt 2>&1 || true
printf '\nPower management settings:\n'
pmset -g custom 2>&1 | head -n 85 || true
printf '\nAppleSmartBattery device (names only):\n'
ioreg -r -c AppleSmartBattery -w0 2>/dev/null | head -n 5 || true
section 'DISPLAY AND BACKLIGHT'
system_profiler SPDisplaysDataType 2>/dev/null | grep -Ei 'Chipset Model|VRAM|Metal Support|Resolution|Refresh Rate|Main Display|Built-in|Connection Type|Display Type|Graphics|Displays' | head -n 35 || true
printf '\nAppleBacklightDisplay device:\n'
ioreg -r -c AppleBacklightDisplay -w0 2>/dev/null | head -n 7 || true
printf '\nACPI GPU / panel naming:\n'
ioreg -p IOACPIPlane -w0 2>/dev/null | grep -Ei 'PCI0@|GFX0@|IGPU@|PNLF@|PEGP@|DGPU@|PEG[0-9]@|XNLF@' | head -n 26 || true
section 'LOADED HACKINTOSH DRIVERS'
kmutil showloaded 2>/dev/null | grep -Ei 'Lilu|WhateverGreen|VirtualSMC|SMCBatteryManager|AppleALC|AirportItlwm|IntelBTPatcher|IntelBluetoothFirmware|BlueToolFixup|VoodooPS2|VoodooI2C|VoodooInput|USBToolBox|UTB|NVMeFix|CPUFriend' | head -n 45 || true
section 'BLUETOOTH / CAMERA DETECTION (NO DEVICE IDENTIFIERS)'
system_profiler SPBluetoothDataType 2>/dev/null | grep -Ei '^ *Bluetooth:|^ *Bluetooth Controller:|^ *State:|^ *Chipset:|^ *Discoverable:|^ *Bluetooth Low Energy Supported:' | head -n 12 || true
printf '\nCamera categories found:\n'
system_profiler SPCameraDataType 2>/dev/null | grep -Ei 'Camera:|FaceTime HD Camera|Built-in Camera|HD Webcam|HP Wide Vision' | head -n 12 || true
section 'APPLE POWERMETRICS - SHORT CPU / FAN / THERMAL SAMPLE'
printf 'macOS may request your administrator password. powermetrics is READ ONLY.\n'
printf 'If no temperature or fan readings appear, the sensor interface may be unavailable on this Hackintosh.\n'
if command -v powermetrics >/dev/null 2>&1; then
    sudo powermetrics -n 2 -i 1000 -s cpu_power,smc,thermal 2>&1 | grep -Ei 'CPU|Core|Package|Power|Frequency|Residency|Temperature|Fan|RPM|Thermal|Pressure|Speed|error|unknown|not supported|invalid|warning|sampling' | head -n 110 || true
else
    printf 'powermetrics unavailable.\n'
fi
section 'AUDIT COMPLETE'
printf 'Saved report: %s\n' "$REPORT"
printf 'No EFI, BIOS, macOS settings, or Windows data was changed.\n'
