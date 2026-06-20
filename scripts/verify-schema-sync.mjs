#!/usr/bin/env node
/**
 * Verify src/data mocks align with database/sqlite/seed.sql (IDs and counts).
 * Skips mock alignment when src/data is absent (workflow-only install).
 */

import { existsSync, readFileSync } from 'node:fs'
import { join } from 'node:path'

const ROOT = join(import.meta.dirname, '..')
const mockAuth = join(ROOT, 'src', 'data', 'mockAuth.ts')
const mockDocuments = join(ROOT, 'src', 'data', 'mockDocuments.ts')

if (!existsSync(mockAuth) || !existsSync(mockDocuments)) {
  console.log(
    'verify:schema SKIP — no src/data mocks (workflow-only install); run export-template.ps1 or add app mocks to enable full schema sync check',
  )
  process.exit(0)
}

function extractIdsFromTs(filePath, pattern) {
  const text = readFileSync(filePath, 'utf8')
  return [...text.matchAll(pattern)].map((m) => m[1])
}

function extractSeedIds(table) {
  const seed = readFileSync(join(ROOT, 'database', 'sqlite', 'seed.sql'), 'utf8')
  const regex = new RegExp(`INSERT OR REPLACE INTO ${table}[\\s\\S]*?VALUES\\s*([\\s\\S]*?);`, 'i')
  const match = seed.match(regex)
  if (!match) return []
  return [...match[1].matchAll(/\('([^']+)'/g)].map((m) => m[1])
}

function compare(label, mockIds, seedIds) {
  const mockSet = new Set(mockIds)
  const seedSet = new Set(seedIds)
  const missingInSeed = mockIds.filter((id) => !seedSet.has(id))
  const extraInSeed = seedIds.filter((id) => !mockSet.has(id))
  if (missingInSeed.length || extraInSeed.length) {
    console.error(`${label} ID mismatch:`)
    if (missingInSeed.length) console.error(`  In mocks, missing from seed: ${missingInSeed.join(', ')}`)
    if (extraInSeed.length) console.error(`  In seed, missing from mocks: ${extraInSeed.join(', ')}`)
    return false
  }
  console.log(`${label}: ${mockIds.length} IDs aligned`)
  return true
}

const checks = [
  compare(
    'users',
    extractIdsFromTs(mockAuth, /id:\s*'([^']+)'/g),
    extractSeedIds('users'),
  ),
  compare(
    'documents',
    extractIdsFromTs(mockDocuments, /id:\s*'([^']+)'/g).filter((id) => id.startsWith('d')),
    extractSeedIds('documents'),
  ),
]

if (!checks.every(Boolean)) {
  process.exit(1)
}

console.log('Schema/mock sync verification passed.')
