# SidePlay v0.3.1

## Phone-first cloud APK builder

- Added `.github/workflows/build-apk.yml`.
- GitHub Actions installs Node 24, JDK 21 and Android SDK 36 remotely.
- Builds the Vite UI, creates/syncs the Capacitor Android project, applies SidePlay's native patches and runs Gradle.
- Uploads `SidePlay-debug.apk`, SHA256 checksum and a tiny README as the `SidePlay-v0.3.1-APK` artifact.
- Added `MOBILE_CLOUD_BUILD.md` with a phone-only Codespaces workflow.
- No Android Studio, local JDK, local SDK, Vercel or Google Cloud project is required for the build itself.
