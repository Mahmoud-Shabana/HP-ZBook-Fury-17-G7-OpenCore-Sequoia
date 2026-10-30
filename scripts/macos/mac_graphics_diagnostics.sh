# Original script recovered from the tested OCUSB.
# WARNING: generated reports can contain private paths/identifiers; do not publish raw output.
#!/bin/bash
# macOS local diagnostics for HP ZBook Fury 17 G7, no system modifications, no sudo, no network.
OUT="/Volumes/OCUSB/IGPU_DIAG.txt"
if [ ! -d "/Volumes/OCUSB" ] || [ ! -w "/Volumes/OCUSB" ]; then
 echo "OCUSB is not mounted or not writable. Open Finder and mount OCUSB first."
 exit 2
fi
{
  echo "=== ZBOOK FURY 17 G7 / macOS IGPU DIAGNOSTICS ==="
  date
  sw_vers
  echo "=== Graphics report ==="
  system_profiler SPDisplaysDataType
  echo "=== AppleIntelFramebuffer service (if present) ==="
  ioreg -r -l -c AppleIntelFramebuffer 2>&1 | head -n 180
  echo "=== IODisplayConnect service ==="
  ioreg -r -l -c IODisplayConnect 2>&1 | head -n 180
  echo "=== Intel driver extensions ==="
  kmutil showloaded 2>&1 | grep -Ei 'Intel|WhateverGreen|Lilu|AGDC|Graphics|Framebuffer' | head -n 100
  echo "=== Recent crash reports file names ==="
  /bin/ls -lt /Library/Logs/DiagnosticReports/ 2>&1 | head -n 45
  echo "=== Kernel panic/restart reports (limited excerpt) ==="
  for f in /Library/Logs/DiagnosticReports/*panic* /Library/Logs/DiagnosticReports/*Kernel*; do
    if [ -f "$f" ]; then
      echo "=== $(basename "$f") ==="
      /usr/bin/head -n 80 "$f"
    fi
  done
  echo "=== Recent graphics-related unified logs (may take a few minutes) ==="
  log show --last 18h --style compact --predicate 'eventMessage CONTAINS[c] "IGFB" OR eventMessage CONTAINS[c] "AppleIntel" OR eventMessage CONTAINS[c] "IOConsole" OR eventMessage CONTAINS[c] "DPCD" OR eventMessage CONTAINS[c] "framebuffer"' 2>&1 | tail -n 320
  echo "=== END ==="
} > "$OUT" 2>&1
echo "Diagnostics saved to $OUT"
