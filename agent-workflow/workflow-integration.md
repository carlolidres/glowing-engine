# Workflow Integration Guide

This document describes how the AI workflow integrates across Codex, Claude Code, Cursor, MiniMax M2.7, and compatible coding agents using shared Markdown files, Graphify, SQLite schema mapping, and the local visual-plan system.

## Unified Workflow

```text
AGENTS.md
↓
agent-workflow/DOX.md
↓
agent-workflow/HANDOFF.md
↓
agent-workflow/PLAN.md
↓
plans/<task-slug>/plan.mdx
↓
Explicit owner approval
↓
Minimal implementation
↓
Graphify + SQLite validation
↓
agent-workflow/HANDOFF.md + agent-workflow/agent-history/
```

## Shared Context Files

| File | Purpose | Agents |
|------|---------|--------|
| `AGENTS.md` | Root redirect to shared workflow | All |
| `agent-workflow/AGENTS.md` | Main cross-agent workflow | All |
| `agent-workflow/DOX.md` | Permanent workflow and documentation rules | All |
| `agent-workflow/HANDOFF.md` | Current working state | All |
| `agent-workflow/PLAN.md` | Active task pointer and approval record | All |
| `plans/<task-slug>/plan.mdx` | Local visual plan | All |
| `baseline-.md` | Project-owner baseline | All |
| `.cursor/rules/` | Cursor-specific rule adapters | Cursor |
| `.claude/skills/` | Claude Code skill adapters | Claude Code |
| `graphify-out/` | Generated codebase map | All, when present |
| `sqlite-out/` | Generated schema map | All, when present |

Do not duplicate the full workflow into tool-specific files. Agent-specific files should reference the shared Markdown source of truth.

## Agent-Specific Adapters

### Claude Code

- Uses `.claude/skills/visual-plan`, `.claude/skills/ponytail`, and `.claude/skills/ponytail-review`.
- Reads the shared Markdown workflow before using skills.
- The skills provide local commands; they do not replace `DOX.md`, `PLAN.md`, or `HANDOFF.md`.

### Cursor

- Uses `.cursor/rules/project-workflow.mdc`, `.cursor/rules/graphify.mdc`, `.cursor/rules/workflow.mdc`, and `.cursor/rules/ponytail.mdc`.
- Performs Graphify-assisted review when available.
- Falls back to manual dependency tracing when Graphify is unavailable.

### Codex

- Uses root `AGENTS.md` and `agent-workflow/` as the primary workflow source.
- May use installed Codex skills when available.
- Do not add `.codex/` or `.codex-plugin/` files unless the selected Codex environment supports them and the owner approves.

### MiniMax M2.7 and Compatible Agents

- Read root `AGENTS.md`, then the shared `agent-workflow/` files.
- Adapt the shared Markdown workflow to host-native skills only when that host supports them.
- Do not create duplicate instruction sources unless they provide a clear operational benefit.

## Comment-Before-Execution Pattern

1. Create or update `plans/<task-slug>/plan.mdx`.
2. Include objective, current state, file map, database impact, dependency impact, phases, risks, rollback, and validation.
3. Present the plan for review.
4. Wait for explicit approval: `Approved. Proceed with implementation.`
5. Revise and re-present the plan when scope materially changes.
6. Implement only the approved scope.

## Graphify Integration

Graphify is used for codebase architecture and dependency mapping.

- Analyze source structure, imports, routes, hooks, services, and affected dependencies.
- Store generated output in `graphify-out/`.
- Treat output as generated and local; do not edit it by hand.
- Regenerate after structural source changes with `npm run graphify:update`.
- Check freshness with `npm run graphify:check`.
- Verify important Graphify findings against source files.

Cursor uses Graphify directly when available. Codex, Claude, MiniMax, and other agents must perform equivalent source mapping with `rg`, file reads, and dependency inspection when Graphify is not available.

## SQLite Schema Integration

The implemented schema source is `database/sqlite/schema.sql` and `database/sqlite/seed.sql`.

Generated schema maps live in `sqlite-out/` and are refreshed with:

```bash
npm run db:map
```

Agents must update the schema map whenever migrations, tables, relationships, constraints, seed structure, or persistence logic changes.

Supabase migrations, Row Level Security policies, triggers, functions, and storage policies are planned only until concrete files exist under `supabase/migrations/` or related Supabase configuration paths.

## Ponytail Integration

Ponytail is minimality guidance, not an orchestration engine.

- Use existing platform features, standard APIs, and installed dependencies before adding new code or packages.
- Avoid speculative abstractions and duplicate configuration.
- Do not simplify away security, validation, accessibility, auditability, or data-loss prevention.
- Run `ponytail-review` after implementation when available to catch over-engineering.

## Version Handover Pattern

After each completed implementation cycle, create or update:

```text
agent-workflow/agent-history/version-N-handoff.md
```

Keep `agent-workflow/HANDOFF.md` concise and focused on current state. Detailed completed-cycle records belong in `agent-workflow/agent-history/`.

## Quick Reference Commands

```bash
npm run build
npm run lint
npm run test
npm run verify:schema
npm run db:map
npm run graphify:check
npm run graphify:update
```

Report unavailable commands honestly. Do not claim a command passed unless it was executed successfully.
