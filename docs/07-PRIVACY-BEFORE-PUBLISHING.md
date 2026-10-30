# Privacy and publication policy

## Do not upload a raw EFI

A live OpenCore config can carry identifying data under PlatformInfo, NVRAM and elsewhere. Even a valid bootable EFI may disclose:

- SystemSerialNumber
- MLB / Main Logic Board ID
- SystemUUID
- ROM or MAC address bytes
- Device identifiers and network information
- Usernames, home paths, private screenshots
- Firmware logs and tool debug output
- Tokens, passwords, private keys and account data

**This repository starts with documentation-only files** and a non-bootable example of graphics settings. The actual EFI/OC/config.plist, firmware tables and complete private boot backups are not included.

## Before publishing EFI in a future release

1. Confirm it is the **exact working and tested version**, not an old backup.
2. Copy to a *separate staging directory*, leaving the booting EFI intact.
3. Remove and replace unique platform identifiers, checking all plists and NVRAM data manually.
4. Inspect every file for private paths, accounts, networks, IDs, credentials, debug logs and metadata.
5. Run the accompanying heuristic checker using Python 3, but **do not treat a clean result as proof** of safety.
6. Check any binary kext redistribution license.
7. Test the **exact archive that will be distributed** and document its hash.
8. Never present a deliberately sanitized/blanked EFI as ready-to-boot with no additional setup.

Deleting a secret in a later Git commit does **not** guarantee its removal from public Git history.

## Disclosure note

The shared example intentionally omits the real 128-byte LGD063F EDID, platform serial data and any full config.plist. The working screen adjustments are recorded for research, not automatic reuse on another laptop.
