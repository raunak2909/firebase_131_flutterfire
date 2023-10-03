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
        return macos;
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
    apiKey: 'AIzaSyDDI3ykWv0R0UZWVejeaeZVT2RZnnAeJas',
    appId: '1:808317363646:web:91e267211e5431e53645ef',
    messagingSenderId: '808317363646',
    projectId: 'shoppercart-f107f',
    authDomain: 'shoppercart-f107f.firebaseapp.com',
    storageBucket: 'shoppercart-f107f.appspot.com',
    measurementId: 'G-P2GYYK69EY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY1PcaxzmwZzrGX4M1GTGydTR9ACySLGo',
    appId: '1:808317363646:android:9ba07e16b446f7f63645ef',
    messagingSenderId: '808317363646',
    projectId: 'shoppercart-f107f',
    storageBucket: 'shoppercart-f107f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOmQAtxyC4eZhF9q4c6a2sXUtyISh_lr8',
    appId: '1:808317363646:ios:019e0996f3dac81a3645ef',
    messagingSenderId: '808317363646',
    projectId: 'shoppercart-f107f',
    storageBucket: 'shoppercart-f107f.appspot.com',
    iosBundleId: 'com.example.firebase131Flutterfire',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOmQAtxyC4eZhF9q4c6a2sXUtyISh_lr8',
    appId: '1:808317363646:ios:9b5241a409160f043645ef',
    messagingSenderId: '808317363646',
    projectId: 'shoppercart-f107f',
    storageBucket: 'shoppercart-f107f.appspot.com',
    iosBundleId: 'com.example.firebase131Flutterfire.RunnerTests',
  );
}
