# Provenance: the exact macOS Sequoia installer used

> **Verified 30 Oct 2026 against Chrome's Windows download history, the local disk-image preparation report and GitHub's original artifact metadata.** The link here identifies the specific image we used, not a guessed replacement.

## Full credit to the original author

**[LongQT-sea / macos-iso-builder](https://github.com/LongQT-sea/macos-iso-builder)**, by Tieu Long (LongQT-sea), publishes an open-source workflow for generating bootable macOS installation ISO and DMG images from Apple's software servers using GitHub Actions.

- [Original project, explanation and build tutorial](https://github.com/LongQT-sea/macos-iso-builder)
- [How to build with GitHub Actions](https://github.com/LongQT-sea/macos-iso-builder/blob/main/README.md)
- [List of community-generated releases](https://github.com/LongQT-sea/macos-iso-builder/releases)
- [Upstream GPL-3.0 license](https://github.com/LongQT-sea/macos-iso-builder/blob/main/LICENSE)

**Credit goes to LongQT-sea for the builder**, and to **Leo213github08** for hosting the exact artifact used in this experiment. This repository documents independent ZBook hardware testing; it is not a fork of either person's code.

For **related HP ZBook Fury hardware references**, see [Kilian's Fury 15 G7 project and the comparison with our Fury 17 G7](14-CREDITS-RELATED-PROJECTS.md). These different devices should not share a generic EFI.

## Direct link to our exact installer image

| Field | Verified value |
| --- | --- |
| **Actual download** | **[macOS_Sequoia_15.8.1.dmg.img — artifact 12594984907](https://github.com/Leo213github08/macos-iso-builder/actions/runs/40181607639/artifacts/12594984907)** |
| Repository | **[Leo213github08/macos-iso-builder](https://github.com/Leo213github08/macos-iso-builder)** |
| Full GitHub Actions run | **[Workflow run 40181607639](https://github.com/Leo213github08/macos-iso-builder/actions/runs/40181607639)** |
| Name | **macOS_Sequoia_15.8.1.dmg.img** |
| Size | **17,658,073,088 bytes** (about 16.45 GiB) |
| SHA256 | **1e288befa2e851ece653850cecaf06de8e808e1376b13cf20fc5768699ba146e** |
| Artifact created | 2026-10-25 at 10:22:37 UTC |
| Reported expiry | **2026-11-09 at 10:17:47 UTC** |
| Status when checked | Not expired on 2026-10-30 |

The **artifact page is the real download-page URL**, not a permanent CDN link. It may require signing in to GitHub. GitHub artifacts have retention periods; **the link can expire**. Never publish expiring, signed cloud-download URLs containing query parameters such as `sig`.

The GitHub artifact's **name, size, and SHA256** match the local installation record. The Windows browser history showed exactly this download URL. This is evidence of the image actually used, not merely the first image search result.

## Get a fresh full installer if that download expires

Use the [original creator's documented method](https://github.com/LongQT-sea/macos-iso-builder):

1. **Fork** the original builder repository on GitHub.
2. In your fork go to **Actions** and enable the workflows if asked.
3. Select **Build Full Installer ISO/DMG image**.
4. Select **macOS Sequoia**, version 15.8.1 if available, and **DMG** format, not ISO.
5. Run the workflow and, after successful completion, get the output from the **Artifacts** section.
6. Download, unpack as instructed by GitHub if needed, and confirm the exact name/version before using it.
7. Record the generated SHA256. **A newly built artifact is not guaranteed to have the same bytes or hash** as our exact October 2026 image.

GitHub-hosted runners are a shared resource. Use upstream build workflows responsibly and obey Apple's software license.

## Verify the downloaded file in Windows

~~~powershell
Get-FileHash -Algorithm SHA256 -LiteralPath "C:\Users\PC\Downloads\macOS_Sequoia_15.8.1.dmg.img"
~~~

This is **read-only**. You can also use the configurable [SHA verifier](../scripts/windows/verify-installer.ps1). Do not confuse the roughly 17GB installer file with the small OpenCore boot flash drive.

## How the image fit into our install

We prepared the **full offline installer** on a dedicated **256GB macOS SSD**, then booted the installer through a separate flash drive containing **OpenCore**. Windows remained on a physically separate **512GB NVMe drive**. After macOS installed, we debugged framebuffers, EDID, DPCD, the backlight, Wi-Fi, and audio separately.

**Do not reproduce historical partition writes on another PC.** Index numbers, installer layouts, and boot topology vary. There is deliberately no automatic Windows disk-imaging command here.

- [Exact hardware, disks and BIOS](01-HARDWARE.md)
- [Hardware and display incident report](03-GRAPHICS-BACKLIGHT-FIX.md)
- [Scripts, their origins, and safety](12-SCRIPTS.md)
- [Safe internal EFI verification](06-INTERNAL-EFI.md)

## Distribution and license

No macOS binaries, DMG images or full installers are mirrored or uploaded here. The builder is GPL-3.0 upstream. Check applicable Apple macOS license restrictions and official software sources before use.
