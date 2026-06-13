import {
  Area,
  Bar,
  BarChart,
  CartesianGrid,
  Cell,
  ComposedChart,
  Legend,
  Line,
  LineChart,
  Pie,
  PieChart,
  ReferenceLine,
  ResponsiveContainer,
  Scatter,
  ScatterChart,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts'

const colors = ['#167d83', '#315d9a', '#e2a93b', '#7451a6', '#d26459']

export function TrendChart({ data, dataKey = 'value' }: { data: Array<Record<string, string | number>>; dataKey?: string }) {
  return <div className="chart"><ResponsiveContainer><LineChart data={data}><CartesianGrid strokeDasharray="3 3" vertical={false} /><XAxis dataKey="label" /><YAxis domain={['auto', 'auto']} /><Tooltip /><Line type="monotone" dataKey={dataKey} stroke="#167d83" strokeWidth={3} dot={{ r: 3 }} /></LineChart></ResponsiveContainer></div>
}

export function SimpleBarChart({ data }: { data: Array<{ label: string; value: number }> }) {
  return <div className="chart"><ResponsiveContainer><BarChart data={data}><CartesianGrid strokeDasharray="3 3" vertical={false} /><XAxis dataKey="label" /><YAxis /><Tooltip /><Bar dataKey="value" fill="#315d9a" radius={[5, 5, 0, 0]} /></BarChart></ResponsiveContainer></div>
}

export function DonutChart({ data }: { data: Array<{ name: string; value: number }> }) {
  return <div className="chart"><ResponsiveContainer><PieChart><Pie data={data} dataKey="value" innerRadius={58} outerRadius={86} paddingAngle={3}>{data.map((item, index) => <Cell key={item.name} fill={colors[index % colors.length]} />)}</Pie><Tooltip /><Legend /></PieChart></ResponsiveContainer></div>
}

export function ScatterPlot({ data }: { data: Array<{ x: number; y: number }> }) {
  return <div className="chart"><ResponsiveContainer><ScatterChart><CartesianGrid /><XAxis dataKey="x" type="number" /><YAxis dataKey="y" type="number" /><Tooltip cursor={{ strokeDasharray: '3 3' }} /><Scatter data={data} fill="#7451a6" /></ScatterChart></ResponsiveContainer></div>
}

export function ControlChart({ data, center, ucl, lcl, usl, lsl }: { data: Array<Record<string, string | number>>; center: number; ucl: number; lcl: number; usl?: number; lsl?: number }) {
  return <div className="chart chart-large"><ResponsiveContainer><LineChart data={data}><CartesianGrid strokeDasharray="3 3" vertical={false} /><XAxis dataKey="label" /><YAxis domain={['auto', 'auto']} /><Tooltip /><Line dataKey="value" stroke="#315d9a" strokeWidth={2.5} /><ReferenceLine y={center} stroke="#167d83" label="CL" /><ReferenceLine y={ucl} stroke="#d26459" strokeDasharray="5 5" label="UCL" /><ReferenceLine y={lcl} stroke="#d26459" strokeDasharray="5 5" label="LCL" />{usl !== undefined && <ReferenceLine y={usl} stroke="#e2a93b" label="USL" />}{lsl !== undefined && <ReferenceLine y={lsl} stroke="#e2a93b" label="LSL" />}</LineChart></ResponsiveContainer></div>
}

export function Histogram({ values }: { values: number[] }) {
  const minimum = Math.min(...values)
  const width = (Math.max(...values) - minimum || 1) / 6
  const bins = Array.from({ length: 6 }, (_, index) => ({ label: (minimum + index * width).toFixed(1), value: 0 }))
  values.forEach((value) => { bins[Math.min(5, Math.floor((value - minimum) / width))].value += 1 })
  return <SimpleBarChart data={bins} />
}

export function BellCurve({ mean, sigma }: { mean: number; sigma: number }) {
  const data = Array.from({ length: 41 }, (_, index) => {
    const x = mean - 4 * sigma + (index * 8 * sigma) / 40
    const y = sigma ? Math.exp(-0.5 * ((x - mean) / sigma) ** 2) / (sigma * Math.sqrt(2 * Math.PI)) : 0
    return { label: x.toFixed(2), value: y }
  })
  return <div className="chart"><ResponsiveContainer><ComposedChart data={data}><CartesianGrid strokeDasharray="3 3" vertical={false} /><XAxis dataKey="label" interval={7} /><YAxis hide /><Tooltip /><Area type="monotone" dataKey="value" fill="#cce7e4" stroke="#167d83" /></ComposedChart></ResponsiveContainer></div>
}

export function ParetoChart({ data }: { data: Array<{ label: string; value: number; cumulative: number }> }) {
  return <div className="chart"><ResponsiveContainer><ComposedChart data={data}><CartesianGrid strokeDasharray="3 3" vertical={false} /><XAxis dataKey="label" /><YAxis /><Tooltip /><Bar dataKey="value" fill="#315d9a" /><Line dataKey="cumulative" stroke="#d26459" strokeWidth={3} /></ComposedChart></ResponsiveContainer></div>
}

export function BoxPlot({ values }: { values: number[] }) {
  const sorted = [...values].sort((a, b) => a - b)
  const at = (ratio: number) => sorted[Math.floor((sorted.length - 1) * ratio)] ?? 0
  const [min, q1, med, q3, max] = [at(0), at(0.25), at(0.5), at(0.75), at(1)]
  const range = max - min || 1
  const position = (value: number) => `${((value - min) / range) * 90 + 5}%`
  return <div className="box-plot"><div className="whisker" style={{ left: position(min), right: `${100 - Number.parseFloat(position(max))}%` }} /><div className="box" style={{ left: position(q1), width: `${((q3 - q1) / range) * 90}%` }}><span style={{ left: `${((med - q1) / (q3 - q1 || 1)) * 100}%` }} /></div><small>{min.toFixed(2)}</small><small>{max.toFixed(2)}</small></div>
}

