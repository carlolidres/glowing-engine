# Upgrade the AI workflow in an existing project

Use this when [glowing-engine](https://github.com/carlolidres/glowing-engine) gets workflow improvements and you want to pull them into an app you already started.

## Recommended upgrade loop

```text
1. Pull latest glowing-engine (or clone fresh)
2. Run install-ai-workflow into your app folder
3. Merge any package.json script changes
4. Re-run validation in the target app
5. Commit the workflow update in the target app
```

## Step 1 — Get the latest workflow source

```powershell
cd C:\src\glowing-engine
git pull origin master
```

Or clone once and reuse as your workflow source:

```powershell
git clone https://github.com/carlolidres/glowing-engine.git C:\src\glowing-engine
```

## Step 2 — Install into your project

From the **glowing-engine** repo (or with `-Source` pointing at it):

```powershell
.\project-starter\install-ai-workflow.ps1 `
  -Destination "C:\Projects\my-existing-app" `
  -Force
```

- **Without `-Force`:** skips files that already exist; merges folders with robocopy/rsync.
- **With `-Force`:** overwrites workflow files with the latest from glowing-engine. Use when you intentionally want upstream doc/rule updates. Review the diff before committing — project-specific edits in `baseline-.md`, `HANDOFF.md`, and active `plans/` may be overwritten for templated files only; other paths merge.

Files always seeded from templates when missing (or with `-Force`):

- `baseline-.md`
- `agent-workflow/HANDOFF.md`
- `agent-workflow/PLAN.md`

## Step 3 — Merge npm scripts

Compare your app's `package.json` with [`templates/package-scripts.json`](templates/package-scripts.json). Add any missing entries under `"scripts"`.

Required for schema/Graphify workflow:

- `db:map`, `verify:schema`, `db:init`, `db:update`, `db:reset`
- `graphify:check`, `graphify:update`, `graphify:benchmark` (when Graphify is installed)

## Step 4 — Verify in the target project

```powershell
cd C:\Projects\my-existing-app
npm run db:map
npm run verify:schema
npm run lint
npm run test
npm run build
npm run graphify:check
```

## What stays in glowing-engine only

These are **not** copied by `install-ai-workflow` (full app export uses `export-template.ps1` instead):

- Application source (`src/`, routes, pages, components)
- `package.json` dependencies (merge scripts manually)
- CI workflows (copy `.github/` separately if needed)

## Manifest as source of truth

Every installable path is listed in [`workflow-manifest.json`](workflow-manifest.json). When glowing-engine adds workflow files, update the manifest in the same commit so future installs stay complete.

Verify the manifest before releasing:

```powershell
.\project-starter\verify-manifest.ps1
```
