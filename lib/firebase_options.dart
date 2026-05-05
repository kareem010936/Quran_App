import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDn6WhAfJs-3cg6I3OLrgBkcyYWeJqdsjw',
    appId: '1:93032176771:web:54bacc809c2b314e1c8fb6',
    messagingSenderId: '93032176771',
    projectId: 'quran-app-f708f',
    authDomain: 'quran-app-f708f.firebaseapp.com',
    storageBucket: 'quran-app-f708f.firebasestorage.app',
    measurementId: 'G-K6DVGMV3VB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDar-q9kxDCaALHsvddYVgNbP4jK4Apl7Y',
    appId: '1:93032176771:android:918e5e2108bb10121c8fb6',
    messagingSenderId: '93032176771',
    projectId: 'quran-app-f708f',
    storageBucket: 'quran-app-f708f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAzv87efEZQIo6pNlhI01y00X1ptCbsYo',
    appId: '1:93032176771:ios:f5b7d0315fc2a26d1c8fb6',
    messagingSenderId: '93032176771',
    projectId: 'quran-app-f708f',
    storageBucket: 'quran-app-f708f.firebasestorage.app',
    iosBundleId: 'com.example.quran',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCAzv87efEZQIo6pNlhI01y00X1ptCbsYo',
    appId: '1:93032176771:ios:f5b7d0315fc2a26d1c8fb6',
    messagingSenderId: '93032176771',
    projectId: 'quran-app-f708f',
    storageBucket: 'quran-app-f708f.firebasestorage.app',
    iosBundleId: 'com.example.quran',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDn6WhAfJs-3cg6I3OLrgBkcyYWeJqdsjw',
    appId: '1:93032176771:web:b8fa5f73ba3285a71c8fb6',
    messagingSenderId: '93032176771',
    projectId: 'quran-app-f708f',
    authDomain: 'quran-app-f708f.firebaseapp.com',
    storageBucket: 'quran-app-f708f.firebasestorage.app',
    measurementId: 'G-PKE9M12JL8',
  );
}
