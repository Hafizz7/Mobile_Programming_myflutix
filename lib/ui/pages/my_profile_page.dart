import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/auth/Login.dart';
import 'package:myflutix/models/profileUser.dart';
import 'package:myflutix/services/getProfileFoto.dart';
import 'package:myflutix/ui/pages/edit_profile_page.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: profile(),
    );
  }
}

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  ProfileService ambilFoto = ProfileService();
  late String id;
  User? userAktif;
  late Future<ProfileUser> profileUser2;
  String? profileImageUrl;

  Future<void> loadProfileImage() async {
    String? url = await ambilFoto.getProfileImageUrl();
    if (url != null) {
      setState(() {
        profileImageUrl = url;
      });
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  void initState() {
    getUserID();
    loadProfileImage();
    super.initState();
    id = userAktif!.uid;
    profileUser2 = getProfile(id);
  }

  void getUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userAktif = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          // userAktif!.uid,
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: profileUser2,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Tampilkan widget loading jika data masih diambil
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Tampilkan pesan kesalahan jika terjadi kesalahan
              return Text('Error: ${snapshot.error}');
            } else {
              // Tampilkan data profil setelah berhasil diambil
              ProfileUser userProfile = snapshot.data as ProfileUser;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(15)),
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 25,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            image: NetworkImage(profileImageUrl ??
                                'https://iili.io/ytxAUx.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.all(9)),
                              Text(
                                // "John Doe"                                ,
                                userProfile.username,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                width: 75,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyEditProfilePage(),
                                      ));
                                },
                                icon: Icon(Icons.mode_edit),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(userProfile.email),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text("Dasboard"),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.wallet),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            "My Wallet",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.language),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            "Change Language",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.help_center),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            "Help Center",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.star),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            "Rate Flutix App",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "My Account",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Switch to Other Account",
                        style:
                            TextStyle(color: Color.fromARGB(255, 29, 5, 243)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _logout();
                          // Setelah logout, navigasi kembali ke halaman login atau halaman lain yang sesuai
                          // Contoh: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Log Out",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

Future<ProfileUser> getProfile(String id_akun) async {
  try {
    DocumentSnapshot profileUserr = await FirebaseFirestore.instance
        .collection('id_akun')
        .doc(id_akun)
        .get();

    if (profileUserr.exists) {
      // Pastikan dokumen ada sebelum mencoba mengambil datanya
      Map<String, dynamic>? profileUser =
          profileUserr.data() as Map<String, dynamic>?;

      if (profileUser != null) {
        return ProfileUser.fromMap(profileUser);
      } else {
        // Handle case where profileUser is null
        throw Exception('Data Profile null');
      }
    } else {
      // Handle case where the document doesn't exist
      throw Exception('Dokumen tiket tidak ditemukan');
    }
  } catch (error) {
    print('Error fetching tiket: $error');
    // Handle error as needed
    throw error;
  }
}
