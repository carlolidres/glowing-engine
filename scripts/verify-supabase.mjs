#!/usr/bin/env node
/**
 * Supabase readiness check (template stub until migrations exist).
 * Run: npm run verify:supabase
 */

import { existsSync, readdirSync } from 'node:fs'
import { join } from 'node:path'

const ROOT = join(import.meta.dirname, '..')
const migrationsDir = join(ROOT, 'supabase', 'migrations')

if (!existsSync(migrationsDir)) {
  console.error('verify:supabase FAIL — supabase/migrations/ directory missing')
  process.exit(1)
}

const sqlFiles = readdirSync(migrationsDir).filter((name) => name.endsWith('.sql'))

if (sqlFiles.length === 0) {
  console.log('verify:supabase OK — planned only (stub); no PostgreSQL migrations yet')
  process.exit(0)
}

console.log(`verify:supabase OK — ${sqlFiles.length} migration file(s) present (manual review required)`)
