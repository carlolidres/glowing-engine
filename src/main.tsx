import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { HashRouter } from 'react-router-dom'

import { App } from './app/App'
import { AuthProvider } from './hooks/useAuth'
import { ThemeProvider } from './hooks/useTheme'
import { ToastProvider } from './components/feedback/ToastProvider'
import './styles/globals.css'
import './styles/multiform-project.css'

// #region agent log
const envCheck = {
  appEnv: import.meta.env.VITE_APP_ENV,
  basePath: import.meta.env.VITE_BASE_PATH ?? '(unset)',
  githubPages: import.meta.env.VITE_GITHUB_PAGES ?? '(unset)',
  hasSupabaseUrl: Boolean(import.meta.env.VITE_SUPABASE_URL && !import.meta.env.VITE_SUPABASE_URL.includes('your-project')),
  appEnvLooksLikePath: String(import.meta.env.VITE_APP_ENV ?? '').startsWith('/'),
}
fetch('http://127.0.0.1:7455/ingest/8e5de5b3-0332-49aa-81c2-de4d3a74494c',{method:'POST',headers:{'Content-Type':'application/json','X-Debug-Session-Id':'307376'},body:JSON.stringify({sessionId:'307376',location:'main.tsx:env-check',message:'env config at startup',data:envCheck,timestamp:Date.now(),hypothesisId:'H1-H3'})}).catch(()=>{});
// #endregion

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <HashRouter>
      <ThemeProvider>
        <AuthProvider>
          <ToastProvider>
            <App />
          </ToastProvider>
        </AuthProvider>
      </ThemeProvider>
    </HashRouter>
  </StrictMode>,
)

