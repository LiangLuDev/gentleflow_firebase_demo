import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gentleflow_firebase_demo/firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instanceFor(app: firebaseApp);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential? userCredential;

      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await auth.signInWithPopup(googleProvider);
      }else if (Platform.isMacOS || Platform.isWindows|| Platform.isLinux) {
        final result = await DesktopWebviewAuth.signIn(GoogleSignInArgs(
          clientId:
          DefaultFirebaseOptions.desktop.iosClientId ?? '',
          redirectUri: 'https://gentleflow-firebase.firebaseapp.com/__/auth/handler',
        ));
        print('result ${result.toString()}');
        if (result != null) {
          final credential = GoogleAuthProvider.credential(
            idToken: result.idToken,
            accessToken: result.accessToken,
          );
          userCredential = await auth.signInWithCredential(credential);
        }
      }else {
        final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await auth.signInWithCredential(googleAuthCredential);
      }

      final user = userCredential?.user;
      return user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('snapshot ${snapshot.data}');
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${snapshot.data?.toString()} --- ${snapshot.data?.email}--- ${snapshot.data?.displayName}'),
                    );
                  } else {
                    print('snapshot ${snapshot.error}');
                    return Text('无数据');
                  }
                }),
            TextButton(
                onPressed: () {
                  save();
                },
                child: Text('Set')),
            TextButton(
                onPressed: () {
                  get();
                },
                child: Text('Get')),TextButton(
                onPressed: () {
                  update();
                },
                child: Text('Update')),TextButton(
                onPressed: () {
                  logout();
                },
                child: Text('Signout')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: signInWithGoogle,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  save() {
    User? user = FirebaseAuth.instance.currentUser;
    print('user ${user.toString()}');
    final docData = {
      "displayName": user?.displayName,
      "uid": user?.uid,
      "email": user?.email,
      "isVip": false,
    };
    FirebaseFirestore.instance.collection('member').doc(user?.uid).set(docData);
  }

  get() async{
    User? user = FirebaseAuth.instance.currentUser;
    var future = await FirebaseFirestore.instance.collection('member').doc(user?.uid).get();
    print('future ${future.data()}');
  }

  bool isUpdate = false;
  update() async{
    isUpdate = !isUpdate;
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('member').doc(user?.uid).update({
      'isVip': isUpdate
    });
  }

  logout() async{
    FirebaseAuth.instance.signOut();
  }
}
