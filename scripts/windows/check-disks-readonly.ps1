# READ ONLY: inventory physical drives without formatting, mounting or copying data.
Get-Disk | Sort-Object Number | Select-Object Number,FriendlyName,BusType,PartitionStyle,Size | Format-Table -AutoSize
Get-Volume | Where-Object {$null -ne $_.DriveLetter} | Select-Object DriveLetter,FileSystemLabel,FileSystem,Size | Format-Table -AutoSize
Write-Output 'Known test device: macOS SSDAS256 SATA 256GB, Windows MTFDHBA512TDV NVMe 512GB.'
Write-Output 'Disk numbers can change; do NOT copy any bootloader to Windows NVMe.'
