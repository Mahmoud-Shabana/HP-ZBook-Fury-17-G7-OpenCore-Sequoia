# Hardware compatibility: tested, partial, unknown

**Date of last confirmed evidence:** 2026-10-30. Status means what was tested on this exact laptop, not assumed capability.

| Component | State | Proof and limitations |
| --- | --- | --- |
| macOS boot from OCUSB | ✅ Tested | Reached usable desktop |
| iGPU hardware acceleration | ✅ Tested | Intel UHD 630, Metal 3, 1536MB dynamic VRAM |
| Built-in LG panel | ✅ Tested | Full HD 1920×1080 at 60Hz |
| Brightness slider | ✅ One positive session | Physically changed panel backlight after using -igfxblr |
| Boot/login backlight across 3+ reboots | ⏳ Pending | Earlier runs suffered near-black panel; must repeat testing |
| Wi-Fi | ✅ Tested | Intel AX201 / AirportItlwm 2.4.0 |
| Internal speaker output | ✅ Tested | Realtek ALC285 / AppleALC 1.9.8 / layout-id 33 |
| Keyboard English | ✅ Usable | Standard macOS keys |
| Arabic PC keyboard layout | ✅ Tested | macOS Keyboard Input Sources: Arabic – PC |
| Power management | 🟡 Partially tested | X86PlatformPlugin active and CPU idle states present; no thermal confirmation |
| CPU temperature sensors | ❌ Not available in audit | powermetrics produced invalid SMC key reports |
| Fan sensor RPM | ❌ Not available in audit | Hardware monitor support still unknown |
| Battery reporting | ⏳ Pending | No AppleSmartBattery entry in audit |
| NVIDIA RTX 3000 electrical shutdown | ⏳ Unknown | -wegnoegpu hides dGPU from use but does not prove power-off |
| Bluetooth | ⏳ Pending | Controller detected, reported Off |
| Internal webcam | ⏳ Pending | HP HD Camera detected, video capture untested |
| Touchpad, scrolling, gestures | ⏳ Pending | Needs owner testing |
| Hardware brightness Fn keys | ⏳ Pending | Slider works; keyboard control not established |
| Lid / sleep / wake | ⏳ Pending | Important due to historic backlight issue |
| USB-A / USB-C / Thunderbolt | ⏳ Pending | USB map needs port-by-port test |
| Headphones / HDMI / external monitors | ⏳ Pending | Not established |
| Internal macOS SSD standalone boot | ⏳ Pending | Old EFI copy reached Apple logo; final USB settings not transferred/tested |
| Internal microphone | ➖ Not required | Explicitly excluded by owner |

**Definition of 'works':** end-to-end observed functionality. A device merely appearing in System Information does not count as a successful test. See [test checklist](05-NEXT-STEPS.md).
