# RollCall — Offline Attendance App for Android

A lightweight, offline-first attendance app for teachers. Mark present / absent / holiday on a monthly calendar, lock the app behind a 4-digit PIN, and keep everything on the device — no server, no account.

## Features
- Monthly attendance calendar with tap-to-cycle status (present → absent → holiday)
- Submitted days are locked as final
- Teacher profile with photo and PIN-protected changes
- Auto-lock when the app goes to the background
- Works fully offline; data stored locally (localStorage + IndexedDB backup)

## Tech
- UI: single-file HTML / CSS / vanilla JavaScript (`app/src/main/assets/index.html`)
- Android wrapper: Java `WebView` with photo picker and auto-lock (`MainActivity.java`)
- Build: Gradle, or GitHub Actions (`.github/workflows/build.yml`) — every push produces a debug APK artifact

## Build
- **GitHub Actions:** push to GitHub, open the *Actions* tab, download the APK artifact.
- **Android Studio:** open the folder and run `assembleDebug`.
- **Command line (Debian/Ubuntu):** `KS_PASS=yourpassword ./build-apk.sh path/to/your-keystore.jks`

Never commit your keystore or its password.

## Credits
Logo illustration: "Attendance paper with checklist" vector from Freepik (attribution required under the free license).
