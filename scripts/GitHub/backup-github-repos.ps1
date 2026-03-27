param(
    [Parameter(Mandatory = $false)]
    [string]$Owner = "ghost1337john",

    [Parameter(Mandatory = $false)]
    [string]$BackupRoot = "$env:USERPROFILE\Documents\sauvegarde\github",

    [Parameter(Mandatory = $false)]
    [switch]$IncludePrivate,

    [Parameter(Mandatory = $false)]
    [string]$Token,

    [Parameter(Mandatory = $false)]
    [ValidateSet("https", "ssh")]
    [string]$CloneProtocol = "https",

    [Parameter(Mandatory = $false)]
    [switch]$IncludeArchived
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
# Prevent native stderr output (git progress) from being promoted to terminating errors.
if ($null -ne (Get-Variable -Name PSNativeCommandUseErrorActionPreference -ErrorAction SilentlyContinue)) {
    $PSNativeCommandUseErrorActionPreference = $false
}

function Write-Log {
    param(
        [string]$Level,
        [string]$Message
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] [$Level] $Message"
}

function Invoke-Git {
    param(
        [string[]]$Arguments,
        [string]$WorkingDirectory = $null
    )

    if ($WorkingDirectory) {
        & git -C $WorkingDirectory @Arguments
    }
    else {
        & git @Arguments
    }

    $exitCode = $LASTEXITCODE
    if ($null -ne $exitCode -and $exitCode -ne 0) {
        throw "git command failed (exit $exitCode): git $($Arguments -join ' ')"
    }
}

function Get-GithubToken {
    param(
        [string]$TokenParam
    )

    if ($TokenParam) {
        return $TokenParam
    }

    if ($env:GITHUB_TOKEN) {
        return $env:GITHUB_TOKEN
    }

    return $null
}

function Get-Repositories {
    param(
        [string]$Owner,
        [switch]$IncludePrivate,
        [string]$Token
    )

    $headers = @{ "User-Agent" = "by-the-power-of-astuce-backup-script" }
    if ($Token) {
        $headers["Authorization"] = "Bearer $Token"
    }

    $repos = @()
    $page = 1
    $perPage = 100

    while ($true) {
        if ($IncludePrivate) {
            $url = "https://api.github.com/user/repos?visibility=all&affiliation=owner&sort=full_name&per_page=$perPage&page=$page"
        }
        else {
            $url = "https://api.github.com/users/$Owner/repos?type=owner&sort=full_name&per_page=$perPage&page=$page"
        }

        $batch = Invoke-RestMethod -Uri $url -Headers $headers -Method Get

        if (-not $batch -or $batch.Count -eq 0) {
            break
        }

        if ($IncludePrivate) {
            $batch = $batch | Where-Object { $_.owner.login -eq $Owner }
        }

        $repos += $batch
        $page++
    }

    return $repos
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "git is not installed or not available in PATH."
}

$resolvedToken = Get-GithubToken -TokenParam $Token

if ($IncludePrivate -and -not $resolvedToken) {
    throw "IncludePrivate requires a token. Set -Token or GITHUB_TOKEN env variable."
}

$ownerDir = Join-Path $BackupRoot $Owner
New-Item -ItemType Directory -Path $ownerDir -Force | Out-Null

$logDir = Join-Path $ownerDir "logs"
New-Item -ItemType Directory -Path $logDir -Force | Out-Null
$logFile = Join-Path $logDir ("backup-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".log")

Start-Transcript -Path $logFile | Out-Null

try {
    Write-Log -Level "INFO" -Message "Starting backup for owner: $Owner"
    Write-Log -Level "INFO" -Message "Backup root: $BackupRoot"
    Write-Log -Level "INFO" -Message "Include private repositories: $($IncludePrivate.IsPresent)"

    $repos = Get-Repositories -Owner $Owner -IncludePrivate:$IncludePrivate -Token $resolvedToken

    if (-not $IncludeArchived) {
        $repos = $repos | Where-Object { -not $_.archived }
    }

    if (-not $repos -or $repos.Count -eq 0) {
        Write-Log -Level "WARN" -Message "No repositories found for owner '$Owner'."
        return
    }

    Write-Log -Level "INFO" -Message "Repositories to process: $($repos.Count)"

    $cloned = 0
    $updated = 0
    $failed = 0

    foreach ($repo in $repos) {
        $repoName = $repo.name
        $remoteUrl = if ($CloneProtocol -eq "ssh") { $repo.ssh_url } else { $repo.clone_url }
        $repoPath = Join-Path $ownerDir ($repoName + ".git")

        try {
            if (Test-Path $repoPath) {
                Write-Log -Level "INFO" -Message "Updating mirror: $repoName"
                Invoke-Git -Arguments @("remote", "update", "--prune") -WorkingDirectory $repoPath | Out-Null
                $updated++
            }
            else {
                Write-Log -Level "INFO" -Message "Cloning mirror: $repoName"
                Invoke-Git -Arguments @("clone", "--mirror", $remoteUrl, $repoPath) | Out-Null
                $cloned++
            }
        }
        catch {
            $failed++
            Write-Log -Level "ERROR" -Message "Failed on repo '$repoName': $($_.Exception.Message)"
        }
    }

    Write-Log -Level "INFO" -Message "Backup finished. Cloned: $cloned | Updated: $updated | Failed: $failed"

    if ($failed -gt 0) {
        exit 1
    }
}
finally {
    Stop-Transcript | Out-Null
}
