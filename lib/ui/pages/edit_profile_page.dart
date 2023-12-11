import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/services/getProfileFoto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutix/ui/pages/my_profile_page.dart';

class MyEditProfilePage extends StatelessWidget {
  const MyEditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ProfileService profileService = ProfileService();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  String profileImageUrl = "";
  String imagePath = "";
  User? currentUser;
  String successMessage = "";
  bool isLoading = false;

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
    getUserID();
  }

  void getUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<void> updateProfileDataInFirestore(String imageUrl) async {
    try {
      print('Start updating profile data');
      setState(() {
        isLoading = true;
      });

      if (currentUser != null) {
        DocumentReference userDocRef = FirebaseFirestore.instance
            .collection('id_akun')
            .doc(currentUser!.uid);

        await userDocRef.update({
          'username': namaController.text,
          'fotoProfile': imageUrl,
          'alamat': alamatController.text
        });

        print('Profile data updated successfully');
        setState(() {
          isLoading = false;                        
          successMessage = 'Data profil berhasil diperbarui!';
        });

        print('Data profil berhasil diperbarui di Firestore');
      } else {
        print('Error: currentUser is null');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error updating profile data: $error');
    }
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
      backgroundColor: Colors.white, 
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
                String? imageUrl =
                    await profileService.uploadProfileImage(imagePath);

                if (imageUrl != null) {
                  await updateProfileDataInFirestore(imageUrl);                  
                } else {
                  print('Gagal mengunggah gambar profil');
                }
              },
              child: isLoading
                  ? CircularProgressIndicator() // Efek loading
                  : Text(
                      "Update Now",
                      style: TextStyle(color: Colors.black),
                    ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              successMessage,
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

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
