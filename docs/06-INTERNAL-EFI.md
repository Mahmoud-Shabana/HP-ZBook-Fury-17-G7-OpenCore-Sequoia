# Internal SATA EFI: safe verification and pending transfer

**Do not use generic disk-copy commands without verifying the target hardware and making a backup.**

## What was actually done

An earlier macOS-side OpenCore installer script targeted the confirmed **SSDAS256 256GB SATA SSD**. It mounted its roughly 209.7 MB EFI partition (at that time **disk0s1**) and copied the USB EFI. The tool checked the presence of OpenCore.efi, BOOTx64.efi, config.plist and kext directories. The final script command failed because it invoked the wrong macOS executable path **/usr/bin/sync**.

An attempted boot from the internal SSD reached the Apple logo but then showed the **old dark-backlight** behavior. Later, the **-igfxblr** change gave a positive result when booted from the **USB**. That newer configuration is not yet verified on the internal SSD.

## Safe final process

1. Boot the **known-good OCUSB** drive.
2. Prove the login and desktop backlight are illuminated and the brightness slider responds. Record the exact USB EFI version/hash.
3. Save the complete USB EFI and original internal SSD EFI to separate backups.
4. Use macOS diskutil to verify model, size, transport and partition GUID of the **256GB SSDAS256**. Confirm it is **not** the Windows 512GB NVMe drive.
5. Mount only the correct macOS SATA EFI after verifying it. Copy the final tested USB EFI.
6. Compare hashes of OpenCore config.plist, BOOT/BOOTx64.efi and OC/OpenCore.efi and check the kext inventory.
7. Use the standard macOS **sync** command (no hard-coded /usr/bin/sync). Unmount safely.
8. Boot with the USB **disconnected** and verify not just the logo but a visibly lit login screen, a desktop, working brightness slider, Wi-Fi and speakers.
9. If firmware cannot boot internal SATA, investigate boot entries before altering any partition.

## Critical boundary

The Windows NVMe contains a separate Windows installation and EFI. **Never format, resize, copy to, or delete its partitions.** A disk number such as disk0/disk1 can change. This project intentionally does not provide a blind one-line installer.
