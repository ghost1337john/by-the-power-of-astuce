# GitHub Repository Backup (Windows)

This folder contains PowerShell scripts to backup all repositories from a GitHub owner into a local backup folder on Windows.

## Files

- backup-github-repos.ps1
- install-github-backup-task.ps1

## 1) Run a backup now

From PowerShell:

powershell -ExecutionPolicy Bypass -File .\scripts\GitHub\backup-github-repos.ps1 -Owner ghost1337john

Default backup path:

C:\Users\<your-user>\Documents\sauvegarde\github\<owner>

To include private repositories, set a token first:

setx GITHUB_TOKEN "<your_token>"

Then open a new PowerShell and run:

powershell -ExecutionPolicy Bypass -File .\scripts\GitHub\backup-github-repos.ps1 -Owner ghost1337john -IncludePrivate

## 2) Automate daily backup

Create/update a scheduled task (daily at 02:00):

powershell -ExecutionPolicy Bypass -File .\scripts\GitHub\install-github-backup-task.ps1 -Owner ghost1337john -ScheduleTime 02:00

Custom options example:

powershell -ExecutionPolicy Bypass -File .\scripts\GitHub\install-github-backup-task.ps1 -Owner ghost1337john -ScheduleTime 01:30 -TaskName GitHubBackupNightly -BackupRoot "D:\sauvegarde\github"

Run task immediately:

Start-ScheduledTask -TaskName "GitHubRepoBackup"

## Notes

- Repositories are backed up in mirror mode (*.git folders).
- Existing mirrors are updated with remote update --prune.
- A transcript log is generated in:
  - C:\Users\<your-user>\Documents\sauvegarde\github\<owner>\logs
- For private repositories, use GITHUB_TOKEN with repo scope.
