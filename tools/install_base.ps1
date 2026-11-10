# Install the base software for an AI project-management (QLDA) machine.
#   Check only (changes nothing):   powershell -ExecutionPolicy Bypass -File tools\install_base.ps1 -Check
#   Install (run as Administrator): powershell -ExecutionPolicy Bypass -File tools\install_base.ps1
#   Skip optional apps:             add -NoOptional
# What it does:
#   1. winget-installs whatever is missing from the list below (already installed = left alone).
#   2. Power: no sleep / hibernate while on AC power (so remote support can reach the PC).
#   3. AnyDesk unattended access: OPTIONAL, asks the owner of the PC (typed, hidden).
#      The password is never stored in a file or printed.
# Next step (normal PowerShell, NOT admin): tools\install_ai.ps1
# ASCII only on purpose (Windows PowerShell 5.1 reads BOM-less files as ANSI).
param([switch]$Check, [switch]$NoOptional)
$ErrorActionPreference = 'Continue'

# Name, winget id, regex on the installed program's DisplayName, optional?
$apps = @(
    @{ Name = 'Git';                      Id = 'Git.Git';            Match = '^Git( version|$)'; Opt = $false },
    @{ Name = 'Python 3.12';              Id = 'Python.Python.3.12'; Match = '^Python 3\.12\.';  Opt = $false },
    @{ Name = 'Node.js LTS';              Id = 'OpenJS.NodeJS.LTS';  Match = '^Node\.js';        Opt = $false },
    @{ Name = 'uv (for Javis tools)';     Id = 'astral-sh.uv';       Match = '^uv\b';            Opt = $false },
    @{ Name = 'Google Chrome';            Id = 'Google.Chrome';      Match = '^Google Chrome$';  Opt = $false },
    @{ Name = 'Google Drive for desktop'; Id = 'Google.GoogleDrive'; Match = '^Google Drive$';   Opt = $false },
    @{ Name = 'Claude Desktop';           Id = 'Anthropic.Claude';   Match = '^Claude$';         Opt = $false },
    @{ Name = 'AnyDesk';                  Id = 'AnyDesk.AnyDesk';    Match = '^AnyDesk$';        Opt = $false },
    @{ Name = 'Snipaste (screenshots)';   Id = 'liule.Snipaste';     Match = '^Snipaste';        Opt = $true }
)

function Get-Installed {
    $keys = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
            'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
            'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
    $names = @(Get-ItemProperty $keys -ErrorAction SilentlyContinue | Where-Object DisplayName | ForEach-Object { $_.DisplayName })
    # some apps (uv, Claude Desktop) do not always register in Uninstall: add file-based hints
    if (Get-Command uv -ErrorAction SilentlyContinue) { $names += 'uv' }
    if ((Test-Path "$env:LOCALAPPDATA\AnthropicClaude") -or (Get-AppxPackage -Name '*Claude*' -ErrorAction SilentlyContinue)) { $names += 'Claude' }
    $names
}
function Get-AcIndex($sub, $setting) {
    $line = powercfg /q SCHEME_CURRENT $sub $setting 2>$null | Select-String 'Current AC Power Setting Index'
    if ($line) { [Convert]::ToInt32(($line.ToString() -split ':')[-1].Trim(), 16) } else { $null }
}
function Find-AnyDesk {
    foreach ($p in "${env:ProgramFiles(x86)}\AnyDesk\AnyDesk.exe", "$env:ProgramFiles\AnyDesk\AnyDesk.exe") { if (Test-Path $p) { return $p } }
    $null
}

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $Check -and -not $isAdmin) {
    'Run this from PowerShell opened with "Run as administrator" (or use -Check to only look).'
    exit 2
}
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    'winget not found. Install "App Installer" from the Microsoft Store, then run again.'
    exit 2
}

$rows = New-Object System.Collections.ArrayList
function Add-Row($item, $status, $note) { [void]$rows.Add([pscustomobject]@{ Item = $item; Status = $status; Note = $note }) }

