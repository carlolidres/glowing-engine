# AGENTS.md

Main entry file for Codex, Claude Code, Cursor, MiniMax M2.7, and compatible AI coding agents.

---

## Reusable Template Purpose

This repository is the **GxP Toolkit** — a reusable starter, sample-component library, and reference project for future GxP-oriented applications.

The entire folder may be copied into a new project and adapted. After copying:

1. Keep the minimal root `AGENTS.md` at the new project root.
2. Update **`baseline-.md` only** with your project definition (name, goals, roles, pages, schema intent, deployment).
3. Update `agent-workflow/HANDOFF.md` and `agent-workflow/PLAN.md` for the first work session.
4. Preserve the Codex-first, Cursor-second, Graphify + SQLite map workflow unless the project owner explicitly changes it.

All work must preserve the reusable starter/template purpose unless the project owner explicitly approves conversion into a business-specific project.

---

## Required Reading Order

Future agents must read workflow files in this order before editing:

```text
agent-workflow/AGENTS.md
↓
agent-workflow/DOX.md
↓
agent-workflow/HANDOFF.md
↓
agent-workflow/PLAN.md
↓
baseline-.md
```

Claude Code agents may use `.claude/skills/` for local skill commands. Cursor agents must also read `.cursor/rules/project-workflow.mdc` and `.cursor/rules/graphify.mdc` after the files above. Codex, MiniMax M2.7, and other compatible agents use these Markdown files as the shared source of truth unless their host supports an equivalent local skill/rule format.

Map layers: `graphify-out/` → `sqlite-out/` → `database/sqlite/`.

For template-invariant workflow rules only, read `agent-workflow/agent-history/version-0-baseline.md`. **Project-specific goals belong in `baseline-.md`, not version-0-baseline.**

---

## File Responsibilities

| File | Purpose |
|------|---------|
| `baseline-.md` | **Project owner baseline** — what to build (update on copy) |
| `agent-workflow/AGENTS.md` | Main instruction file for AI agents |
| `agent-workflow/DOX.md` | Documentation standards and workflow rules |
| `agent-workflow/HANDOFF.md` | Current work status, verification, known issues, next steps |
| `agent-workflow/PLAN.md` | Active task planning |
| `agent-workflow/REFERENCE_LINKS.md` | External references only — study and adaptation, not bulk copy |
| `agent-workflow/agent-history/version-0-baseline.md` | Template-invariant workflow rules (read only on copy) |
| `agent-workflow/agent-history/version-N-handoff.md` | Completed implementation-cycle records |
| `database/sqlite/` | Editable schema and seed SQL |
| `sqlite-out/` | Generated schema map (`npm run db:map`) |
| `graphify-out/` | Generated codebase map (`npm run graphify:update`) |

Do not duplicate project goals in `HANDOFF.md` or `version-0-baseline.md`.

---

## Schema change rule (prevents mock/SQL drift)

When changing `src/types/`, `src/data/`, or `src/services/`:

1. Update `database/sqlite/schema.sql` and `seed.sql`.
2. Run `npm run db:map`.
3. Run `npm run verify:schema`.

---

## Project Workflow Extension

```txt
DOX → HANDOFF → PLAN → baseline-.md → Graphify + sqlite-out maps
Codex → Cursor → Verification
```

### Graphify and SQLite maps

- **Graphify** (`graphify-out/`): primary codebase map for agents — verify against source.
- **SQLite map** (`sqlite-out/`): primary schema map for agents — regenerate with `npm run db:map`.
- Do not edit generated map folders by hand.

---

## Plan-First Approval Gate

Every non-trivial development task must begin with analysis and planning before source edits.

Required sequence:

```text
Task received
↓
Read required workflow files
↓
Inspect relevant source files
↓
Inspect Graphify map or perform equivalent dependency mapping
↓
Inspect SQLite/schema map when data models may be affected
↓
Create or update a local visual plan under plans/
↓
Present the plan for review
↓
Wait for explicit approval
↓
Implement only the approved scope
```

Valid approval must be clear, such as:

```text
Approved. Proceed with implementation.
```

Questions, comments, partial agreement, or requested revisions are not approval. If the scope materially changes, revise the visual plan and request approval again.

## AI Workflow

### Stage 1 — Codex

1. Read project context in the required order.
2. Create or update `agent-workflow/PLAN.md` and the local visual plan.
3. Identify affected files (use Graphify when available).
4. Present the plan and wait for explicit owner approval.
5. Implement approved changes; sync SQL when data models change.
6. Run verification.
7. Update `agent-workflow/HANDOFF.md`.

### Stage 2 — Cursor

1. Review the approved plan and completed Codex work.
2. Apply Graphify and SQLite map review.
3. Trace dependencies and schema alignment.
4. Fix integration gaps.
5. Run final verification.
6. Update `agent-workflow/HANDOFF.md`.

---

## Verification

When available:

```powershell
npm install
npm run build
npm run lint
npm run test
npm run verify:workflow
npm run verify:schema
npm run db:map
npm run graphify:check
npm run verify:supabase
npm run verify:env
```

Report missing scripts as `Command unavailable.`

---

## Conflict Resolution

Priority order:

```txt
baseline-.md (project-specific)
↓
agent-workflow/AGENTS.md
↓
agent-workflow/DOX.md
↓
agent-workflow/HANDOFF.md
↓
agent-workflow/PLAN.md
```

`agent-workflow/agent-history/version-0-baseline.md` defines template-invariant workflow rules only.

---

## Recommended Repository Structure

```txt
/
├── AGENTS.md
├── baseline-.md
├── README.md
├── agent-workflow/
├── database/sqlite/
├── .cursor/rules/
├── graphify-out/   (generated, gitignored)
├── sqlite-out/     (generated, gitignored)
├── src/
└── package.json
```
