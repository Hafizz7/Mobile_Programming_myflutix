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
// handleSubmit() async {
//     if (!_formKey.currentState!.validate()) return;
//     final email = _ctrlEmail.value.text;
//     final password = _ctrlPassword.value.text;
//     setState(() => _loading = true);
//     await Auth().login(email, password);
//     setState(() => _loading = false);
//   }
  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      String? userUid = await _auth.login(
        _ctrlEmail.text,
        _ctrlPassword.text,
      );
      showSuccessSnackbar();
      setState(() => _loading = false);
      if (userUid != null) {
        Navigator.pushReplacementNamed(context, '/bottomNav');
      }
    } catch (e) {
      // tampilkanPeringatanLoginGagal();
      showfailedSnackbar();
      setState(() => _loading = false);
      print('Login failed: $e');
    }
  }

  void showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login berhasil!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  void showfailedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Email atau password salah. Silakan coba lagi.'),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(        
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,                                          
                  children: [
                    Text(
                      "Welcome Back,Explorer!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                       textAlign: TextAlign.left, 
                    ),
                    SizedBox(height: 60,),
                    Container(
                      child: Image.asset('assets/Login Logo.png'),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: _ctrlEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Silakan Masukkan Email Anda';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(                      
                          borderRadius:
                              BorderRadius.circular(20), 
                        ),
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
                        border: OutlineInputBorder(                      
                          borderRadius:
                              BorderRadius.circular(20), 
                        ),
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
        ],
      ),
    );
  }

  // handleSubmit() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   final email = _ctrlEmail.value.text;
  //   final password = _ctrlPassword.value.text;
  //   setState(() => _loading = true);
  //   await Auth().login(email, password);
  //   setState(() => _loading = false);
  // }

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
