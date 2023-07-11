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
    apiKey: 'AIzaSyCg7_E-dmy8JU3DTqaW8LQeE_PCGAP-vIo',
    appId: '1:992976481400:web:5b3615afc497fd6a8dd18d',
    messagingSenderId: '992976481400',
    projectId: 'rhythmic-gymnastics-club',
    authDomain: 'rhythmic-gymnastics-club.firebaseapp.com',
    storageBucket: 'rhythmic-gymnastics-club.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsJv5fHVBTKLOOPHPoD7U1QRq9dHPc_78',
    appId: '1:992976481400:android:892990faf926eff48dd18d',
    messagingSenderId: '992976481400',
    projectId: 'rhythmic-gymnastics-club',
    storageBucket: 'rhythmic-gymnastics-club.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3iR0Vjc5760G-DuWmTzNX-e4ylGl6RGM',
    appId: '1:992976481400:ios:6905b8f2323f40ee8dd18d',
    messagingSenderId: '992976481400',
    projectId: 'rhythmic-gymnastics-club',
    storageBucket: 'rhythmic-gymnastics-club.appspot.com',
    iosClientId: '992976481400-tvc5f7sm18oh5ut4ep5u0ucuua98f4ba.apps.googleusercontent.com',
    iosBundleId: 'com.aqibapps.meeja',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3iR0Vjc5760G-DuWmTzNX-e4ylGl6RGM',
    appId: '1:992976481400:ios:6905b8f2323f40ee8dd18d',
    messagingSenderId: '992976481400',
    projectId: 'rhythmic-gymnastics-club',
    storageBucket: 'rhythmic-gymnastics-club.appspot.com',
    iosClientId: '992976481400-tvc5f7sm18oh5ut4ep5u0ucuua98f4ba.apps.googleusercontent.com',
    iosBundleId: 'com.aqibapps.meeja',
  );
}
