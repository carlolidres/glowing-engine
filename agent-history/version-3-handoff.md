# Version 3 Handoff - Generic Reference System Conversion

> Reference example: this handoff demonstrates how to document conversion of inherited agent guidance into a reusable project-neutral kit.

Date: `<YYYY-MM-DD>`

## Request

Make the agent protocol, rules, plans, baseline, and handoff examples reusable across future projects.

## Implemented

- Reframed `AGENTS.md` as a technology-neutral continuity protocol.
- Replaced the baseline with a fill-in project template.
- Replaced historical handoffs with generic examples.
- Replaced inherited plans with reusable bootstrap, modernization, and application-template plans.
- Converted required rules to workflow and secret-safety guidance.
- Converted stack, provider, backend, frontend, testing, and graph guidance into optional references.
- Removed personal paths, repository identifiers, provider project IDs, credentials, and business-specific terminology.

## Verification

- Project-specific residue scan: no matches.
- Documentation structure review: passed.
- Application checks: lint passed, 3 tests passed, and production build passed.
- Generated reference artifacts: refreshed; stale cache records from unrelated repositories were removed.

## Not Implemented

- No project-specific baseline values were selected.
- No optional technology rule was enabled for a future adopter.
- No application behavior was intentionally changed.

## Problems Encountered

- Existing historical files mixed reusable workflow guidance with one project's architecture and credentials.
- Generated graph caches retained stale absolute paths until the cache was reset and rebuilt.

## Assumptions

- The owner explicitly authorized replacing historical reference content.
- Future adopters will fill placeholders and remove irrelevant optional rules.

## Risks

- Unfilled placeholders can leave a new project under-specified.
- Enabling every optional rule can create conflicting guidance.

## Lessons Learned

- Required instructions should describe process and quality gates.
- Framework and provider guidance should remain opt-in.
- Baselines should hold project decisions; reusable rules should not.

## Next Steps

- Fill the baseline when adopting the kit.
- Keep only rules relevant to the selected stack.
- Add actual repository commands and acceptance criteria.

## Git Traceability

- Commit message: `v3: generalize agent reference system`
- Commit hash: resolve with `git log -1 --format=%H -- agent-history/version-3-handoff.md`

## Reviewers Feedback

- **Reviewers:** `<REVIEWER>`
- **Comments:**
