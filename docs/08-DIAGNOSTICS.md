# Reproducible, read-only diagnostic commands

> **Scope:** macOS Sequoia 15.8.1 on the exact ZBook Fury 17 G7. Commands here are for observing, **not** patching or formatting. Run only in a terminal you trust. Do not share full logs publicly without reviewing them for serial IDs, account names and other private information.

## 1. Confirm the booted state

~~~bash
sw_vers
sysctl -n machdep.cpu.brand_string
nvram boot-args
system_profiler SPDisplaysDataType
~~~

For a positive -igfxblr configuration, the boot arguments observed on this machine were:

~~~text
keepsyms=1 debug=0x100 -wegnoegpu -igfxblr igfxonln=1
~~~

**Important:** `nvram boot-args` describes the **running** boot, not necessarily the contents of `/Volumes/OCUSB/EFI/OC/config.plist`. Do not use it alone as a verification of the internal SSD's EFI.

## 2. Backlight registry and ACPI path

~~~bash
ioreg -r -c AppleBacklightDisplay -w0 | head -n 15
ioreg -p IOACPIPlane -w0 | grep -Ei 'PCI0@|GFX0@|PNLF|XNLF'
~~~

The machine showed `PCI0 → GFX0@20000` (not IGPU in the ACPI plane). An earlier PNLF experiment targeted IGPU and did not solve the problem. After the positive -igfxblr boot, **AppleBacklightDisplay** was active. The only decisive functional test is whether the **physical panel** is visibly illuminated and the macOS Brightness slider truly changes its luminance.

A screenshot cannot prove that a backlight is on. If the panel appears off, carefully use an external light to determine whether an image remains visible. Do not use software changes while guessing about a blank display.

## 3. Power management and CPU load

~~~bash
ioreg -r -c X86PlatformPlugin -w0 | head -n 12
top -l 1 -n 8 -o cpu
pmset -g custom
pmset -g batt
~~~

These read the state; they do not change frequency limits or any fan settings.

## 4. CPU / fan telemetry (optional)

~~~bash
sudo powermetrics --samplers cpu_power -i 1000 -n 3
~~~

macOS may request an administrator password. The actual 2026-10-30 sample reported **a derived 2.61W CPU package estimate** and `Thermal pressure: Nominal`, but repeated **`Invalid key detected!`** notices meant **actual CPU temperature and fan RPM were not established**.

Do **not** infer temperature in °C from power in watts. Different powermetrics builds expose different sampler capabilities. If the supported sampler differs, inspect `powermetrics --help` rather than guessing flags.

## 5. Inventory for Bluetooth and camera

~~~bash
system_profiler SPBluetoothDataType
system_profiler SPCameraDataType
~~~

These commands show controller enumeration only. **Bluetooth pairing and actual video capture must be tested separately** before marking them working. Review the output for identifying information before sharing it.

## 6. List disks without mounting or writing

~~~bash
diskutil list
diskutil info /dev/disk0
~~~

**Warning:** `disk0` is an example from one historical session, not a stable machine identifier. Compare the **physical drive model and size**; on this build, macOS is the **SSDAS256 256GB SATA**, Windows is the **~512GB NVMe**. This guide does **not** run mount, copy, erase, bless or partition commands.

## 7. Collect test evidence safely

Record: date, macOS build, BIOS version, which boot device was selected, exact boot arguments, whether the **Apple logo and login were illuminated**, brightness-slider result, wake result, and whether Wi-Fi/audio still worked. Never upload unredacted config.plist, full `nvram -p`, full `ioreg` dumps, serial numbers, SystemUUID, ROM/MLB or account email addresses.

Use the checklist in [release gates](05-NEXT-STEPS.md) and the issue template for reproducible, privacy-conscious observations.
