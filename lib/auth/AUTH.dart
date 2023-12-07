import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'User not found';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password';
      } else {
        throw 'Login failed';
      }
    }
  }

  Future<void> regis(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Registration error: $e');
      throw e;
    }
  }

  // Future<void> login(String email, String password) async {
  //   final user = await _auth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  Future<bool> checkEmailUsage(String email) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: "dummy_password");
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return true;
      }
      return false;
    }
  }

  Future<bool> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
}

void getUserID() {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String userID = user.uid;
    print('User ID: $userID');
  } else {
    print('Tidak ada pengguna yang login.');
  }
}
