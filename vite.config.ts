import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

function ignoreSidePlayTooling(rawPath: string): boolean {
  // Chokidar 4+ no longer expands glob patterns. Vite passes this function
  // directly to the watcher, so normalize Windows paths and filter by path.
  const path = rawPath.replace(/\\/g, '/').toLowerCase()

  return (
    path.includes('/.tools/') ||
    path.endsWith('/.tools') ||
    path.includes('/android/') ||
    path.endsWith('/android') ||
    path.includes('/dist/') ||
    path.endsWith('/dist') ||
    path.endsWith('.apk') ||
    path.endsWith('.aab')
  )
}

export default defineConfig({
  plugins: [react()],
  base: './',
  build: { outDir: 'dist' },
  server: {
    watch: {
      ignored: (path) => ignoreSidePlayTooling(path),
    },
  },
})
