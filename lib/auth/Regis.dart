// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_final_fields
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutix/auth/AUTH.dart';
import 'package:myflutix/models/profileUser.dart';
import 'package:image_picker/image_picker.dart';

import 'Login.dart';
import 'package:flutter/material.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  File? _imageFile;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlConfirmPassword = TextEditingController();
  final TextEditingController _ctrlProfileImageURL = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> uploadProfileImage(String userId, File? imageFile) async {
    try {
      if (imageFile == null) {
        print('Image file is null.');
        return 'https://via.placeholder.com/150';
      }

      Reference storageRef = _storage.ref().child('profile_images/$userId.jpg');

      await storageRef.putFile(imageFile);

      String imageUrl = await storageRef.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return 'https://via.placeholder.com/150';
    }
  }

  void uploadfoto() async {
    final email = _ctrlEmail.value.text;
    final username = _ctrlUsername.value.text;
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    // Upload gambar profil ke penyimpanan Firebase
    String? profileImageUrl =
        await uploadProfileImage(userId ?? '', _imageFile);

    // Simpan data pengguna ke Firestore
    ProfileUser profileUser = ProfileUser(
      email: email,
      id_akun: userId ?? '',
      saldo: 0,
      username: username,
      fotoProfile: profileImageUrl ?? 'https://iili.io/JIwWrb9.jpg',
    );

    try {
      profileUser.saveToFirebase();
      print('Data berhasil disimpan ke Firestore');
      setState(() => _loading = false);
    } catch (e) {
      print('Error: $e');
    }
  }

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.value.text;
    final password = _ctrlPassword.value.text;
    setState(() => _loading = true);    
    // final isEmailUsed = await Auth().checkEmailUsage(email);
    // if (isEmailUsed) {
    //   // ignore: use_build_context_synchronously
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Error'),
    //         content: Text('Email sudah digunakan. Silakan gunakan email lain.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );

    //   setState(() => _loading = false);
    //   return;
    // }
    await Auth().regis(email, password);
    uploadfoto();
    setState(() => _loading = false);
     showSuccessSnackbar();
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
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 130, // Set your preferred size
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300], // Set your preferred color
                            image: DecorationImage(
                              // You can use a placeholder image or leave it empty
                              image: _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : NetworkImage(
                                      _ctrlProfileImageURL.text.isNotEmpty
                                          ? _ctrlProfileImageURL.text
                                          : 'https://iili.io/JIwWrb9.jpg',
                                    ) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 50,
                          child: Container(
                            width: 35,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _pickImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _ctrlUsername,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Silakan Masukkan Nama Anda';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                      ),
                    ),
                    SizedBox(height: 10),
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
                    TextFormField(
                      controller: _ctrlConfirmPassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Silakan Masukkan Password Anda';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Confirm Password',
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      // onPressed: () {},
                      onPressed: () {
                        handleSubmit();
                        // uploadfoto();
                      },
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
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text("Sudah Punya Akun? Klik Disini Untuk Login"),
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
}
