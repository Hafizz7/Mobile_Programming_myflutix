import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/auth/Regis.dart';
import 'package:myflutix/auth/auth.dart';
import 'package:myflutix/auth/login.dart';
import 'package:myflutix/ui/pages/buttonNav.dart';
import 'package:myflutix/ui/pages/my_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavScreen();
          } else {
            return Login();
          }
        },
      ),
      routes: {
        '/bottomNav': (context) => BottomNavScreen(),
        '/profile': (context) => MyProfilePage(),        
      },
    );
  }
}

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ...

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
}
