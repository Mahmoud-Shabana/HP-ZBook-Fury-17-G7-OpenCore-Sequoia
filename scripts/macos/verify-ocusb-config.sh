#!/bin/bash
# Read-only USB EFI verification; does not modify NVRAM, EFI, disks or BIOS.
set -euo pipefail
ROOT="/Volumes/OCUSB/EFI"
PLIST="$ROOT/OC/config.plist"
GUID="7C436110-AB2A-4BBB-A880-FE41995C9F82"
for f in "$PLIST" "$ROOT/OC/OpenCore.efi" "$ROOT/BOOT/BOOTx64.efi"; do
 if [ ! -f "$f" ]; then echo "MISSING: $f"; exit 1; fi
done
plutil -lint "$PLIST"
ARGS=$(/usr/libexec/PlistBuddy -c "Print :NVRAM:Add:$GUID:boot-args" "$PLIST")
echo "USB boot flags: $ARGS"
case " $ARGS " in
 *" -igfxblr "*) echo 'Backlight register fix -igfxblr is present in the USB config.' ;;
 *) echo 'WARNING: -igfxblr is absent; this may not be the positively tested EFI.' ;;
esac
echo 'SHA256 of the key bootloader files:'
shasum -a 256 "$PLIST" "$ROOT/OC/OpenCore.efi" "$ROOT/BOOT/BOOTx64.efi"
echo 'Read-only check finished. Do not publish a full unredacted config.plist.'
