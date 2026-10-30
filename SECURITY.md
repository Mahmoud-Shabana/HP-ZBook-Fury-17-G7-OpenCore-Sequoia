# Security and privacy policy

## Scope

This project is a hardware research and documentation repository. It deliberately does not distribute a bootable EFI, macOS image, private SMBIOS numbers or a machine's firmware dump.

## Sensitive content that must never be posted

- OpenCore `SystemSerialNumber`, `MLB`, `SystemUUID`, `ROM`, serial-identity fields
- Complete `config.plist`, unless separately sanitized and reviewed
- Whole NVRAM or I/O Registry dumps
- Device/account identifiers, private emails, MAC addresses, IP addresses, screenshots of signed-in pages
- Secrets, passwords, tokens, private keys, license files, macOS installers and copyrighted binaries

## Accidentally disclosed data

If you notice exposed identifiers, **do not amplify them by quoting them in a public issue**. Contact the repository owner using GitHub's account-level contact method or a private communication channel. Redact your own issue or pull request attachment immediately where possible. A later commit deleting a secret may leave it in Git history; remediation may require history rewrite and revocation.

## Public release rule

Any future EFI release must be staged separately, checked for both textual and binary identifiers, manually reviewed and verified against the exact tested configuration. A green automated scan does not prove an archive is safe.

## Scripts

All example diagnostics are read-only. No provided workflow should format disks or change the Windows NVMe EFI. Use secure, current OpenCore and kext releases from verified maintainers. macOS licensing restrictions remain applicable.
