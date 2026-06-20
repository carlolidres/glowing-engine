# New project checklist

After exporting or copying the GxP Toolkit template:

- [ ] Update **`baseline-.md` only** with project name, goals, roles, pages, schema intent, deployment
- [ ] Update `package.json` `name` and `version`
- [ ] Clear and rewrite `agent-workflow/HANDOFF.md` for your first session
- [ ] Clear and rewrite `agent-workflow/PLAN.md` for your first task
- [ ] Replace sample routes, sidebar menus, and page content as needed
- [ ] Extend `database/sqlite/schema.sql` for your domain tables
- [ ] Run `npm run db:map` to generate `sqlite-out/`
- [ ] Run `npm run db:init` when the `sqlite3` CLI is available
- [ ] Run `npm run graphify:update` for a fresh codebase map
- [ ] Configure `.github/workflows/` for your repository (GitHub Pages, etc.)
- [ ] Add Supabase only when you need an online backend
- [ ] Run `npm run verify:schema` after schema or mock changes

Do **not** duplicate project goals into `agent-workflow/agent-history/version-0-baseline.md` — that file is template-invariant workflow rules only.
