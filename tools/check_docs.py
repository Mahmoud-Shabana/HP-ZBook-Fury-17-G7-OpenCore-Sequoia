#!/usr/bin/env python3
"""Validate internal documentation links and primary repository files.

Standard-library only. Safe: no network access, system changes or user data reads
outside the supplied repository directory.
"""
from pathlib import Path, PurePosixPath
from urllib.parse import unquote
import re
import sys

SKIP_DIRS = {".git", "__pycache__", ".venv", "node_modules"}
MARKDOWN_LINK = re.compile(r"(?<!!)\[[^\]]+\]\(([^)\n]+)\)|!\[[^\]]*\]\(([^)\n]+)\)")
HTML_LINK = re.compile(r'(?:src|href)\s*=\s*["\x27]([^"\x27]+)["\x27]')
REQUIRED = [
    "README.md", "README.ar.md", "CHANGELOG.md",
    "CONTRIBUTING.md", "SECURITY.md", "assets/hero.svg",
    "docs/01-HARDWARE.md", "docs/02-WHAT-WORKS.md",
    "docs/03-GRAPHICS-BACKLIGHT-FIX.md", "docs/04-POWER-THERMALS.md",
    "docs/05-NEXT-STEPS.md", "docs/06-INTERNAL-EFI.md",
    "docs/07-PRIVACY-BEFORE-PUBLISHING.md", "docs/08-DIAGNOSTICS.md",
    "docs/09-FAQ.md",
]
EXTERNAL_PREFIXES = ("https://", "http://", "mailto:", "data:", "#")
ISSUE_PREFIXES = ("../../issues/", "../../pulls/")


def resolve_target(root: Path, source: Path, url: str) -> Path | None:
    url = unquote(url.split("#", 1)[0].split("?", 1)[0].strip("<> "))
    if not url or url.startswith(EXTERNAL_PREFIXES + ISSUE_PREFIXES):
        return None
    target = source.parent / PurePosixPath(url)
    try:
        clean = target.resolve(strict=False)
        clean.relative_to(root)
        return clean
    except ValueError:
        raise ValueError(f"relative URL escapes repository: {url}")


def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
    failures = [f"Missing {p}" for p in REQUIRED if not (root / p).is_file()]
    total_links = 0
    total_files = 0
    for source in sorted(root.rglob("*.md")):
        if any(part in SKIP_DIRS for part in source.relative_to(root).parts):
            continue
        total_files += 1
        text = source.read_text(encoding="utf-8")
        urls = [a or b for a, b in MARKDOWN_LINK.findall(text)]
        urls += HTML_LINK.findall(text)
        for url in urls:
            if not url or url.startswith(EXTERNAL_PREFIXES + ISSUE_PREFIXES):
                continue
            total_links += 1
            try:
                target = resolve_target(root, source, url)
                if target is not None and not target.exists():
                    failures.append(f"{source.relative_to(root)}: broken link {url}")
            except ValueError as exc:
                failures.append(f"{source.relative_to(root)}: {exc}")
    for problem in failures:
        print("FAIL:", problem)
    print(f"Checked {total_files} Markdown files and {total_links} local links.")
    print("Documentation check:", "FAILED" if failures else "PASSED")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
