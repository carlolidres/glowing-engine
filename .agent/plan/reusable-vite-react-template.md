# Reusable Vite React Template Plan

## Objective

Transform this greenfield workspace into a backend-agnostic Vite, React, and TypeScript starter library with mock authentication, reusable application UI, statistical dashboards, document workflows, and e-signature simulation.

## Current Status

- [x] Read `AGENTS.md`.
- [x] Read `agent-history/version-0-baseline.md`.
- [x] Read the latest handoff, `agent-history/version-1-handoff.md`.
- [x] Read applicable `.agent/rules/` files.
- [x] Confirmed the workspace has no application source, package manifest, or Git repository.
- [x] Confirmed Graphify is already configured.

## Implementation Plan

- [x] Initialize Git and scaffold Vite + React + TypeScript configuration.
- [x] Add the typed application shell, navigation, mock authentication, route guards, feedback, forms, tables, filters, pagination, dialogs, and export helpers.
- [x] Add dashboard cards, timelines, notifications, quick actions, and realistic mock data.
- [x] Add reusable statistical utilities, charts, statistical summaries, alerts, and the continuous process verification experience.
- [x] Add document management, routing/approval, and e-signature simulation components with mock services and state.
- [x] Add all requested example pages and responsive styling.
- [x] Add utility tests and project documentation.
- [x] Run install, tests, lint, build, and a local browser smoke test.
- [x] Refresh Graphify after substantive source changes.
- [x] Create `agent-history/version-2-handoff.md` with assumptions, risks, lessons, verification, commit message, and commit identification instructions.
- [x] Commit the completed task as `v2: build reusable React template`.

## Architecture Choices

- Use React Context only for mock authentication and toast state.
- Use React Router with `HashRouter` so the starter works on static hosting.
- Use plain responsive CSS with design tokens to keep components portable.
- Use Recharts for reusable visualization primitives.
- Use mock service interfaces with asynchronous methods so real adapters can replace them later.
- Use Vitest for calculation tests and ESLint for static checks.

## Assumptions

- The new reusable-template request supersedes the Project Tracker-specific migration direction for this workspace.
- Mock document upload and e-signature features simulate state and do not persist files.
- CSV export is implemented directly; the Excel-style export uses a spreadsheet-compatible CSV download to avoid an unnecessary XLSX dependency.

## Risks

- A broad starter library necessarily demonstrates workflow depth without implementing production persistence or identity security.
- Recharts does not provide native box plots or control-chart families, so reusable composed SVG/chart primitives will implement those views.
- Browser-only download APIs require a browser and are not exercised by unit tests.

## Reviewers Feedback

- **Reviewers:** @carlo-mauring
- **Comments:**
