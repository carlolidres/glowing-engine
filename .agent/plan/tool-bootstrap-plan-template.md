# Tool Bootstrap Plan Template

## Objective

Install or configure `<TOOL_NAME>` only when it adds value to the current repository, then verify its output and document how future agents should use it.

## Current State

- [ ] Confirm the tool is relevant to the repository size and task.
- [ ] Check whether the tool is already installed.
- [ ] Check whether generated artifacts already exist and are current.
- [ ] Review repository policies for generated files and network access.

## Plan

- [ ] Install the tool only if unavailable.
- [ ] Configure it with project-neutral paths and placeholders.
- [ ] Generate or refresh artifacts.
- [ ] Verify artifact provenance and content.
- [ ] Add concise usage guidance to `.agent/rules/` if needed.
- [ ] Run relevant repository checks.
- [ ] Record limitations, assumptions, and maintenance steps.

## Verification

- Version command: `<COMMAND>`
- Generation command: `<COMMAND>`
- Expected outputs: `<FILES_OR_REPORTS>`
- Validation query or smoke test: `<COMMAND>`

## Assumptions

- `<ASSUMPTION>`

## Risks

- Generated artifacts may become stale.
- Unsupported languages or file types may reduce coverage.
- Generated files may add repository size or noise.

## Reviewers Feedback

- **Reviewers:** `<REVIEWER>`
- **Comments:**
