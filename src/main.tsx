import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { HashRouter } from 'react-router-dom'

import { App } from './app/App'
import { AuthProvider } from './hooks/useAuth'
import { ToastProvider } from './components/feedback/ToastProvider'
import './styles/globals.css'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <HashRouter>
      <AuthProvider>
        <ToastProvider>
          <App />
        </ToastProvider>
      </AuthProvider>
    </HashRouter>
  </StrictMode>,
)

