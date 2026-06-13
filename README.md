# Northstar Vite + React Template

Northstar is a reusable Vite, React, and TypeScript starter for operational dashboards, quality systems, continuous process verification, controlled documents, approval workflows, and e-signature simulations.

The app uses mock data only. Its service interfaces are intentionally small so projects can later connect to Supabase, REST APIs, local JSON, or third-party providers without rewriting page components.

## Run the project

```bash
npm install
npm run dev
```

Use any password on the login page. Select `Admin`, `Manager`, `Editor`, or `Viewer` to exercise mock role behavior.

## Commands

```bash
npm run dev
npm run test
npm run lint
npm run build
npm run preview
```

## Structure

```text
src/
  app/                  Routing and app composition
  components/           Reusable UI grouped by capability
  data/                 Typed mock datasets
  hooks/                Auth, filters, pagination, and statistics hooks
  pages/                Working example pages
  services/             Replaceable mock adapters
  styles/               Global design tokens and responsive styles
  types/                Shared domain types
  utils/                Statistics, dates, export, and status helpers
```

## Reusable components

- App shell, sidebar, top bar, profile menu, breadcrumbs, and responsive navigation
- Mock auth provider, login, logout, protected route, and role-restricted route
- KPI, summary, status, activity, notification, and quick-action components
- Generic data table, search, pagination, form controls, modal, confirm dialog, toast, and state feedback
- CSV and spreadsheet-compatible exports
- Line, bar, donut, scatter, histogram, bell curve, box plot, Pareto, run, and control charts
- Statistical summaries, capability calculations, trend detection, and alert panels
- Document upload, metadata, preview, lifecycle dates, statuses, controlled-copy indicator, and version history
- Sequential/parallel approval stepper, assignments, queues, decisions, reminders, and approval matrix
- Signature request, placeholders, consent, status tracking, certificate, preview, and completion feedback

The control chart primitive provides the basis for I-MR, X-bar/R, and X-bar/S presentations. Supply subgroup-derived centerlines and limits to reuse the same component for those chart families.

## Copy components into another project

Copy the component folder plus its referenced types and utilities. Components use plain CSS class names and standard React props; copy the applicable rules from `src/styles/globals.css` or map the classes to another design system.

## Add mock data

Add typed records in `src/data/`. Keep domain interfaces in `src/types/`, and expose data through a service when a page should be independent of its source.

## Connect a backend later

- **Supabase:** implement service interfaces with the Supabase client, move auth to Supabase Auth, and enforce authorization with Row Level Security.
- **REST API:** replace service methods with `fetch`, validate responses, and keep loading/error state at page boundaries.
- **Local JSON:** import JSON from `src/data/` or serve it from `public/`.
- **E-signature:** map signature requests and recipients to a provider SDK. Process provider webhooks on a trusted backend and store certificate/audit references, not secrets, in the browser.

Do not place privileged keys in Vite client variables. Static frontends can only hold public configuration.

## Notes

- CSV export opens through browser download APIs.
- Uploads, workflow actions, notifications, and signatures update or acknowledge mock state only.
- The statistical utilities have focused Vitest coverage in `src/utils/statistics.test.ts`.

