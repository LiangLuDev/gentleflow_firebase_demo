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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
        return desktop;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKCOGyh6oYwFWrBIkyuVp8gAPUfXAnd9M',
    appId: '1:595150129857:android:afa138df9b023af47d2240',
    messagingSenderId: '595150129857',
    projectId: 'gentleflow-firebase',
    storageBucket: 'gentleflow-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLmSTc8HrMDARfEJ0xB3e_PEHkwV7dxdI',
    appId: '1:595150129857:ios:1c938dc272ea076c7d2240',
    messagingSenderId: '595150129857',
    projectId: 'gentleflow-firebase',
    storageBucket: 'gentleflow-firebase.appspot.com',
    iosClientId: '595150129857-3861ru4u63h1jnif1vcgopddcra6397j.apps.googleusercontent.com',
    iosBundleId: 'tech.gentleflow.firebase.gentleflowFirebaseDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLmSTc8HrMDARfEJ0xB3e_PEHkwV7dxdI',
    appId: '1:595150129857:ios:1600cc23efa0c4707d2240',
    messagingSenderId: '595150129857',
    projectId: 'gentleflow-firebase',
    storageBucket: 'gentleflow-firebase.appspot.com',
    iosClientId: '595150129857-ustphaprrtcjb32qfjihte5ljmj0ibjr.apps.googleusercontent.com',
    iosBundleId: 'tech.gentleflow.firebase',
  );

  static const FirebaseOptions desktop = FirebaseOptions(
    apiKey: 'AIzaSyDLmSTc8HrMDARfEJ0xB3e_PEHkwV7dxdI',
    appId: '1:595150129857:ios:1600cc23efa0c4707d2240',
    messagingSenderId: '595150129857',
    projectId: 'gentleflow-firebase',
    storageBucket: 'gentleflow-firebase.appspot.com',
    iosClientId: '595150129857-ustphaprrtcjb32qfjihte5ljmj0ibjr.apps.googleusercontent.com',
    iosBundleId: 'tech.gentleflow.firebase',
  );
}