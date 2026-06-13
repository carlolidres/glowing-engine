export type UserRole = 'Admin' | 'Manager' | 'Editor' | 'Viewer'

export interface AuthUser {
  id: string
  name: string
  email: string
  role: UserRole
  initials: string
}

export interface LoginCredentials {
  email: string
  password: string
  role: UserRole
}

