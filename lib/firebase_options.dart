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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDW4b98GvahHRm8leXymQ2IiAeSi1C5PTs',
    appId: '1:383281681009:web:c0f834a05e60bf68f9c1d0',
    messagingSenderId: '383281681009',
    projectId: 'ylpapp-66bd6',
    authDomain: 'ylpapp-66bd6.firebaseapp.com',
    databaseURL: 'https://ylpapp-66bd6-default-rtdb.firebaseio.com',
    storageBucket: 'ylpapp-66bd6.appspot.com',
    measurementId: 'G-1T7RMH0T0Q',
  );

static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyDyaCHxskmo8-6KYTxVEOIir2wxg5RIMoM',
  appId: '1:383281681009:android:1f2af052032a6bd0f9c1d0',
  messagingSenderId: '383281681009',
  projectId: 'ylpapp-66bd6',
  databaseURL: 'https://ylpapp-66bd6-default-rtdb.firebaseio.com',
  storageBucket: 'ylpapp-66bd6.appspot.com',
);

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUgQRfpgi4Gjpzx8YohRkubKoAdU3zfdI',
    appId: '1:310722748852:ios:fd551e0f495882fc1392e1',
    messagingSenderId: '310722748852',
    projectId: 'africanstraw-e03e1',
    storageBucket: 'africanstraw-e03e1.appspot.com',
    androidClientId: '310722748852-hajni70vv1n2c9ml2glvmrvuldo3ing3.apps.googleusercontent.com',
    iosClientId: '310722748852-tuj5sr1689t30pi40krdsvid8tmgnc8q.apps.googleusercontent.com',
    iosBundleId: 'com.vsoft.ylp',
  );

static const FirebaseOptions macos = FirebaseOptions(
  apiKey: 'AIzaSyDy_be63IQrEf2Ndp7Hd38zEZSbL-ZpUcw',
  appId: '1:383281681009:ios:f5cccf395e17c88ff9c1d0',
  messagingSenderId: '383281681009',
  projectId: 'ylpapp-66bd6',
  databaseURL: 'https://ylpapp-66bd6-default-rtdb.firebaseio.com',
  storageBucket: 'ylpapp-66bd6.appspot.com',
  androidClientId: '383281681009-86h4cktof43hh84g0kj1o9ki7bjuk8gc.apps.googleusercontent.com',
  iosClientId: '383281681009-mohhucm7dv541ed8j4ggs8v5hobja9am.apps.googleusercontent.com',
  iosBundleId: 'kologsoft.com.ylp',
);

static const FirebaseOptions windows = FirebaseOptions(
  apiKey: 'AIzaSyDW4b98GvahHRm8leXymQ2IiAeSi1C5PTs',
  appId: '1:383281681009:web:18126028c1cb5f05f9c1d0',
  messagingSenderId: '383281681009',
  projectId: 'ylpapp-66bd6',
  authDomain: 'ylpapp-66bd6.firebaseapp.com',
  databaseURL: 'https://ylpapp-66bd6-default-rtdb.firebaseio.com',
  storageBucket: 'ylpapp-66bd6.appspot.com',
  measurementId: 'G-ZY96HY7JYG',
);

}