# Credits, related projects and cross-project collaboration

> **Three separate roles:** the original macOS image builder, the fork which produced our exact installer artifact, and an independent Hackintosh project for a **different HP ZBook Fury G7 variant**. We credit each without implying a shared EFI or an endorsement.

## 1. macOS ISO/DMG image builder — @LongQT-sea

**[LongQT-sea / macos-iso-builder](https://github.com/LongQT-sea/macos-iso-builder)** — by **[@LongQT-sea](https://github.com/LongQT-sea)** (Tieu Long).

- **Contribution:** the upstream open-source GitHub Actions workflow used to build macOS installer disk images from Apple's servers.
- **In our project:** we obtained a macOS Sequoia 15.8.1 DMG artifact generated with this builder.
- **Link back:** [Our exact build provenance and checksum](10-INSTALLER-SOURCE.md).
- **Acknowledgment:** thank you for making the installer-builder workflow public. Our downstream success does not imply the upstream project tested or approved this HP laptop.

### Exact artifact: @Leo213github08

Our downloaded file, `macOS_Sequoia_15.8.1.dmg.img`, was hosted in the **[Leo213github08/macos-iso-builder](https://github.com/Leo213github08/macos-iso-builder)** fork by **[@Leo213github08](https://github.com/Leo213github08)**.

**[Original GitHub Actions artifact, run 40181607639](https://github.com/Leo213github08/macos-iso-builder/actions/runs/40181607639/artifacts/12594984907)**. This is a time-limited artifact, not a permanently hosted file; full size and SHA256 are recorded in the [installer source page](10-INSTALLER-SOURCE.md).

## 2. Related HP Fury G7 project — @kilianbalaguer

**[kilianbalaguer / HPZBook-Fury-G7-Hackintosh](https://github.com/kilianbalaguer/HPZBook-Fury-G7-Hackintosh)** — by **[@kilianbalaguer](https://github.com/kilianbalaguer)**.

The project documents a different **HP ZBook Fury 15 G7** (15-inch, Intel i9, 4K touchscreen, quad-boot with macOS Tahoe beta). It is a useful reference for **model-family differences** and a community-led installation journey.

| | This repository | Kilian's repository |
| --- | --- | --- |
| Laptop | **HP ZBook Fury 17 G7** | **HP ZBook Fury 15 G7** |
| CPU | **Intel i7-10850H** | **Intel i9** (exact CPU SKU should be verified in upstream docs) |
| Internal screen | **17-inch 1080p LGD063F** | **15-inch 4K touchscreen** |
| macOS documented | **Sequoia 15.8.1** | **Tahoe 26 beta**, among other systems |
| Graphics details | **UHD 630, 8086:9BC4; Metal 3** | Upstream's different platform ID and panel patches |
| Fix approach | **DPCD/EDID and tested `-igfxblr`** | Upstream's **4K/EDID/HiDPI** panel guidance |
| Current state | Active documentation and hardware verification | **Archived and read-only** since 2026-03-04 |

**Important:** Kilian's README explains that the owner **sold that particular laptop** and cannot test or maintain new hardware-specific fixes. Please respect that notice; open **Fury 17 G7-specific bugs here**, not in his archived Fury 15 G7 project. We thank him for publishing his experience and do **not** claim to have used his full EFI or to be endorsed by him.

## 3. Could the links work both ways?

**This project's outgoing references are live.** Inbound links from other authors' pages are voluntary and can only be published by the people with write access to those repositories.

- For **LongQT-sea**, we can respectfully share our case study and ask whether the maintainer maintains a community-examples section. Any addition would be at their discretion.
- For **kilianbalaguer**, their repository is currently **archived/read-only**; their archived README cannot be changed via a normal pull request. A backlink would require the owner to unarchive it or voluntarily link elsewhere.
- The usernames in this document and README are **real GitHub mentions**, but mentions/notifications are subject to GitHub's own user settings and may not guarantee a notification.

## 4. Share our related case study

**[HP ZBook Fury 17 G7 — OpenCore macOS Sequoia 15.8.1](https://github.com/Mahmoud-Shabana/HP-ZBook-Fury-17-G7-OpenCore-Sequoia)**

Focus: **real i7-10850H/1080p panel measurements, a flashlight-visible login despite a dark backlight, a positive `-igfxblr` session, Metal 3 acceleration, Intel AX201 Wi-Fi, and ALC285 internal speakers**. Stability tests and standalone SATA boot are still pending.

Please link to this repo only when it is genuinely relevant to readers. We welcome related device comparisons and reproducible bug reports via our [Issue tracker](https://github.com/Mahmoud-Shabana/HP-ZBook-Fury-17-G7-OpenCore-Sequoia/issues).

---

No affiliation, endorsement or collaboration is implied by these credits. These references are for attribution and community navigation. Always follow each project's license and maintainer preferences.
