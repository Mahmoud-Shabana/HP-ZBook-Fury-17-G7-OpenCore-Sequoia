#!/usr/bin/env python3
"""Heuristic privacy checker for a documentation-only public repo.

This is NOT a guarantee that every private identifier has been removed.
Run on a SEPARATE staging folder, never edit a known-good boot EFI in place.
"""
import pathlib
import re
import sys

PATTERNS = {
    "email": re.compile(r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b"),
    "GitHub token": re.compile(r"(?:gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,})"),
    "private key": re.compile(r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----"),
    "raw SMBIOS XML": re.compile(r"<key>\s*(SystemSerialNumber|MLB|SystemUUID|ROM)\s*</key>", re.I),
}
DISALLOWED_EXT = {".efi", ".aml", ".rom", ".dmg", ".iso", ".plist", ".key", ".p12", ".p8", ".pem"}
SKIP = {".git", "__pycache__", ".venv"}

def main() -> int:
    root = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
    if not root.is_dir():
        print(f"Not a directory: {root}", file=sys.stderr)
        return 2
    found = []
    scanned = 0
    for path in root.rglob("*"):
        if not path.is_file() or any(part in SKIP for part in path.relative_to(root).parts):
            continue
        scanned += 1
        relative = path.relative_to(root)
        if path.suffix.lower() in DISALLOWED_EXT or "config.plist" in path.name.lower() or ".kext" in str(relative).lower():
            found.append(f"{relative}: raw EFI or firmware-like file")
        if path.stat().st_size > 4_000_000:
            found.append(f"{relative}: unexpectedly large file")
            continue
        if path.suffix.lower() in {".md", ".json", ".yml", ".yaml", ".py", ".sh", ".txt", ".xml", ".log"}:
            content = path.read_text(encoding="utf-8", errors="replace")
            for name, expression in PATTERNS.items():
                if expression.search(content):
                    found.append(f"{relative}: {name}")
    print(f"Scanned {scanned} files")
    for issue in found:
        print("REVIEW:", issue)
    print("Clean heuristic scan is not a privacy certification. Human review is mandatory.")
    return 1 if found else 0

if __name__ == "__main__":
    raise SystemExit(main())
