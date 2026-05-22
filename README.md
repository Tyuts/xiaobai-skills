# Xiaobai Skills

> A beginner-friendly starter pack and curator for Codex / agent skills.

[![Release](https://img.shields.io/github/v/release/Tyuts/xiaobai-skills?include_prereleases)](https://github.com/Tyuts/xiaobai-skills/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Codex Skills](https://img.shields.io/badge/Codex-Skills-2563EB)](SKILL.md)
[![Sponsor](https://img.shields.io/badge/Sponsor-GitHub%20Sponsors-ea4aaa)](https://github.com/sponsors/Tyuts)

Xiaobai Skills helps new Codex users get a useful skills setup quickly:

- Install a practical starter set across common needs.
- Audit already-installed skills.
- Pick one global default when skills overlap.
- Move unselected skills into a backup folder instead of deleting them.
- Restore backup skills later when the active choice is not good enough.

In short: **Xiaobai Skills is a one-click starter pack and global skills
organizer for Codex beginners.**

## Why This Exists

Agent skills are powerful, but beginners hit two problems fast:

1. **Discovery takes time.** There are many useful skills across GitHub, but new
   users do not know which ones are worth installing first.
2. **Too many global skills can conflict.** Several skills may trigger on the
   same request, especially for frontend work, TDD, debugging, review, planning,
   and image generation.

Xiaobai Skills gives users a sane default and a recovery path.

## What It Covers

The recommended starter set covers:

- Skill discovery and installation
- Skill creation and editing
- Frontend UI / visual implementation
- Image generation and media workflows
- URL to Markdown, translation, publishing, slides, and content workflows
- TDD, diagnosis, triage, PRDs, issues, review, and handoff
- Skill-library auditing, deduplication, backup, and restore

## Recommended Default Stack

Xiaobai Skills recommends keeping these globally active:

- OpenAI system skills:
  - `imagegen`
  - `openai-docs`
  - `plugin-creator`
  - `skill-creator`
  - `skill-installer`
- `find-skills`
- `frontend-master`
- `baoyu-skills` curated subset
- `mattpocock-skills` curated subset
- `xiaobai-skills`

Default backup candidates:

- `gstack`
- `superpowers`
- deprecated, personal, or niche Matt Pocock subskills
- dangerous or duplicate Baoyu subskills

The rule is simple: **one strong default per need, backups preserved for later.**

## Install

### Option 1: Copy This Skill Into Codex

Copy this repository folder to:

```powershell
$env:USERPROFILE\.codex\skills\xiaobai-skills
```

Restart Codex.

### Option 2: Use The Installer

From the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-xiaobai-skills.ps1
```

Install recommended starter skills:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-xiaobai-skills.ps1 -InstallRecommended
```

Curate existing installed skills:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-xiaobai-skills.ps1 -CurateExisting
```

Options:

```text
-InstallRecommended   Install the recommended starter stack.
-CurateExisting       Move conflicting alternatives into backup.
-Force                Replace existing same-name targets.
```

## Output

The curator writes:

```text
SKILLS-GLOBAL-INVENTORY.md
~\.codex\skills-backup\xiaobai-YYYY-MM-DD\README.md
```

These files explain:

- what is active globally
- what was moved to backup
- why each choice was made
- how to restore alternatives later

## Beginner Philosophy

Xiaobai Skills is not trying to install the most skills.

It is trying to make a new user productive without making their global skill
library noisy.

It will:

- keep narrow, concrete skills global
- avoid enabling several broad workflow frameworks at once
- back up unselected skills instead of deleting them
- leave a manifest for future agents
- restore one alternative at a time when needed

## Promotion-Friendly Demo

Before:

```text
Many skills installed globally
Same request triggers several workflow skills
No record of why something was installed
Hard to restore a previous setup
```

After:

```text
One default skill per common need
Alternatives preserved in backup
Inventory explains the choices
Restart Codex and keep working
```

## Roadmap

- [ ] Cross-platform installer for macOS/Linux
- [ ] Dry-run mode for curation
- [ ] Conflict score report
- [ ] GitHub Action to validate skill metadata
- [ ] More starter-stack presets
- [ ] Screenshots and short demo video

## Sponsorship

If this project saves you setup time, consider sponsoring ongoing maintenance:

[Sponsor on GitHub](https://github.com/sponsors/Tyuts)

Sponsors help fund:

- testing across more Codex environments
- better installers
- curated starter-stack updates
- documentation and launch guides for beginners

## Acknowledgements

Xiaobai Skills is a curator and starter pack built around excellent upstream
work:

- OpenAI Codex system skills
- [`vercel-labs/skills`](https://github.com/vercel-labs/skills)
- [`mineru98/llm-proxy-skills`](https://github.com/mineru98/llm-proxy-skills)
- [`JimLiu/baoyu-skills`](https://github.com/JimLiu/baoyu-skills)
- [`mattpocock/skills`](https://github.com/mattpocock/skills)
- [`garrytan/gstack`](https://github.com/garrytan/gstack)
- [`obra/superpowers`](https://github.com/obra/superpowers)

Please respect each upstream project's license and README.

## License

MIT. Upstream skills and referenced projects keep their own licenses.
