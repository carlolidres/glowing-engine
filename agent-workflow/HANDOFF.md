# HANDOFF.md

Current operational handoff for Codex, Claude Code, Cursor, MiniMax M2.7, and compatible coding agents.

## Required Reading Order

```text
AGENTS.md
↓
agent-workflow/AGENTS.md
↓
agent-workflow/DOX.md
↓
agent-workflow/HANDOFF.md
↓
agent-workflow/PLAN.md
↓
baseline-.md
↓
plans/<active-task>/plan.mdx
```

Cursor agents also read `.cursor/rules/`. Claude Code agents may use `.claude/skills/`.

## Current State

- **Project:** GxP Toolkit reusable Vite React TypeScript starter template
- **Runtime UI:** custom CSS + Recharts; Ant Design is a reference only
- **Canonical history:** `agent-workflow/agent-history/`
- **Active plan:** `plans/continue-ai-agent-workflow/plan.mdx`
- **Approval status:** approved on 2026-06-20
- **Cursor Stage 2 review:** completed on 2026-06-20
- **Application behavior:** unchanged by the workflow-continuation task

## Completed This Cycle

- Created the approved local visual plan for continuing Claude's workflow implementation.
- Replaced placeholder `agent-workflow/PLAN.md` with the active task pointer and approval record.
- Aligned shared workflow docs around plan-first execution, visual-plan review, and explicit approval.
- Confirmed canonical history remains under `agent-workflow/agent-history/`.
- Confirmed runtime UI documentation is custom CSS + Recharts, with Ant Design references only.
- Updated Cursor rules to preserve the visual-plan approval gate and Graphify fallback behavior.
- Updated `agent-workflow/agent-history/version-0-baseline.md` to remove Ant Design-as-runtime contradictions.
- Updated `vite.config.ts` so Vitest excludes the local `reference/` corpus and tests only this template.
- Cursor Stage 2 review completed: documentation consistency verified, validation re-run independently, HANDOFF and version-1-handoff updated.

## Cursor Stage 2 Review (2026-06-20)

**Agent:** Cursor  
**Scope:** Review-only; no resets, commits, staging, or source behavior changes.

### Documentation consistency — passed

- Reading order aligned across `AGENTS.md`, `agent-workflow/*`, `baseline-.md`, and `.cursor/rules/`.
- Plan-first approval gate is explicit and not bypassed (valid approval phrase documented; comments/revisions excluded).
- Graphify and SQLite map instructions match `package.json` scripts and `.gitignore` policy.
- Canonical history is `agent-workflow/agent-history/`; root `agent-history/` remains obsolete (deleted in worktree).
- Runtime UI documented as custom CSS + Recharts; no `antd` in dependencies; Ant Design appears only as reference in `REFERENCE_LINKS.md`.
- `vite.config.ts` excludes `reference/**` from Vitest.

### Minor inconsistencies (document only; no fix in this cycle)

- `version-0-baseline.md` opening still mentions "project goals" while DOX assigns project goals to `baseline-.md` only.
- `graphify.mdc` reading-order wording differs slightly from `project-workflow.mdc`.
- `workflow.mdc` lacks `alwaysApply: true` unlike sibling Cursor rules.
- `verify:supabase` referenced in workflow docs but not defined in `package.json` — **Command unavailable.**

### Worktree review (unchanged)

- **Tracked (61 files vs HEAD):** legacy `.agent/` and root `agent-history/` deletions; workflow docs; dirty tracked `graphify-out/`; Claude-era `src/` changes.
- **Untracked:** `agent-workflow/`, `plans/`, `baseline-.md`, `database/`, `scripts/`, `.cursor/`, `.claude/`, `reference/`, etc.
- Root `agent-history/version-2-handoff.md` and `version-3-handoff.md` deleted but not migrated to `agent-workflow/agent-history/` — confirm with owner before commit.
- `.claude/settings.local.json` is local host config — do not commit unless owner approves.

## Generated Maps

