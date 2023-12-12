// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCtsCaN8g-Rk6hDT1Cfag9rYHZA1hBEXxU',
    appId: '1:593045339331:web:f7e8886f2ab28536c97676',
    messagingSenderId: '593045339331',
    projectId: 'todo-app-21a5e',
    authDomain: 'todo-app-21a5e.firebaseapp.com',
    storageBucket: 'todo-app-21a5e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIin3Umsb3fouSJJFlhPkdAdnqweG3mGI',
    appId: '1:593045339331:android:432028d6163bbbdfc97676',
    messagingSenderId: '593045339331',
    projectId: 'todo-app-21a5e',
    storageBucket: 'todo-app-21a5e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvb12sKkTfEcBOkM9enAxo5pzj4dEYJI0',
    appId: '1:593045339331:ios:e24530e3ef345f9bc97676',
    messagingSenderId: '593045339331',
    projectId: 'todo-app-21a5e',
    storageBucket: 'todo-app-21a5e.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );
}