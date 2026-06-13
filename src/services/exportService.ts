import { exportRows } from '../utils/exportUtils'

export const exportService = {
  toCsv<T extends Record<string, unknown>>(rows: T[], name: string): void {
    exportRows(rows, `${name}.csv`)
  },
  toSpreadsheet<T extends Record<string, unknown>>(rows: T[], name: string): void {
    exportRows(rows, `${name}-spreadsheet.csv`)
  },
}

