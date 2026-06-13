import type { StatisticalAlert, StatisticalSummary } from '../../types/statistics'

export function StatisticalSummaryGrid({ summary }: { summary: StatisticalSummary }) {
  const metrics = [
    ['Mean', summary.mean], ['Median', summary.median], ['Std. deviation', summary.standardDeviation],
    ['Minimum', summary.minimum], ['Maximum', summary.maximum], ['Cp', summary.cp], ['Cpk', summary.cpk],
    ['Pp', summary.pp], ['Ppk', summary.ppk], ['Out of spec', summary.outOfSpec],
    ['Out of control', summary.outOfControl], ['Trend signals', summary.outOfTrend],
  ]
  return <div className="stat-grid">{metrics.map(([label, value]) => <div key={String(label)}><span>{label}</span><strong>{typeof value === 'number' ? value.toFixed(value % 1 ? 2 : 0) : value}</strong></div>)}</div>
}

export function StatisticalAlertPanel({ alerts }: { alerts: StatisticalAlert[] }) {
  return <div className="alert-list">{alerts.map((alert) => <article className={`alert ${alert.severity}`} key={alert.id}><span>{alert.severity === 'critical' ? '!' : alert.severity === 'warning' ? '△' : 'i'}</span><div><strong>{alert.title}</strong><p>{alert.message}</p></div></article>)}</div>
}

