#!/usr/bin/env node
/**
 * Cross-platform workflow integration check: manifest paths + npm scripts.
 * Run: npm run verify:workflow
 */

import { existsSync, readFileSync } from 'node:fs'
import { join } from 'node:path'

const ROOT = join(import.meta.dirname, '..')
const manifestPath = join(ROOT, 'project-starter', 'workflow-manifest.json')
const packageScriptsPath = join(ROOT, 'project-starter', 'templates', 'package-scripts.json')

let failed = false

function fail(msg) {
  console.error(`verify:workflow FAIL — ${msg}`)
  failed = true
}

if (!existsSync(manifestPath)) {
  fail('project-starter/workflow-manifest.json missing')
  process.exit(1)
}

const manifest = JSON.parse(readFileSync(manifestPath, 'utf8'))
const requiredScripts = JSON.parse(readFileSync(packageScriptsPath, 'utf8'))
const packageJsonPath = join(ROOT, 'package.json')

if (!existsSync(packageJsonPath)) {
  fail(
    'package.json missing — run install-ai-workflow.ps1 (it merges workflow scripts) or use export-template.ps1 for a full app copy',
  )
  process.exit(1)
}

const pkg = JSON.parse(readFileSync(packageJsonPath, 'utf8'))

for (const entry of manifest.paths) {
  if (!entry.required) continue
  const full = join(ROOT, entry.path)
  if (!existsSync(full)) {
    fail(`missing required path: ${entry.path}`)
  }
}

for (const [name, command] of Object.entries(requiredScripts)) {
  if (pkg.scripts?.[name] !== command) {
    fail(`package.json scripts.${name} must be: ${command}`)
  }
}

for (const rel of Object.values(manifest.templates)) {
  const local = join(ROOT, rel)
  if (!existsSync(local)) {
    fail(`missing template: ${rel}`)
  }
}

const entryAgents = join(ROOT, 'AGENTS.md')
if (existsSync(entryAgents)) {
  const text = readFileSync(entryAgents, 'utf8')
  if (!text.includes('agent-workflow/')) {
    fail('root AGENTS.md must redirect to agent-workflow/')
  }
}

if (failed) {
  process.exit(1)
}

console.log(
  `verify:workflow OK — ${manifest.paths.filter((p) => p.required).length} required paths, ${Object.keys(requiredScripts).length} npm scripts aligned`,
)
