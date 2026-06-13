# Graph Report - 06 graphify+handoff-version  (2026-06-13)

## Corpus Check
- 59 files · ~13,617 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 349 nodes · 575 edges · 22 communities (20 shown, 2 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]

## God Nodes (most connected - your core abstractions)
1. `compilerOptions` - 18 edges
2. `useToast()` - 15 edges
3. `calculateSummary()` - 15 edges
4. `Version 1 Handoff - Graphify Rule Implementation` - 12 edges
5. `compilerOptions` - 11 edges
6. `Phased Execution (AGENTS.md versions)` - 11 edges
7. `Project Tracker — Full Migration Execution Plan` - 10 edges
8. `Repository and Supabase Project Configuration` - 10 edges
9. `Database Structure` - 10 edges
10. `SelectInput()` - 9 edges

## Surprising Connections (you probably didn't know these)
- `StatisticsDashboardPage()` --calls--> `calculateSummary()`  [EXTRACTED]
  src/pages/StatisticsDashboardPage.tsx → src/utils/statistics.ts
- `ComponentsShowcasePage()` --calls--> `useToast()`  [EXTRACTED]
  src/pages/ComponentsShowcasePage.tsx → src/components/feedback/ToastProvider.tsx
- `ContinuousProcessVerificationPage()` --calls--> `useToast()`  [EXTRACTED]
  src/pages/ContinuousProcessVerificationPage.tsx → src/components/feedback/ToastProvider.tsx
- `DashboardPage()` --calls--> `useToast()`  [EXTRACTED]
  src/pages/DashboardPage.tsx → src/components/feedback/ToastProvider.tsx
- `DocumentRoutingPage()` --calls--> `useToast()`  [EXTRACTED]
  src/pages/DocumentRoutingPage.tsx → src/components/feedback/ToastProvider.tsx

## Import Cycles
- None detected.

## Communities (22 total, 2 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.08
Nodes (46): DataTable(), PaginationControls(), StatusBadge(), TableColumn, ApprovalDecisionPanel(), ApprovalMatrix(), ApprovalStepper(), TaskQueue() (+38 more)

### Community 1 - "Community 1"
Cohesion: 0.11
Nodes (24): App(), AppRoutes(), ComponentsShowcasePage, ContinuousProcessVerificationPage, DashboardPage, DocumentManagementPage, DocumentRoutingPage, ESignaturePage (+16 more)

### Community 2 - "Community 2"
Cohesion: 0.14
Nodes (23): BellCurve(), BoxPlot(), colors, ControlChart(), DonutChart(), Histogram(), ParetoChart(), ScatterPlot() (+15 more)

### Community 3 - "Community 3"
Cohesion: 0.10
Nodes (20): Architecture, Current Status (per AGENTS.md startup), First Session After Plan Approval, Key Implementation Rules, Phase 10 — v28: GitHub Pages Production Deploy, Phase 1 — v19: Repository Bootstrap, Phase 2 — v20: Database Schema + Types, Phase 3 — v21: Authentication + Role Navigation (+12 more)

### Community 4 - "Community 4"
Cohesion: 0.07
Nodes (28): dependencies, react, react-dom, react-router-dom, recharts, devDependencies, eslint, @eslint/js (+20 more)

### Community 5 - "Community 5"
Cohesion: 0.10
Nodes (19): compilerOptions, allowJs, allowSyntheticDefaultImports, esModuleInterop, isolatedModules, jsx, lib, module (+11 more)

### Community 6 - "Community 6"
Cohesion: 0.33
Nodes (15): ProcessSpecification, buildStatisticalAlerts(), calculateSummary(), controlLimits(), cp(), cpk(), detectConsecutiveTrend(), maximum() (+7 more)

### Community 7 - "Community 7"
Cohesion: 0.06
Nodes (34): Architecture Decisions, audit_logs, Audit Trail, Baseline Approval, Business Goals, Current Source Application, Dashboard and KPI Monitoring, Data Flow (+26 more)

### Community 8 - "Community 8"
Cohesion: 0.15
Nodes (12): Assumptions, Git Traceability, Implemented, Lessons Learned, Next Steps, Not Implemented, Problems Encountered, Request (+4 more)

### Community 9 - "Community 9"
Cohesion: 0.23
Nodes (10): mockDocuments, mockSignatures, mockWorkflow, DocumentRepository, mockDocumentService, DocumentRecord, DocumentStatus, SignatureRequest (+2 more)

### Community 10 - "Community 10"
Cohesion: 0.15
Nodes (12): compilerOptions, allowImportingTsExtensions, lib, module, moduleDetection, moduleResolution, noEmit, skipLibCheck (+4 more)

### Community 11 - "Community 11"
Cohesion: 0.18
Nodes (9): AI Project Continuity and Handoff System, Commit Format, Completion Definition, Git Traceability Requirement, Hard Rules, Purpose, Required Folder Structure, Required Startup Procedure (+1 more)

### Community 12 - "Community 12"
Cohesion: 0.36
Nodes (7): ActivityTimeline(), KpiCard(), NotificationPanel(), QuickActions(), SummaryCard(), dashboardMetrics, recentActivity

### Community 13 - "Community 13"
Cohesion: 0.25
Nodes (7): Assumptions, Current Status, Graphify Rule Implementation Plan, Objective, Plan, Reviewers Feedback, Risks

### Community 14 - "Community 14"
Cohesion: 0.20
Nodes (9): Add mock data, Commands, Connect a backend later, Copy components into another project, Northstar Vite + React Template, Notes, Reusable components, Run the project (+1 more)

### Community 15 - "Community 15"
Cohesion: 0.22
Nodes (8): Architecture Choices, Assumptions, Current Status, Implementation Plan, Objective, Reusable Vite React Template Plan, Reviewers Feedback, Risks

## Knowledge Gaps
- **166 isolated node(s):** `name`, `private`, `version`, `type`, `dev` (+161 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `useToast()` connect `Community 0` to `Community 2`, `Community 12`?**
  _High betweenness centrality (0.034) - this node is a cross-community bridge._
- **Why does `SelectInput()` connect `Community 0` to `Community 1`, `Community 2`?**
  _High betweenness centrality (0.022) - this node is a cross-community bridge._
- **Why does `FormField()` connect `Community 0` to `Community 1`, `Community 2`?**
  _High betweenness centrality (0.016) - this node is a cross-community bridge._
- **What connects `name`, `private`, `version` to the rest of the system?**
  _166 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.07782898105478751 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.11092436974789915 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.14039408866995073 - nodes in this community are weakly interconnected._