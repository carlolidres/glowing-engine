# Legacy Modernization Plan Template

## Objective

Modernize `<LEGACY_SYSTEM>` into `<TARGET_ARCHITECTURE>` while preserving approved behavior, data integrity, security, and operational continuity.

## Discovery

- [ ] Inventory legacy source, runtime, integrations, and data stores.
- [ ] Identify authoritative behavior and undocumented workflows.
- [ ] Capture current users, roles, reports, exports, and audit needs.
- [ ] Identify external dependencies and migration constraints.
- [ ] Define measurable parity and acceptance criteria.

## Architecture

Document selected decisions rather than assuming them:

| Area | Legacy | Target | Rationale |
|---|---|---|---|
| UI | `<VALUE>` | `<VALUE>` | `<RATIONALE>` |
| Runtime | `<VALUE>` | `<VALUE>` | `<RATIONALE>` |
| Data | `<VALUE>` | `<VALUE>` | `<RATIONALE>` |
| Authentication | `<VALUE>` | `<VALUE>` | `<RATIONALE>` |
| Hosting | `<VALUE>` | `<VALUE>` | `<RATIONALE>` |

## Phases

1. Repository and delivery pipeline bootstrap
2. Domain model and data mapping
3. Authentication and authorization
4. Core workflows
5. Search, reporting, and exports
6. Audit, observability, and administration
7. Data migration and reconciliation
8. Performance, accessibility, and security validation
9. Cutover, rollback, and production verification

Each phase should define:

- Inputs
- Deliverables
- Files or systems affected
- Verification
- Rollback or recovery
- Handoff version and commit

## Migration Principles

- Treat legacy behavior as evidence, not automatically as ideal architecture.
- Preserve stable identifiers or maintain an explicit mapping.
- Normalize dates, booleans, enumerations, and missing values deliberately.
- Reconcile record counts and representative samples.
- Keep privileged credentials outside client code and committed files.
- Plan rollback before cutover.

## Risks

| Risk | Mitigation |
|---|---|
| Hidden legacy behavior | Observe real workflows and add acceptance tests |
| Data loss or transformation error | Dry runs, reconciliation, backups, rollback |
| Authorization gaps | Server-side enforcement and role tests |
| Scope growth | Phase gates and explicit exclusions |

## Reviewers Feedback

- **Reviewers:** `<REVIEWER>`
- **Comments:**
