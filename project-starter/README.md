# Project Starter — copy kit for new projects

Use this folder to export a **clean GxP Toolkit template** into a new project directory. The export includes the Vite React app, AI-agent workflow (`agent-workflow/`), Cursor rules, SQLite schema tooling, and sample plans — without local junk ( `node_modules`, `reference/`, generated maps, secrets).

## Quick start (recommended)

From the **template repository root** (parent of this folder):

```powershell
.\project-starter\export-template.ps1 -Destination "C:\Projects\my-new-app"
cd C:\Projects\my-new-app
npm install
copy .env.example .env.local
npm run dev
```

Unix / Git Bash:

```bash
./project-starter/export-template.sh /path/to/my-new-app
cd /path/to/my-new-app
npm install
cp .env.example .env.local
npm run dev
```

If the destination folder already has files, add `-Force` (PowerShell) or `--force` (shell script).

## What gets exported

Everything under the template root **except** paths listed in [`.exportignore`](.exportignore), including:

- `src/`, `public/`, `database/`, `scripts/`, `agent-workflow/`, `.cursor/`, `.claude/skills/`, `plans/`
- Root docs: `AGENTS.md`, `README.md`, `baseline-.md`, `.env.example`, `.github/`
- This `project-starter/` folder (so each copy can export again)

**Excluded by default:** `node_modules/`, `dist/`, `.git/`, `graphify-out/`, `sqlite-out/`, `reference/`, `.env.local`, local DB files, `.claude/settings.local.json`.

## After copying

1. Read [CHECKLIST.md](CHECKLIST.md).
2. Update **`baseline-.md` only** with your project definition.
3. Reset `agent-workflow/HANDOFF.md` and `agent-workflow/PLAN.md` for the first session.
4. Use [FIRST_PROMPT.md](FIRST_PROMPT.md) as your first message to Codex or Cursor.

## Manual copy (no script)

You may also copy the whole repository folder in File Explorer, then delete excluded directories listed in `.exportignore`. The export scripts automate that and avoid missing an exclude.

## Regenerate maps on the new project

```powershell
npm run db:map
npm run graphify:update   # requires Graphify installed
npm run verify:schema
```
