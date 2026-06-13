# Generic Agent Reference System Plan

## Objective

Convert `AGENTS.md`, `.agent/`, and `agent-history/` into a portable, project-neutral AI continuity and engineering reference system suitable for copying into future repositories.

## Scope

- [x] Read the current baseline, latest handoff, rules, plans, and Git state.
- [x] Inventory project-specific names, paths, services, credentials, technologies, and migration assumptions.
- [x] Rewrite `AGENTS.md` as a generic repository protocol with configurable requirements.
- [x] Replace the project-specific baseline with a generic baseline template.
- [x] Replace prior handoff documents with generic example/reference handoffs.
- [x] Replace project-specific plans with reusable plan templates and examples.
- [x] Rewrite or rename `.agent/rules/` files so every rule is provider-neutral or explicitly optional.
- [x] Scan all Markdown and MDC files for personal paths, repository names, project IDs, and inherited business terms.
- [x] Verify application lint, tests, and build remain unaffected.
- [x] Refresh Graphify.
- [x] Create a generic version 3 handoff and commit the documentation refactor.

## Design Principles

- Required rules describe workflow and quality gates, not a specific framework or vendor.
- Technology-specific rules are optional references activated only when the current project uses that technology.
- Example plans use placeholders such as `<PROJECT_NAME>` and `<PROVIDER>`.
- Baselines capture project-specific decisions at adoption time, while this repository ships a fill-in template.
- Handoffs remain concise, factual, and tied to verifiable Git history.

## Assumptions

- The explicit request authorizes replacing the previously project-specific baseline and historical reference documents.
- The application source remains unchanged; this task affects only agent guidance, plans, handoffs, and generated Graphify artifacts.
- Existing filenames may be renamed when their names encode a specific technology or old project.

## Risks

- Rewriting prior handoffs removes their value as immutable historical records; this is intentional because the folder is being converted into a reference component library.
- Overly broad rules can conflict with real project conventions, so project-local configuration must take precedence when this kit is adopted.

## Reviewers Feedback

- **Reviewers:** `<REVIEWER>`
- **Comments:**