# --- 1. Software
$installed = Get-Installed
foreach ($a in $apps) {
    if ($NoOptional -and $a.Opt) { Add-Row $a.Name 'SKIP' 'optional'; continue }
    $hit = $installed | Where-Object { $_ -match $a.Match } | Select-Object -First 1
    if ($hit) { Add-Row $a.Name 'OK' $hit; continue }
    if ($Check) { Add-Row $a.Name 'MISSING' "winget install --id $($a.Id) -e"; continue }
    "Installing $($a.Name) ..."
    winget install --id $a.Id -e --silent --accept-package-agreements --accept-source-agreements --disable-interactivity | Out-Host
    $code = $LASTEXITCODE
    $ok = (Get-Installed | Where-Object { $_ -match $a.Match } | Select-Object -First 1)
    Add-Row $a.Name $(if ($ok -or $code -eq 0) { 'INSTALLED' } else { 'FAILED' }) "winget exit $code"
}

# --- 2. Power (AC only; battery behaviour is left as it is)
if (-not $Check) {
    powercfg /change standby-timeout-ac 0 | Out-Null
    powercfg /change hibernate-timeout-ac 0 | Out-Null
}
$sleep = Get-AcIndex 'SUB_SLEEP' 'STANDBYIDLE'
$hib   = Get-AcIndex 'SUB_SLEEP' 'HIBERNATEIDLE'
Add-Row 'Sleep on AC = never'     $(if ($sleep -eq 0) { 'OK' } else { 'MISSING' }) "$sleep s"
Add-Row 'Hibernate on AC = never' $(if ($hib -eq 0)   { 'OK' } else { 'MISSING' }) "$hib s"

# --- 3. AnyDesk service + (optional) unattended access
$ad = Find-AnyDesk
$svc = Get-CimInstance Win32_Service -Filter "Name='AnyDesk'" -ErrorAction SilentlyContinue
Add-Row 'AnyDesk installed as service' $(if ($svc) { 'OK' } else { 'MISSING' }) $(if ($svc) { "$($svc.State), $($svc.StartMode)" } else { 'portable AnyDesk cannot show admin (UAC) prompts' })
$conf = Join-Path $env:ProgramData 'AnyDesk\system.conf'
$pwPattern = '^ad\.security\.permission_profiles\._unattended_access\.pwd='
$hasPw = (Test-Path $conf) -and [bool](Select-String -Path $conf -Pattern $pwPattern -Quiet)
if (-not $Check -and $ad) {
    $ans = Read-Host 'Allow remote support without someone clicking Accept (AnyDesk unattended password)? (y/N)'
    if ($ans -match '^[yY]') {
        $s1 = Read-Host 'New AnyDesk password (hidden)' -AsSecureString
        $s2 = Read-Host 'Type it again (hidden)' -AsSecureString
        $b1 = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($s1); $b2 = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($s2)
        try {
            $p1 = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($b1); $p2 = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($b2)
            if ($p1 -ne $p2) { 'Passwords do not match - skipped.' }
            elseif ($p1.Length -lt 10) { 'Use at least 10 characters - skipped.' }
            else { $p1 | & $ad --set-password _unattended_access; 'AnyDesk password set.' }
        } finally {
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($b1); [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($b2)
            $p1 = $null; $p2 = $null
        }
        Start-Sleep -Seconds 2
        $hasPw = [bool](Select-String -Path $conf -Pattern $pwPattern -Quiet)
    }
}
Add-Row 'AnyDesk unattended password' $(if ($hasPw) { 'OK' } else { 'INFO' }) $(if ($hasPw) { 'set (value never shown)' } else { 'not set - someone must click Accept' })
if ($ad) {
    $id = (Select-String -Path $conf -Pattern '^ad\.anynet\.id=(\d+)' -ErrorAction SilentlyContinue | Select-Object -First 1)
    Add-Row 'AnyDesk ID of this machine' 'INFO' $(if ($id) { $id.Matches[0].Groups[1].Value } else { 'open AnyDesk once to get an ID' })
}

$rows | Format-Table -AutoSize -Wrap
'Next: close this window, open a NORMAL PowerShell and run tools\install_ai.ps1 (Claude Code, Antigravity, Javis).'
$bad = @($rows | Where-Object { $_.Status -in 'MISSING', 'FAILED' })
if ($bad.Count) { "RESULT: $($bad.Count) item(s) need attention."; exit 1 } else { 'RESULT: base software ready.'; exit 0 }
