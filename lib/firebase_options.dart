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
    apiKey: 'AIzaSyCKw2-PNMoyBmgqBDF3Ymu59q5ykCiJof8',
    appId: '1:656352394652:web:ebd63f53086361ca7a1c59',
    messagingSenderId: '656352394652',
    projectId: 'the-todo-list-e0c43',
    authDomain: 'the-todo-list-e0c43.firebaseapp.com',
    storageBucket: 'the-todo-list-e0c43.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDb0K0gFXNIR56Xc3VFPpKKSpG055BN7OA',
    appId: '1:656352394652:android:33848ebd19913dc07a1c59',
    messagingSenderId: '656352394652',
    projectId: 'the-todo-list-e0c43',
    storageBucket: 'the-todo-list-e0c43.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1uwm5j10Jzm1F5PSv75RrYv1GrfddLgc',
    appId: '1:656352394652:ios:a7696efe068875d77a1c59',
    messagingSenderId: '656352394652',
    projectId: 'the-todo-list-e0c43',
    storageBucket: 'the-todo-list-e0c43.appspot.com',
    iosClientId: '656352394652-jtudmaf7cufc702billi8kaoennpcvdq.apps.googleusercontent.com',
    iosBundleId: 'com.aunsh.theTodoList',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1uwm5j10Jzm1F5PSv75RrYv1GrfddLgc',
    appId: '1:656352394652:ios:b393e3dcaf2a463e7a1c59',
    messagingSenderId: '656352394652',
    projectId: 'the-todo-list-e0c43',
    storageBucket: 'the-todo-list-e0c43.appspot.com',
    iosClientId: '656352394652-6fp9kem4vim253fod0msp849ke7dmgkf.apps.googleusercontent.com',
    iosBundleId: 'com.aunsh.theTodoList.RunnerTests',
  );
}
