import type { CapacitorConfig } from '@capacitor/cli'

const config: CapacitorConfig = {
  appId: 'app.sideplay.mobile',
  appName: 'SidePlay',
  webDir: 'dist',
  android: {
    allowMixedContent: false,
    backgroundColor: '#09090b'
  }
}

export default config
