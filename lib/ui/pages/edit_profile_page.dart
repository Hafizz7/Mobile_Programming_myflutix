import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myflutix/services/getProfileFoto.dart';
import 'package:image_picker/image_picker.dart';

class MyEditProfilePage extends StatelessWidget {
  const MyEditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: EditProfilePage(),
    );
  }
}
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ProfileService profileService = ProfileService();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  String profileImageUrl = "";
  String imagePath = ""; 

  // String? profileImageUrl;

  // Future<void> loadProfileImage() async {
  //   String? url = await ambilFoto.getProfileImageUrl();
  //   if (url != null) {
  //     setState(() {
  //       profileImageUrl = url;
  //     });
  //   }
  
  Future<void> loadProfileImage() async {
    String? url = await profileService.getProfileImageUrl();
    if (url != null) {
      setState(() {
        profileImageUrl = url;
      });
    }
  }
  void initState() {
    super.initState();
    loadProfileImage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(250),
                      image: DecorationImage(
                        image: imagePath.isEmpty
                            ? NetworkImage(profileImageUrl)
                            : FileImage(File(imagePath))
                                as ImageProvider<Object>,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 125,
                        width: 140,
                      ),
                      IconButton(
                        onPressed: () async {
                          // Pilih sumber gambar dari galeri
                          final pickedFile = await ImagePicker()
                              .getImage(source: ImageSource.gallery);

                          if (pickedFile != null) {
                            setState(() {
                              imagePath = pickedFile.path;
                            });
                          }
                        },
                        icon: Icon(Icons.add),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            buildTextField(namaController, 'Full Name', Icons.person),
            SizedBox(
              height: 20,
            ),
            buildTextField(alamatController, 'Alamat', Icons.mail),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Mendapatkan URL gambar dari Firebase Storage
                String? imageUrl =
                    await profileService.uploadProfileImage(imagePath);

                // Lakukan tindakan yang sesuai dengan URL gambar, misalnya memperbarui data profil di Firestore
                if (imageUrl != null) {
                  // Contoh: Memperbarui data profil pengguna di Firestore
                  await updateProfileDataInFirestore(imageUrl);

                  // Kembali ke halaman sebelumnya setelah berhasil memperbarui
                  Navigator.pop(context);
                } else {
                  // Gagal mengunggah gambar profil
                  print('Gagal mengunggah gambar profil');
                }
              },
              child: Text(
                "Update Now",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Metode untuk memperbarui data profil pengguna di Firestore
  Future<void> updateProfileDataInFirestore(String imageUrl) async {
    // Gantilah dengan logika untuk memperbarui data profil pengguna di Firestore
    // (Misalnya menggunakan package cloud_firestore)
  }

  // Widget untuk membangun TextField yang seragam
  Widget buildTextField(
      TextEditingController controller, String hintText, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 233, 233),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              icon: Icon(icon),
            ),
          ),
        ),
      ],
    );
  }
}
