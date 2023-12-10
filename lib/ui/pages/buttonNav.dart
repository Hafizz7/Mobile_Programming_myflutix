import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/auth/Login.dart';
import 'package:myflutix/auth/auth.dart';
import 'package:myflutix/ui/pages/MyTicketPage.dart';
import 'package:myflutix/ui/pages/MyWallet.dart';
import 'package:myflutix/ui/pages/home_page.dart';
import 'package:myflutix/ui/pages/my_profile_page.dart'; // Import class Auth

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen();

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;
  final Auth _auth = Auth(); // Membuat instance dari class Auth

  final List<Widget> screens = [
    MyHomePage(),
    MyTicketPage(),
    MyWalletPage(),
    MyProfilePage(),
    
  ];
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      // Menggunakan FutureBuilder untuk mengecek status otentikasi
      future: _auth.isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan loading spinner jika masih menunggu hasil otentikasi
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data == true) {
          // Jika pengguna sudah login, tampilkan BottomNavScreen
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: CupertinoTabBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.heart),
                  label: "Favorites",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.add),
                  label: "Add",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  label: "About",
                ),
              ],
              activeColor: Theme.of(context).iconTheme.color,
            ),
          );
        } else {
          // Jika pengguna belum login, arahkan ke halaman login
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text("Login"),
              ),
            ),
          );
        }
      },
    );
  }
}
