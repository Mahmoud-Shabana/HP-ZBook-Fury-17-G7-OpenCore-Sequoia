# Case study: Intel UHD 630 acceleration and LCD backlight

**Device:** HP ZBook Fury 17 G7, i7-10850H (Comet Lake), UHD 630 (8086:9BC4), LGD063F 1080p 60Hz, Sequoia 15.8.1.

## Symptoms and timeline

1. Earlier fallback boot arguments that disabled acceleration produced a desktop with roughly **7MB video memory**, no Metal support and poor performance.
2. Enabling native Intel graphics produced boot loops, panics or a black internal display in several configurations.
3. One earlier macOS panic named **AppleIntelCFLGraphicsFramebuffer::SetupDPTimings** and a divide-by-zero in WindowServer, pointing toward display timing / link handling.
4. A combination of Intel framebuffer properties, explicit DPCD maximum link rate and original LG panel EDID yielded **1536MB VRAM and Metal 3** on the internal panel. These were preserved.
5. **igfxonln=1** helped show the Apple logo and progress bar in an earlier successful session. That did not fully stabilize the login backlight.
6. A distinctive later failure was diagnosed with a **phone flashlight**: after the fully illuminated Apple logo, the panel looked black, yet the login controls and desktop icons were actually visible under direct light. The problem was **panel backlight**, not an absent image.
7. Trying the WhateverGreen alternative backlight argument **-igfxblt** and testing different PNLF tables did not fix the intermittent login black screen.
8. A comparison with similar Comet Lake laptop reports led to an isolated trial of **-igfxblr** in place of **-igfxblt**.
9. In that boot, macOS reported the exact new argument, the desktop was illuminated and the **Brightness** slider in Display Settings actually increased and decreased backlight brightness. The subsequent audit showed an active **AppleBacklightDisplay** service.
10. This remains a **promising working session, not yet a proven permanent fix** until multiple restarts, cold boots and lid/wake tests have passed.

## Boot arguments from the positive test

~~~text
keepsyms=1 debug=0x100 -wegnoegpu -igfxblr igfxonln=1
~~~

- **-igfxblr**: WhateverGreen Intel graphics backlight register fix (tested positively here).
- **-igfxblt**: alternative fix, previously unsuccessful in this configuration.
- **igfxonln=1**: WhateverGreen force-online framebuffer behavior, part of positive setup.
- **-wegnoegpu**: prevent unsupported NVIDIA GPU use; **not evidence of electrical power-off**.
- keepsyms/debug: preserve diagnostic context.

These are not universally correct for different laptop panels.

## Known working graphics properties (illustrative)

OpenCore DeviceProperties path:

~~~text
PciRoot(0x0)/Pci(0x2,0x0)
~~~

| Data key | Hexadecimal value |
| --- | --- |
| AAPL,ig-platform-id | 00009b3e |
| framebuffer-patch-enable | 01000000 |
| framebuffer-stolenmem | 00003001 |
| framebuffer-fbmem | 00009000 |
| enable-dpcd-max-link-rate-fix | 01000000 |
| dpcd-max-link-rate | 0a000000 |

Also included in the working private config: **128-byte LGD063F EDID override** as AAPL00,override-no-connect. The EDID bytes are not bundled; verify the actual physical display before adapting.

**Preserve these settings until stability is demonstrated.** Blindly reverting DPCD/EDID can reintroduce the earlier graphics failures.

## ACPI/P NLF warning

The laptop's actual ACPI tree showed **PCI0 → GFX0@20000**, while one experimental PNLF table had been modified to refer to **IGPU**. A later experiment restored the official GFX0 version, but the dark backlight issue persisted. **PNLF naming alone was not the winning fix.** Never infer an ACPI device's name from the name displayed in System Information.

Some diagnostics did not find PNLF under the IOACPIPlane, while the post--igfxblr successful session did expose AppleBacklightDisplay. This is evidence of changed driver state, not proof of a uniquely responsible cause.

## Reproducible acceptance tests

- [ ] 3 warm restarts: Apple logo, login screen and desktop **all visibly lit**
- [ ] 2 full shutdowns/cold starts, still lit without flashlight
- [x] 1 successful Brightness slider manual up/down test
- [ ] Lid-close/wake test with brightness functional afterward
- [ ] Battery and AC power transitions
- [ ] Verify exact EFI SHA256 of stable USB and copied internal SATA boot
- [ ] Confirm no broken audio / Wi-Fi after wake

A full-screen screenshot alone cannot demonstrate panel backlight health; flashlight diagnosis and physical brightness-slider verification were critical.

## References

- [WhateverGreen](https://github.com/acidanthera/WhateverGreen) — Intel framebuffer and backlight arguments
- [Dortania: Comet Lake/Coffee Lake Plus laptop guide](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/coffee-lake-plus.html)
- [Dortania ACPI](https://dortania.github.io/Getting-Started-With-ACPI/)

The most useful community comparison was an HP EliteBook 850 G7 owner describing a black panel with login graphics visible under a flashlight, who reported success switching the register fix. Hardware similarity is not proof of an identical root cause.
