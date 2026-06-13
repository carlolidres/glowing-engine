import { createContext, useContext, useMemo, useState, type ReactNode } from 'react'

import { authService } from '../services/authService'
import type { AuthUser, LoginCredentials, UserRole } from '../types/auth'

interface AuthContextValue {
  user: AuthUser | null
  isAuthenticated: boolean
  login: (credentials: LoginCredentials) => Promise<void>
  logout: () => void
  hasRole: (roles: UserRole[]) => boolean
}

const AuthContext = createContext<AuthContextValue | null>(null)

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(() => authService.getCurrentUser())

  const value = useMemo<AuthContextValue>(() => ({
    user,
    isAuthenticated: Boolean(user),
    login: async (credentials) => setUser(await authService.login(credentials)),
    logout: () => {
      authService.logout()
      setUser(null)
    },
    hasRole: (roles) => Boolean(user && roles.includes(user.role)),
  }), [user])

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth(): AuthContextValue {
  const context = useContext(AuthContext)
  if (!context) throw new Error('useAuth must be used inside AuthProvider')
  return context
}

