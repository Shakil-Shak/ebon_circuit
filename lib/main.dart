import 'package:ebon_circuit/new%20requairments/passket_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options:

  // );
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAWPbH_xjA-GBqTmujBWw7HpvTs6qrpoD4",
      authDomain: "astha-da7cd.firebaseapp.com",
      projectId: "astha-da7cd",
      storageBucket: "astha-da7cd.appspot.com",
      messagingSenderId: "900737741796",
      appId: "1:900737741796:web:e1e7c0868f2339cf8f8df1",
      measurementId: "G-5DMD2S9MPE",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ebon Circuit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: PasskeyScreen());
  }
}
