// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBi-QZo-9_wy4xCG-R4PtzMOetpOCCUCCA',
    appId: '1:1042633772076:web:8f06be865759a3a1299589',
    messagingSenderId: '1042633772076',
    projectId: 'fire-management-9ee79',
    authDomain: 'fire-management-9ee79.firebaseapp.com',
    storageBucket: 'fire-management-9ee79.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqvxXARQ-hSc1OiJB4nGtxe4tj3eJvhmk',
    appId: '1:1042633772076:android:db5c5bbe7c9e106a299589',
    messagingSenderId: '1042633772076',
    projectId: 'fire-management-9ee79',
    storageBucket: 'fire-management-9ee79.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMDmUsa3WESucLA4WfNyuJurl5K4hgPpA',
    appId: '1:1042633772076:ios:caa5fa4e1ce2eda7299589',
    messagingSenderId: '1042633772076',
    projectId: 'fire-management-9ee79',
    storageBucket: 'fire-management-9ee79.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
