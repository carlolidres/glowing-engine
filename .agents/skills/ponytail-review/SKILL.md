---
name: ponytail-review
description: >
  Code review focused exclusively on over-engineering. Finds what to delete:
  reinvented standard library, unneeded dependencies, speculative abstractions,
  dead flexibility. One line per finding: location, what to cut, what replaces
  it. Use after implementation to check for unnecessary complexity.
---

Review diffs for unnecessary complexity. One line per finding: location, what to cut, what replaces it.

## Format

`L<line>: <tag> <what>. <replacement>.`

Tags: `delete:` `stdlib:` `native:` `yagni:` `shrink:`

## Examples

- `L12-38: stdlib: 27-line validator class. "@" in email, 1 line.`
- `L4: native: moment.js imported for one format call. Intl.DateTimeFormat, 0 deps.`
- `repo.py:L88: yagni: AbstractRepository with one implementation. Inline it.`
- `L52-71: delete: retry wrapper around an idempotent local call. Nothing replaces it.`
- `L30-44: shrink: manual loop builds dict. dict(zip(keys, values)), 1 line.`

## Output

Code first (if editing), then at most three short lines: what was skipped, when to add it.

## Boundaries

Scope: over-engineering and complexity only. Correctness bugs, security holes, performance are out of scope.

End with: `net: -<N> lines possible.` or `Lean already. Ship.`