- `graphify-out/` is generated codebase-map output and should remain local/gitignored unless the owner explicitly approves committing a snapshot.
- `sqlite-out/` is generated schema-map output from `database/sqlite/*.sql`.
- Do not edit either generated output folder by hand.

## Database State

- Current implemented schema source: `database/sqlite/schema.sql`
- Current seed source: `database/sqlite/seed.sql`
- Generated schema map: `sqlite-out/`
- Supabase migrations: planned only; no implemented Supabase schema or RLS policy is present beyond the `supabase/migrations/.gitkeep` stub.

## Known Issues and Risks

- The repository has a large pre-existing dirty worktree from Claude's unfinished work.
- Root `agent-history/` and `.agent/` remain deleted in the worktree; this is consistent with the approved canonical location but should be reviewed before commit.
- `graphify-out/` has tracked dirty generated files even though current workflow docs say generated maps should be gitignored/local. Untracking generated output should be a separate approved cleanup.
- `.claude/settings.local.json` is local Claude configuration and should not be treated as reusable cross-agent documentation.

## Git Diff Review (2026-06-20)

Owner review of the dirty worktree by file group. No staging or commits performed.

### Group A — AI workflow and documentation (this cycle)

**Untracked (add):** `agent-workflow/`, `plans/`, `baseline-.md`, `.cursor/`, `.agents/`, `.claude/skills/` (not `settings.local.json`), `docs/`

**Tracked (modified):** `AGENTS.md`, `README.md`, `.gitignore`

**Tracked (deleted — intentional):** `.agent/**`, root `agent-history/**` (canonical location is `agent-workflow/agent-history/`)

### Group B — Template infrastructure

**Untracked (add):** `database/`, `scripts/`, `.github/`, `supabase/`, `public/`, `.env.example`

**Tracked (modified):** `vite.config.ts` (Vitest excludes `reference/**`), `eslint.config.js`, `tsconfig.node.json`, `package.json`, `package-lock.json`

### Group C — Application (Claude-era work, separate from workflow-doc scope)

**Tracked (modified):** `src/**` (18 files), `index.html`

**Untracked (add):** `src/components/charts/chartTheme.ts`, `SidebarNavGroup.tsx`, `multiform/`, `config/`, `hooks/`, `lib/`, `MultiTabFormsPage.tsx`, `multiform-project.css`

### Group D — Exclude from commit (recommended)

| Path | Reason |
|------|--------|
| `graphify-out/**` | Generated output; gitignored in policy but still tracked — do not commit dirty snapshot |
| `reference/**` | Local study corpus; Vitest-excluded; large and not template source |
| `.claude/settings.local.json` | Local host permissions only |
| `sqlite-out/` | Generated (gitignored; not in index) |

### Open decision before commit

Root `agent-history/version-2-handoff.md` and `version-3-handoff.md` are deleted but not migrated to `agent-workflow/agent-history/`. Confirm drop vs restore before committing deletions.

## Verification

Codex (Stage 1) and Cursor (Stage 2) both ran the validation suite independently.

- Documentation stale-reference check: passed; no stale placeholder or Ant Design-as-runtime references found.
- `npm run db:map`: passed; 5 tables, 3 foreign keys, 4 indexes.
- `npm run verify:schema`: passed; users (4 IDs) and documents (5 IDs) aligned.
- `npm run lint`: passed.
- `npm run test`: passed; 1 test file, 3 tests (`reference/**` excluded via `vite.config.ts`).
- `npm run build`: passed.
- `npm run graphify:check`: passed.
- `npm run verify:supabase`: **Command unavailable** (script not defined in `package.json`).

## Next Actions

1. ~~Owner review of final Git diff by file group~~ — completed 2026-06-20 (see Git Diff Review above).
2. **Commit when requested** — say which groups to include (A+B only, or A+B+C) and record commit hash here.
3. Separate approved cleanup (optional): untrack committed `graphify-out/` files; gitignore `reference/` and `.claude/settings.local.json`; migrate or drop root `agent-history/version-2|3-handoff.md`.

## Reviewers Feedback

- **Reviewers:** @carlo-mauring
- **Comments:**
