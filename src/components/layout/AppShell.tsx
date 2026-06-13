import { useState, type ReactNode } from 'react'
import { NavLink, useLocation } from 'react-router-dom'

import { useAuth } from '../../hooks/useAuth'

const navigation = [
  ['/', 'Overview', '▦'],
  ['/components', 'Components', '◇'],
  ['/statistics', 'Analytics', '⌁'],
  ['/cpv', 'Process verification', '∿'],
  ['/documents', 'Documents', '▤'],
  ['/routing', 'Approvals', '⇢'],
  ['/signatures', 'E-signatures', '✎'],
  ['/settings', 'Settings', '⚙'],
]

export function AppShell({ children }: { children: ReactNode }) {
  const [isMenuOpen, setIsMenuOpen] = useState(false)
  const { user, logout } = useAuth()
  const location = useLocation()
  const current = navigation.find(([path]) => path === location.pathname)?.[1] ?? 'Northstar'

  return (
    <div className="app-shell">
      <aside className={isMenuOpen ? 'sidebar open' : 'sidebar'}>
        <div className="brand"><div className="brand-mark">N</div><div><strong>Northstar</strong><span>Quality systems kit</span></div></div>
        <nav>{navigation.map(([path, label, icon]) => <NavLink end={path === '/'} key={path} to={path} onClick={() => setIsMenuOpen(false)}><span>{icon}</span>{label}</NavLink>)}</nav>
        <div className="sidebar-footer"><div className="environment-dot" />Mock data environment</div>
      </aside>
      <div className="app-main">
        <header className="topbar">
          <button className="menu-button" onClick={() => setIsMenuOpen((value) => !value)} aria-label="Toggle navigation">☰</button>
          <div><p className="breadcrumb">Workspace / {current}</p><strong>{current}</strong></div>
          <div className="topbar-actions"><button className="icon-button" aria-label="Notifications">◦<span className="notification-dot" /></button><div className="profile"><div className="avatar">{user?.initials}</div><div><strong>{user?.name}</strong><span>{user?.role}</span></div><button className="text-button" onClick={logout}>Log out</button></div></div>
        </header>
        <main>{children}</main>
      </div>
      {isMenuOpen && <button className="sidebar-scrim" onClick={() => setIsMenuOpen(false)} aria-label="Close navigation" />}
    </div>
  )
}

