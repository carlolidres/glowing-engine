# Project Starter — how to use this folder

This folder lives inside [glowing-engine](https://github.com/carlolidres/glowing-engine). It is the **reuse kit** for the GxP AI workflow: clone or pull this repo once, then run scripts from `project-starter/` to copy workflow files (or the full app template) into any new project.

**Source of truth:** workflow files (`agent-workflow/`, `AGENTS.md`, Cursor rules, schema scripts, etc.) stay at the **repository root**. This folder does not duplicate them — it lists them in [`workflow-manifest.json`](workflow-manifest.json) and copies them on demand.

---

## Prerequisites

- **Windows:** PowerShell 5.1+ (built in). Full export uses `robocopy`.
- **macOS / Linux:** `rsync` and `jq` for shell scripts.
- **Optional:** [Graphify](https://pypi.org/project/graphifyy/) for codebase maps; not required for install.

Keep a local clone you can update:

```powershell
git clone https://github.com/carlolidres/glowing-engine.git C:\src\glowing-engine
```

All commands below assume your shell is in that clone (or this repo):

```powershell
cd C:\src\glowing-engine
# or
cd "C:\Users\...\06 template Vite React Typescript"
```

---

## Choose your scenario

| I want to… | Use this script | Guide |
|------------|-----------------|--------|
| Start a **new app** with UI + workflow + infra | [`export-template.ps1`](export-template.ps1) | [Scenario A](#scenario-a--new-full-project) |
| Add the **AI workflow only** to an existing repo | [`install-ai-workflow.ps1`](install-ai-workflow.ps1) | [Scenario B](#scenario-b--workflow-only-into-existing-project) |
| **Refresh** workflow files after `git pull` | [`install-ai-workflow.ps1`](install-ai-workflow.ps1) `-Force` | [Scenario C](#scenario-c--upgrade-workflow-in-a-project) |

---

## Scenario A — New full project

Exports the entire Vite React template (app, workflow, GitHub Actions, SQLite tooling) into a new folder. Skips `node_modules/`, `reference/`, generated maps, and secrets — see [`.exportignore`](.exportignore).

**Windows**

```powershell
.\project-starter\export-template.ps1 -Destination "C:\Projects\my-new-app"
cd C:\Projects\my-new-app
npm install
copy .env.example .env.local
npm run dev
```

**Unix / Git Bash**

```bash
./project-starter/export-template.sh /path/to/my-new-app
cd /path/to/my-new-app
npm install
cp .env.example .env.local
npm run dev
```

If the destination is not empty, add `-Force` (PowerShell) or `--force` (shell).

**Then:** follow [CHECKLIST.md](CHECKLIST.md), edit **`baseline-.md`**, and use [FIRST_PROMPT.md](FIRST_PROMPT.md) for your first agent chat.

---

## Scenario B — Workflow only into existing project

Use when you already have an app and only need the Codex/Cursor workflow, visual plans, schema map scripts, and agent docs.

**Windows**

```powershell
.\project-starter\install-ai-workflow.ps1 -Destination "C:\Projects\my-existing-app"
```

**Unix**

```bash
./project-starter/install-ai-workflow.sh /path/to/my-existing-app
```

**Optional:** point at a different glowing-engine clone:

```powershell
.\project-starter\install-ai-workflow.ps1 `
  -Destination "C:\Projects\my-app" `
  -Source "C:\src\glowing-engine"
```

### What gets installed

Paths are defined in [`workflow-manifest.json`](workflow-manifest.json):

| Category | Paths copied |
|----------|----------------|
| Entry | `AGENTS.md` |
| Workflow | `agent-workflow/` |
| Cursor | `.cursor/rules/` |
| Claude / agents | `.claude/skills/`, `.agents/skills/` |
| Plans | `plans/templates/` |
| Schema | `database/sqlite/`, `scripts/*.mjs` |
| This kit | `project-starter/` (so the target can upgrade later) |
| Docs | `docs/` |

**Seeded only if missing** (from [`templates/`](templates/)):

- `baseline-.md`
- `agent-workflow/HANDOFF.md`
- `agent-workflow/PLAN.md`

The script also appends workflow lines to `.gitignore` and reminds you to merge [`templates/package-scripts.json`](templates/package-scripts.json) into the target `package.json`.

### After workflow install

1. Merge npm scripts from [`templates/package-scripts.json`](templates/package-scripts.json) into your app's `package.json` `"scripts"` block.
2. Fill in **`baseline-.md`** with your project definition.
3. Run in the **target** project:

```powershell
cd C:\Projects\my-existing-app
npm run db:map
npm run verify:schema
npm run graphify:update   # when Graphify is installed
```

4. Paste [FIRST_PROMPT.md](FIRST_PROMPT.md) into Codex or Cursor.

---

## Scenario C — Upgrade workflow in a project

When glowing-engine gets workflow improvements, pull and reinstall:

```powershell
cd C:\src\glowing-engine
git pull origin master

.\project-starter\install-ai-workflow.ps1 `
  -Destination "C:\Projects\my-app" `
  -Force
```

Review the diff in the target project before committing — `-Force` overwrites workflow files with the latest from glowing-engine. Project-specific content in `baseline-.md` and active `plans/<task>/` is preserved unless those paths are overwritten; templated HANDOFF/PLAN are replaced when using `-Force`.

Full details: [UPGRADE.md](UPGRADE.md).

---

## Verify before you commit changes to glowing-engine

If you add or move workflow files in this repo, update [`workflow-manifest.json`](workflow-manifest.json) in the same commit, then:

```powershell
.\project-starter\verify-manifest.ps1
```

---

## Folder map

```text
project-starter/
├── README.md                 ← you are here
├── workflow-manifest.json    ← canonical list of installable paths
├── install-ai-workflow.ps1   ← workflow-only install (Windows)
├── install-ai-workflow.sh    ← workflow-only install (Unix)
├── export-template.ps1       ← full template export (Windows)
├── export-template.sh        ← full template export (Unix)
├── verify-manifest.ps1       ← validate manifest against repo
├── UPGRADE.md                ← pull latest → reinstall loop
├── CHECKLIST.md              ← post-copy adaptation checklist
├── FIRST_PROMPT.md           ← first message for Codex/Cursor
├── templates/                ← seeds for new projects
│   ├── baseline-.md
│   ├── HANDOFF.md
│   ├── PLAN.md
│   ├── gitignore-append.txt
│   └── package-scripts.json
└── .exportignore             ← excludes for full export only
```

---

## Quick reference

```powershell
# New full app
.\project-starter\export-template.ps1 -Destination "C:\Projects\new-app"

# Workflow into existing app
.\project-starter\install-ai-workflow.ps1 -Destination "C:\Projects\my-app"

# Upgrade workflow after git pull
.\project-starter\install-ai-workflow.ps1 -Destination "C:\Projects\my-app" -Force

# Validate manifest
.\project-starter\verify-manifest.ps1
```

For human onboarding of the whole template, see the root [README.md](../README.md).
