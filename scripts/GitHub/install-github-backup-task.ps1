param(
    [Parameter(Mandatory = $false)]
    [string]$Owner = "ghost1337john",

    [Parameter(Mandatory = $false)]
    [string]$BackupRoot = "$env:USERPROFILE\Documents\sauvegarde\github",

    [Parameter(Mandatory = $false)]
    [string]$ScheduleTime = "02:00",

    [Parameter(Mandatory = $false)]
    [string]$TaskName = "GitHubRepoBackup",

    [Parameter(Mandatory = $false)]
    [switch]$IncludePrivate,

    [Parameter(Mandatory = $false)]
    [ValidateSet("https", "ssh")]
    [string]$CloneProtocol = "https"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$backupScriptPath = Join-Path $scriptDir "backup-github-repos.ps1"

if (-not (Test-Path $backupScriptPath)) {
    throw "Backup script not found: $backupScriptPath"
}

$timeParts = $ScheduleTime.Split(':')
if ($timeParts.Count -ne 2) {
    throw "ScheduleTime must be HH:mm format (example: 02:00)."
}

$hour = [int]$timeParts[0]
$minute = [int]$timeParts[1]
if ($hour -lt 0 -or $hour -gt 23 -or $minute -lt 0 -or $minute -gt 59) {
    throw "ScheduleTime is invalid. Use HH:mm, 24-hour format."
}

$argumentList = @(
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", $backupScriptPath,
    "-Owner", $Owner,
    "-BackupRoot", $BackupRoot,
    "-CloneProtocol", $CloneProtocol
)

if ($IncludePrivate) {
    $argumentList += "-IncludePrivate"
}

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument ($argumentList -join ' ')
$triggerTime = Get-Date -Hour $hour -Minute $minute -Second 0
$trigger = New-ScheduledTaskTrigger -Daily -At $triggerTime
$principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive -RunLevel Limited
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -StartWhenAvailable -MultipleInstances IgnoreNew

try {
    Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null
}
catch {
    $taskRun = "powershell.exe " + ($argumentList -join ' ')
    $schtasksArgs = @(
        "/Create",
        "/TN", $TaskName,
        "/TR", $taskRun,
        "/SC", "DAILY",
        "/ST", $ScheduleTime,
        "/F"
    )

    & schtasks.exe @schtasksArgs | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Unable to create scheduled task using both Register-ScheduledTask and schtasks.exe. Try running PowerShell as Administrator once."
    }
}

Write-Host "Scheduled task created/updated successfully."
Write-Host "Task name: $TaskName"
Write-Host "Schedule : Daily at $ScheduleTime"
Write-Host "Owner    : $Owner"
Write-Host "Backup   : $BackupRoot"
Write-Host ""
Write-Host "To run now:"
Write-Host "Start-ScheduledTask -TaskName '$TaskName'"
Write-Host ""
Write-Host "If you enabled private repositories, set GITHUB_TOKEN at user level:"
Write-Host 'setx GITHUB_TOKEN "<your_token>"'
