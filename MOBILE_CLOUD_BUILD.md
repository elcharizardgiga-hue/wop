# SidePlay — build the APK from your phone

This release includes a GitHub Actions workflow at `.github/workflows/build-apk.yml`.
GitHub's Linux runner installs Node, Java and the Android SDK, builds SidePlay, and returns a build artifact containing `SidePlay-debug.apk`.

## Easiest phone-only route

1. Create a new empty GitHub repository (private is fine).
2. From your phone, open a GitHub Codespace for that repository.
3. Upload this SidePlay ZIP into the Codespace file explorer.
4. In the Codespace terminal, run:

   ```bash
   unzip SidePlay-Node-v0.3.1-phone-cloud-builder.zip -d sideplay
   cp -a sideplay/. .
   rm -rf sideplay SidePlay-Node-v0.3.1-phone-cloud-builder.zip
   git add .
   git commit -m "Add SidePlay"
   git push
   ```

5. Open the repository's **Actions** tab.
6. Open **Build SidePlay APK** and tap **Run workflow** if it did not start automatically.
7. Open the completed run and download the artifact named **SidePlay-v0.3.1-APK**.
8. Android downloads it as a ZIP. Extract it and install `SidePlay-debug.apk`.

## Notes

- No Android Studio is required.
- No JDK or Android SDK needs to be installed on your phone.
- The workflow also runs automatically on pushes to `main`.
- GitHub artifacts are ZIP downloads, so the artifact already matches the "ZIP containing the APK" workflow.
- This is a debug APK for testing. Android may ask you to allow installs from your browser/files app.
