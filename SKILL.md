---
name: xiaobai-skills
description: One-click starter pack and curator for Codex/agent skills. Use when a beginner wants a high-quality default skills setup across common needs, when the user asks to install useful skills without researching them one by one, or when the installed skills library needs auditing, deduplication, conflict resolution, global-vs-backup selection, restore planning, or a written skills inventory.
---

# 小白 Skills

小白 Skills is a starter-pack and library-curation workflow for users who do not
want to spend hours researching agent skills before getting useful coverage.

It has two jobs:

1. Install a practical, high-quality default set that covers common beginner
   needs.
2. Audit an existing skills library, choose one global default per need, move
   overlapping alternatives to backup, and keep restore notes for later.

## Principles

- Cover common needs first: skill discovery, skill creation, frontend/UI,
  content/media tools, image workflows, engineering/TDD, diagnosis, planning,
  review, and handoff.
- Prefer narrow concrete skills globally; keep broad process frameworks as
  backup unless the user explicitly wants that framework.
- Back up instead of deleting.
- Write an inventory that future agents can follow.
- Restore one alternative at a time when the active choice disappoints.

## Default Starter Set

When the user asks for a beginner-friendly one-click setup, install or keep:

- System skills already bundled with Codex:
  - `imagegen`
  - `openai-docs`
  - `plugin-creator`
  - `skill-creator`
  - `skill-installer`
- Discovery:
  - `find-skills` from `vercel-labs/skills`
- Frontend/UI:
  - `frontend-master` from `mineru98/llm-proxy-skills`
- Content, media, conversion, and publishing:
  - `baoyu-skills` from `JimLiu/baoyu-skills`
- Engineering workflow:
  - `mattpocock-skills` from `mattpocock/skills`
- Skills-library governance:
  - `xiaobai-skills`

Default backup candidates:

- `gstack` from `garrytan/gstack`: rich YC-style product/engineering workflow.
- `superpowers` from `obra/superpowers`: strict brainstorming, planning, TDD,
  debugging, verification, and subagent methodology.

These are useful, but they overlap heavily with Matt Pocock's engineering
skills and with each other. Keep them in backup until the user asks for that
style or the active engineering set underperforms.

## Install Workflow

Use the bundled script when possible:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-xiaobai-skills.ps1
```

The script should:

1. Create `~\.codex\skills` if needed.
2. Install missing default skills from their GitHub sources.
3. Avoid overwriting existing installs unless `-Force` is passed.
4. Move high-conflict backup packs to
   `~\.codex\skills-backup\xiaobai-YYYY-MM-DD\` when they are present globally.
5. Write or update `SKILLS-GLOBAL-INVENTORY.md`.
6. Tell the user to restart Codex.

If the script cannot be used, perform the same steps manually with PowerShell or
GitHub CLI. Prefer GitHub release/archive downloads when `git` is missing.

## Curation Workflow

### 1. Inventory

Scan active roots:

```powershell
Get-ChildItem -LiteralPath "$env:USERPROFILE\.codex\skills" -Force
Get-ChildItem -LiteralPath "$env:USERPROFILE\.codex\skills" -Recurse -Filter SKILL.md -File
Get-ChildItem -LiteralPath "$env:USERPROFILE\.agents\skills" -Force -ErrorAction SilentlyContinue
```

Also inspect junction/symlink targets directly when recursion does not follow
them.

For each `SKILL.md`, capture:

- name
- path
- description
- source package
- whether it is system, active, backup, deprecated, dangerous, personal, or
  broad workflow-owning

### 2. Group By Need

Use this coverage map:

- skill discovery and installation
- skill creation/editing
- frontend/UI implementation
- image generation/editing
- content/media/document conversion
- translation and publishing
- engineering workflow and TDD
- debugging/diagnosis
- review/QA/verification
- planning/PRD/issues
- docs/knowledge capture
- deployment/release
- security audit
- browser automation
- platform-specific/mobile work

### 3. Choose Global Defaults

Tie-breakers:

1. System or official skills win when sufficient.
2. Narrow skills beat broad packs.
3. Stable skills beat deprecated, in-progress, or personal skills.
4. Safer workflows beat skills that require `--yolo`, `danger`, broad shell
   automation, or unknown external CLIs.
5. Only one broad engineering/process framework should be global by default.
6. Concrete conversion/publishing tools can stay global if their triggers are
   specific.

Recommended default choice:

- Engineering: Matt Pocock skills.
- Strict methodology fallback: Superpowers.
- Product/ship/team workflow fallback: gstack.
- Frontend: frontend-master.
- Media/content/conversion: Baoyu skills, with dangerous or duplicate subskills
  backed up.

### 4. Move Alternatives To Backup

Never delete by default. Move to:

`~\.codex\skills-backup\xiaobai-YYYY-MM-DD\`

Suggested structure:

```text
xiaobai-YYYY-MM-DD/
  README.md
  packages/
  disabled-global-entries/
  disabled-subskills/
```

Before moving:

- Resolve absolute paths.
- Confirm sources are inside known skills roots.
- Confirm destinations are inside the backup root.
- Preserve enough directory structure to restore later.
- Move junctions/symlinks separately from their target packages.

### 5. Write Inventory

Write:

- active global skills and their roles
- backed-up skills and why
- backup paths
- restore commands or manual restore notes
- restart reminder
- acknowledgements for the upstream skills used

Use `SKILLS-GLOBAL-INVENTORY.md` in the workspace and copy it into the backup
folder as `README.md`.

### 6. Restore

When the active choice performs poorly:

1. Identify the need category.
2. Check inventory for backup alternatives.
3. Restore one candidate at a time.
4. Restart Codex.
5. Update the inventory with what changed.

Do not re-enable all backup frameworks at once.

## Audit Notes

When acting as the skill creator, optimize for:

- clear trigger description
- concise body
- executable but safe steps
- good restore path
- user-friendly beginner language

When acting as the skill reviewer, challenge:

- overbroad triggers
- hidden destructive behavior
- instructions that fight Codex safety policy
- unclear install paths
- missing backup/restore plan
- missing acknowledgements

## Acknowledgements

This skill's recommended starter set was shaped around these upstream projects:

- OpenAI system skills: `imagegen`, `openai-docs`, `plugin-creator`,
  `skill-creator`, `skill-installer`
- `vercel-labs/skills` for `find-skills`
- `mineru98/llm-proxy-skills` for `frontend-master`
- `JimLiu/baoyu-skills`
- `mattpocock/skills`
- `garrytan/gstack`
- `obra/superpowers`

Respect each upstream project's license and README before redistribution.

## Finish Report

End with:

```text
Active:
- <skill/package>: <role>

Backed up:
- <skill/package>: <reason>

Inventory:
- <path>

Next:
- Restart Codex.
```

