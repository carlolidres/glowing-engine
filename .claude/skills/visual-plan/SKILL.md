---
name: visual-plan
description: >
  Turn ordinary text plans into rich interactive visual plans with diagrams,
  file maps, annotated code, open questions, and UI/prototype review. Uses
  local-files mode (plans stored in plans/ folder, repo-controlled). No external
  dependencies - plans never leave the repository.
metadata:
  mode: local-files
  visibility: exported
---

# Agent-Native Plans (Local-Files Mode)

This is the local-files variant of visual-plan. All plans are stored as MDX files
in the `plans/` folder and never sent to external servers.

## Workflow

1. Read codebase context (use Graphify output, check existing files/symbols).
2. Create plan using native blocks: `code`, `file-tree`, `data-model`, `diff`, `diagram`, `question-form`.
3. Publish to `plans/<slug>/plan.mdx` with optional `canvas.mdx`.
4. User reviews and comments via local bridge or file edit.
5. Apply feedback with surgical `contentPatches`.
6. Only then: implement changes.

## Local-Files Contract

- Plans stored in `plans/<slug>/` (checked into repo) or `.agent-native/plans/<slug>/` (ignored).
- Use `npx @agent-native/core@latest plan local check --dir plans/<slug>` before serving.
- Use `npx @agent-native/core@latest plan local serve --dir plans/<slug> --open` to preview.
- Feedback = file edits or chat comments, no hosted comments.

## Tool Guidance (when MCP available)

- `create-visual-plan`: Create document-first plan (architecture, backend, data, refactor).
- `create-ui-plan`: Create UI-first plan with canvas.
- `create-prototype-plan`: Create prototype-first plan with functional review surface.
- `update-visual-plan`: Apply changes via `contentPatches`.
- `get-plan-feedback`: Read feedback after user review.

## Core Workflow

1. Research before drafting: read actual files, name real symbols.
2. Create plan with appropriate tool/block structure.
3. Surface plan link or local preview URL.
4. Wait for user review/comments before implementing.
5. Apply feedback, then implement.

Planning is read-only. No source edits while plan is in review.

## Visual Surface Choice

- **No visual surface** for architecture-only, backend-only, or non-visual plans.
- **Canvas only** for static screens, component states, visual comparisons.
- **Canvas + prototype** for multi-step flows.
- **Prototype-first** when interaction is the main question.

## Native Blocks

Must use native blocks for structured content:

- `code`: code snippets with file reference
- `file-tree`: file structure diagrams
- `data-model`: schema and types
- `diff`: before/after changes
- `diagram`: inline architecture diagrams
- `question-form`: open questions with options

## Self-Review Before Handoff

For high-stakes plans (architecture, backend, data, multi-file):

- Spawn skeptical reviewer to check for: unanchored claims, missing decisions, filler.
- Fix clear-cut issues with `contentPatches`.
- Leave genuine judgment calls in `question-form` for user.

## References

- `references/canvas.md` — Canvas/artboard mechanics
- `references/wireframe.md` — Wireframe quality rules
- `references/document-quality.md` — Document quality bar
- `references/exemplar.md` — Good vs. bad examples