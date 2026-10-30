# READ-ONLY Windows PowerShell verifier for the exact image used in this project.
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$Path)
$ExpectedName='macOS_Sequoia_15.8.1.dmg.img'
$ExpectedSize=[int64]17658073088
$ExpectedHash='1E288BEFA2E851ECE653850CECAF06DE8E808E1376B13CF20FC5768699BA146E'
$item=Get-Item -LiteralPath $Path -ErrorAction Stop
if($item.PSIsContainer){throw 'Please pass a file, not a directory.'}
Write-Output ('File: '+$item.Name)
Write-Output ('Size in bytes: '+$item.Length)
$hash=(Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash.ToUpperInvariant()
Write-Output ('SHA256: '+$hash)
if($item.Name -eq $ExpectedName -and $item.Length -eq $ExpectedSize -and $hash -eq $ExpectedHash){
 Write-Output 'PASS: file matches the exact recorded October 2026 image.'
} else {
 Write-Warning 'Not an exact match for the original image. A new build may differ.'
 exit 1
}
