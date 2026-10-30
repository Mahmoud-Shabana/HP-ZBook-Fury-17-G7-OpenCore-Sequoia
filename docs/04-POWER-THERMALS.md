# CPU power, cooling, battery and SMC sensor audit

**Evidence:** read-only macOS Sequoia 15.8.1 audit conducted on **2026-10-30**, about fifteen minutes after boot.

## Directly observed measurements

| Measurement | Observed result | Interpretation |
| --- | --- | --- |
| CPU | i7-10850H, 12 logical threads | Correct CPU detected |
| CPU use | **84.24% idle** (top snapshot) | No sustained high foreground load at that instant |
| Memory | 16GiB; about 7.4GiB unused in snapshot | No severe RAM pressure shown |
| CPU power management | **X86PlatformPlugin active** | Positive, but not a complete power management validation |
| CPU package estimate | **2.61W** in powermetrics sample | A **derived CPU package energy model estimate**, not total laptop wattage |
| Average reported CPU frequency | **~1.6GHz** in sample | Not pegged at max turbo |
| Thermal pressure | **Nominal** in sample | No macOS thermal pressure indication at that instant |
| SMC reading | **Invalid key detected!** repeated | Actual CPU temperature/fan RPM **not obtained** |
| Battery device | No AppleSmartBattery in audit | Battery driver integration not demonstrated |
| NVIDIA power consumption | Not measured | dGPU off state unknown |

**Do not conflate the 2.61W derived CPU package value with GPU power, total machine draw, CPU temperature or heat felt on the chassis.** A workstation can feel warm for many reasons including cooling policy, background processes, a dGPU, ambient temperature, and sensors outside macOS.

The output also contained limit markers including **CPU LIMIT THERMAL**, **CPU LIMIT TURBO_ATTENUATION**, and **CPU LIMIT TVB**. Their mere presence in one sample is not proof of a current temperature emergency or thermal throttling: corroborate using actual sensor data and longer recordings.

## Follow-up checks

1. Inspect compatible VirtualSMC monitoring plugins **SMCProcessor.kext** and **SMCSuperIO.kext** at the **same** VirtualSMC release version. They expose sensor data when the HP controller interface is supported, but will not themselves reduce heat.
2. Read actual CPU temperature, frequency, fan tachometers and sustained package power at idle, browser, and moderate CPU load.
3. Investigate whether any dGPU remains electrically awake despite macOS using the Intel UHD 630 and BIOS UMA mode. Avoid untested ACPI power-off patches.
4. Check whether macOS reports battery charge/health and adapter plug/unplug after checking SMCBatteryManager and EC-related ACPI configuration.
5. On this HP workstation, consider the BIOS options **Fan Always on While on AC Power** and **Energy Efficient Turbo** if present; document original values before any change. These can alter fan noise, power and performance.
6. Repeat sleep/wake and AC/battery testing only after stable boot display backlight.

## Safety

No uncontrolled stress testing, thermal overrides or fan shutoff. If the case becomes unusually hot, the fan stalls, or the OS is unstable, stop testing and check physical cooling vents, fan condition and firmware settings. Keep the known-good boot USB as fallback.
