import { useState, type FormEvent } from 'react'
import { Navigate, useNavigate } from 'react-router-dom'

import { FormField, SelectInput, TextInput } from '../components/forms/FormControls'
import { useAuth } from '../hooks/useAuth'
import type { UserRole } from '../types/auth'

export function LoginPage() {
  const [isLoading, setIsLoading] = useState(false)
  const { isAuthenticated, login } = useAuth()
  const navigate = useNavigate()
  if (isAuthenticated) return <Navigate to="/" replace />

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setIsLoading(true)
    const data = new FormData(event.currentTarget)
    await login({ email: String(data.get('email')), password: String(data.get('password')), role: String(data.get('role')) as UserRole })
    navigate('/')
  }

  return <div className="login-page"><section className="login-story"><div className="brand light"><div className="brand-mark">N</div><div><strong>Northstar</strong><span>Reusable React template</span></div></div><div><span className="eyebrow">Build with a head start</span><h1>Quality operations, composed for reuse.</h1><p>A polished starter for dashboards, process monitoring, controlled documents, approvals, and signatures.</p></div><div className="login-proof"><strong>100% mock data</strong><span>Backend-agnostic by design</span></div></section><section className="login-panel"><form className="login-card" onSubmit={handleSubmit}><span className="eyebrow">Welcome back</span><h2>Sign in to the template</h2><p>Any password works in this mock environment.</p><FormField label="Email"><TextInput name="email" type="email" defaultValue="admin@example.com" required /></FormField><FormField label="Password"><TextInput name="password" type="password" defaultValue="template" required /></FormField><FormField label="Example role"><SelectInput name="role"><option>Admin</option><option>Manager</option><option>Editor</option><option>Viewer</option></SelectInput></FormField><button className="button primary wide" disabled={isLoading}>{isLoading ? 'Signing in…' : 'Sign in'}</button><small>Use role selection to test protected UI patterns.</small></form></section></div>
}

