// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:myflutix/auth/AUTH.dart';

import 'Regis.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;

  final Auth _auth = Auth();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlEmail = TextEditingController();

  final TextEditingController _ctrlPassword = TextEditingController();

  Future<void> _login() async {
    // final user = FirebaseAuth.instance.currentUser;
    try {
      String? userUid = await _auth.login(
        _ctrlEmail.text,
        _ctrlPassword.text,
      );
      // print('Successfully logged in. User UID: $userUid');
      showSuccessSnackbar();
      if (userUid != null) {
        Navigator.pushReplacementNamed(context, '/bottomNav');
      }
    } catch (e) {
      // if (user != null && !user.emailVerified) {
      //   try {
      //     await user.sendEmailVerification();
      //     print('Email verifikasi telah dikirim. Periksa kotak masuk Anda.');
      //   } catch (e) {
      //     print('Gagal mengirim ulang email verifikasi: $e');
      //   }
      // }
      print('Login failed: $e');
    }    
  }
  void showSuccessSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrasi berhasil!'),
          duration: Duration(seconds: 2),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _ctrlEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Email Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _ctrlPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Password Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _login(),
                  // onPressed: () {},
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text("Submit"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Regis()));
                  },
                  child: Text("Belum Punya Akun? Klik Disini Untuk Register"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.value.text;
    final password = _ctrlPassword.value.text;
    setState(() => _loading = true);
    await Auth().login(email, password);
    setState(() => _loading = false);
  }

  void tampilkanPeringatanLoginGagal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text('Email atau password salah. Silakan coba lagi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
