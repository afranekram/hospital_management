# Firebase Setup Guide — Hospital Management App

This guide walks through migrating the project to **your own Firebase account**.

---

## 1. Create a Firebase Project

- Go to https://console.firebase.google.com
- Click **Add project**, give it a name (e.g. `hospital-management-app`)
- Disable Google Analytics (optional)

## 2. Register Apps in Firebase Console

Click each platform icon inside your project and enter the following:

| Platform | App ID / Package |
|---|---|
| **Android** | Package name — `com.ekram.hospitalmanagement` |
| **iOS** | Bundle ID — `com.ekram.hospitalmanagement` |
| **Web** | Any nickname |
| **Windows / macOS** | Same as Web (Flutter desktop) |

## 3. Download Config Files

| Platform | File | Destination |
|---|---|---|
| Android | `google-services.json` | `android/app/google-services.json` |
| iOS / macOS | `GoogleService-Info.plist` | iOS Xcode project root |
| Web | `firebaseConfig` object | Used by FlutterFire CLI (step 4) |

## 4. Run FlutterFire CLI (Recommended)

This regenerates all config files automatically for your project.

```powershell
# Install FlutterFire CLI (if not already installed)
dart pub global activate flutterfire_cli

# Reconfigure — this overwrites firebase_options.dart, firebase.json,
# google-services.json, and GoogleService-Info.plist
flutterfire configure --project=your-firebase-project-id
```

## 5. Fix `main.dart`

After FlutterFire CLI runs, open **`lib/main.dart`** and update `Firebase.initializeApp()` to use the generated options:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

## 6. Deploy Firestore Rules

Replace the contents of `firestore.rules` with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

Deploy:

```powershell
firebase deploy --only firestore:rules
```

## 7. Enable Authentication

- Firebase Console → **Authentication** → **Sign-in method**
- Enable **Email/Password** provider

## 8. Set Up Storage

- Firebase Console → **Storage** → **Get started**
- Start in **test mode** (or customise rules later)

## 9. Run the App

```powershell
flutter clean
flutter pub get
flutter run
```

---

## Summary

| Step | What happens |
|---|---|
| Create project | Your own Firebase project |
| Register apps | Android, iOS, Web, Windows registered |
| FlutterFire CLI | All config files regenerated for your project |
| Fix `main.dart` | Pass `DefaultFirebaseOptions` to `initializeApp` |
| Deploy rules | Firestore access requires authentication |
| Enable Auth | Email/Password sign-in turned on |
| Storage | File uploads enabled |
| Run | App connects to your Firebase backend |
