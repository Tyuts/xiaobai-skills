param(
  [switch]$InstallRecommended,
  [switch]$CurateExisting,
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

$HomeDir = $env:USERPROFILE
$CodexSkills = Join-Path $HomeDir '.codex\skills'
$BackupRoot = Join-Path $HomeDir ('.codex\skills-backup\xiaobai-' + (Get-Date -Format 'yyyy-MM-dd'))
$WorkspaceInventory = Join-Path (Get-Location) 'SKILLS-GLOBAL-INVENTORY.md'

function Ensure-Dir([string]$Path) {
  New-Item -ItemType Directory -Force -Path $Path | Out-Null
}

function Download-GitHubRepoZip([string]$Repo, [string]$Ref, [string]$Destination) {
  if ((Test-Path -LiteralPath $Destination) -and -not $Force) {
    Write-Host "Exists, skipping: $Destination"
    return
  }
  if ((Test-Path -LiteralPath $Destination) -and $Force) {
    Remove-Item -LiteralPath $Destination -Recurse -Force
  }

  $staging = Join-Path ([System.IO.Path]::GetTempPath()) ('xiaobai-skills-' + [guid]::NewGuid().ToString('N'))
  $zip = Join-Path $staging 'repo.zip'
  Ensure-Dir $staging
  try {
    $url = "https://codeload.github.com/$Repo/zip/refs/heads/$Ref"
    Invoke-WebRequest -Uri $url -OutFile $zip
    Expand-Archive -LiteralPath $zip -DestinationPath $staging
    $repoName = ($Repo -split '/')[1]
    $extracted = Join-Path $staging "$repoName-$Ref"
    if (-not (Test-Path -LiteralPath $extracted)) {
      throw "Could not find extracted folder: $extracted"
    }
    Move-Item -LiteralPath $extracted -Destination $Destination
    Write-Host "Installed: $Repo -> $Destination"
  }
  finally {
    if (Test-Path -LiteralPath $staging) {
      Remove-Item -LiteralPath $staging -Recurse -Force
    }
  }
}

function Download-SingleSkill([string]$Url, [string]$Destination) {
  if ((Test-Path -LiteralPath $Destination) -and -not $Force) {
    Write-Host "Exists, skipping: $Destination"
    return
  }
  if ((Test-Path -LiteralPath $Destination) -and $Force) {
    Remove-Item -LiteralPath $Destination -Recurse -Force
  }
  Ensure-Dir $Destination
  Invoke-WebRequest -Uri $Url -OutFile (Join-Path $Destination 'SKILL.md')
  Write-Host "Installed: $Destination"
}

function Move-ToBackup([string]$Source, [string]$RelativeDestination) {
  if (-not (Test-Path -LiteralPath $Source)) {
    return
  }
  $dest = Join-Path $BackupRoot $RelativeDestination
  Ensure-Dir (Split-Path -Parent $dest)
  if (Test-Path -LiteralPath $dest) {
    Write-Host "Backup exists, skipping move: $dest"
    return
  }
  Move-Item -LiteralPath $Source -Destination $dest
  Write-Host "Backed up: $Source -> $dest"
}

function Get-SkillNames([string]$Root) {
  if (-not (Test-Path -LiteralPath $Root)) {
    return @()
  }
  Get-ChildItem -LiteralPath $Root -Recurse -Filter 'SKILL.md' -File | ForEach-Object {
    $head = Get-Content -Path $_.FullName -TotalCount 8
    $match = $head | Select-String -Pattern '^name:\s*(.+)$'
    if ($match) { $match.Matches.Groups[1].Value.Trim('"') }
  } | Where-Object { $_ } | Sort-Object
}

Ensure-Dir $CodexSkills

if (-not $InstallRecommended -and -not $CurateExisting) {
  $InstallRecommended = $true
  $CurateExisting = $true
}

if ($InstallRecommended) {
  Download-SingleSkill `
    -Url 'https://raw.githubusercontent.com/vercel-labs/skills/main/skills/find-skills/SKILL.md' `
    -Destination (Join-Path $CodexSkills 'vercel-labs\find-skills')

  Download-SingleSkill `
    -Url 'https://raw.githubusercontent.com/mineru98/llm-proxy-skills/main/skills/frontend-master/SKILL.md' `
    -Destination (Join-Path $CodexSkills 'frontend-master')

  Download-GitHubRepoZip -Repo 'JimLiu/baoyu-skills' -Ref 'main' -Destination (Join-Path $CodexSkills 'baoyu-skills')
  Download-GitHubRepoZip -Repo 'mattpocock/skills' -Ref 'main' -Destination (Join-Path $CodexSkills 'mattpocock-skills')
}

if ($CurateExisting) {
  Ensure-Dir $BackupRoot
  Ensure-Dir (Join-Path $BackupRoot 'packages')
  Ensure-Dir (Join-Path $BackupRoot 'disabled-global-entries')
  Ensure-Dir (Join-Path $BackupRoot 'disabled-subskills')

  Move-ToBackup (Join-Path $CodexSkills 'gstack') 'disabled-global-entries\codex-skills-gstack'
  Move-ToBackup (Join-Path $HomeDir '.agents\skills\gstack') 'disabled-global-entries\agents-skills-gstack'
  Move-ToBackup (Join-Path $HomeDir '.claude\skills\gstack') 'packages\gstack'

  Move-ToBackup (Join-Path $CodexSkills 'superpowers') 'disabled-global-entries\codex-skills-superpowers'
  Move-ToBackup (Join-Path $HomeDir '.agents\skills\superpowers') 'disabled-global-entries\agents-skills-superpowers'
  Move-ToBackup (Join-Path $HomeDir '.codex\superpowers') 'packages\superpowers'

  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\deprecated') 'disabled-subskills\mattpocock-skills\deprecated'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\personal') 'disabled-subskills\mattpocock-skills\personal'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\misc\git-guardrails-claude-code') 'disabled-subskills\mattpocock-skills\misc\git-guardrails-claude-code'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\misc\migrate-to-shoehorn') 'disabled-subskills\mattpocock-skills\misc\migrate-to-shoehorn'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\misc\scaffold-exercises') 'disabled-subskills\mattpocock-skills\misc\scaffold-exercises'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\misc\setup-pre-commit') 'disabled-subskills\mattpocock-skills\misc\setup-pre-commit'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\productivity\caveman') 'disabled-subskills\mattpocock-skills\productivity\caveman'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\productivity\write-a-skill') 'disabled-subskills\mattpocock-skills\productivity\write-a-skill'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\in-progress\writing-beats') 'disabled-subskills\mattpocock-skills\in-progress\writing-beats'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\in-progress\writing-fragments') 'disabled-subskills\mattpocock-skills\in-progress\writing-fragments'
  Move-ToBackup (Join-Path $CodexSkills 'mattpocock-skills\skills\in-progress\writing-shape') 'disabled-subskills\mattpocock-skills\in-progress\writing-shape'

  Move-ToBackup (Join-Path $CodexSkills 'baoyu-skills\.claude\skills\release-skills') 'disabled-subskills\baoyu-skills\.claude\skills\release-skills'
  Move-ToBackup (Join-Path $CodexSkills 'baoyu-skills\skills\baoyu-danger-gemini-web') 'disabled-subskills\baoyu-skills\skills\baoyu-danger-gemini-web'
  Move-ToBackup (Join-Path $CodexSkills 'baoyu-skills\skills\baoyu-danger-x-to-markdown') 'disabled-subskills\baoyu-skills\skills\baoyu-danger-x-to-markdown'
  Move-ToBackup (Join-Path $CodexSkills 'baoyu-skills\skills\baoyu-image-gen') 'disabled-subskills\baoyu-skills\skills\baoyu-image-gen'
}

$skills = Get-SkillNames $CodexSkills
$inventory = @"
# Xiaobai Skills Inventory

Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

Active skill count: $($skills.Count)

## Active skills

$($skills | ForEach-Object { "- $_" } | Out-String)

## Backup folder

$BackupRoot

## Notes

- Keep one broad engineering workflow globally by default.
- Restore backup candidates one at a time when active skills underperform.
- Restart Codex after installing, moving, or restoring skills.
"@

Set-Content -LiteralPath $WorkspaceInventory -Value $inventory -Encoding UTF8
if (Test-Path -LiteralPath $BackupRoot) {
  Set-Content -LiteralPath (Join-Path $BackupRoot 'README.md') -Value $inventory -Encoding UTF8
}

Write-Host "Inventory written: $WorkspaceInventory"
Write-Host "Restart Codex to pick up skill changes."

