import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myflutix/api/api_service.dart';
import 'package:myflutix/auth/Login.dart';
import 'package:myflutix/const/app_color.dart';
import 'package:myflutix/models/movie_populer_list.dart';
import 'package:myflutix/models/profileUser.dart';
import 'package:myflutix/models/tiket.dart';
import 'package:myflutix/services/getDataUser.dart';
import 'package:myflutix/ui/pages/movie_detail_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:myflutix/ui/widgets/home_category_button.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService();
  List<Movie> movies = [];
  List<dynamic> id_movies = [];
  List<String> tanggalList = [];
  String? profileImageUrl;
  DataUser datauserku = DataUser();

  // final imagesUrl = [
  //   'barbie_poster.jpeg',
  //   'oppenheimer_poster.jpeg',
  //   'avatar_poster.jpeg',
  // ];

  int activeIndex = 0; // Index for the selected image
  int activePromotionIndex = 0;
  ProfileUser? profileKu;
  User? userAktif;
  void initState() {
    getUserID();
    super.initState();
    fetchData();
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    String? url = await getProfileImageUrl();
    if (url != null) {
      setState(() {
        profileImageUrl = url;
      });
    }
  }

  void clearTanggalList() {
    setState(() {
      tanggalList.clear();
    });
  }

  void getUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userAktif = user;
      });
    }
  }

  Future<void> fetchData() async {
    try {
      final List<Movie> result = await apiService.getPopularMovies();
      ProfileUser profile = await datauserku.getProfile(userAktif!.uid);
      setState(() {
        movies = result;
        profileKu = profile;
        // id_movies = ids;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future<int?> getIdFilmFromFirebase(String waktu, String hari) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('id_film')
          .doc(waktu)
          .collection('tiket')
          .doc(hari)
          .get();

      if (documentSnapshot.exists) {
        // Jika dokumen ditemukan, kembalikan ID film
        return documentSnapshot['id_film'] as int?;
      } else {
        // Jika dokumen tidak ditemukan
        print("Dokumen tidak ditemukan di Firebase2");
        return null;
      }
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

  Future<String?> getProfileImageUrl() async {
    try {
      // Mendapatkan ID pengguna yang aktif
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      // Jika userId tidak null, dapatkan URL gambar dari Firebase Storage
      if (userId != null) {
        Reference storageRef =
            FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
        String imageUrl = await storageRef.getDownloadURL();
        return imageUrl;
      }

      return null;
    } catch (e) {
      print('Error getting profile image URL: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(2, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      // width: 120,
                      height: 120,
                      margin: EdgeInsets.only(left: 2, top: 4),
                      child: CircleAvatar(
                        radius: 21,
                        backgroundImage: NetworkImage(
                            profileImageUrl ?? 'https://iili.io/JIwWrb9.jpg'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            profileKu?.username ?? 'Default Username',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Container(
                            child: Text(profileKu?.saldo.toString() ?? '0'),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Container(
                            child: Text(profileKu?.alamat ?? 'Kosong'),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          InkWell(
                            onTap: () {
                              _logout();
                            },
                            child: Container(
                              child: Icon(
                                Icons.notifications,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 30,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    HomeCustomButton(
                      text: "Now Playing",
                      onPressed: () {},
                    ),
                    HomeCustomButton(
                      text: "Coming Soon",
                      onPressed: () {},
                    ),
                    HomeCustomButton(
                      text: "Trending",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider.builder(
              // itemCount: movies.length,
              itemCount: 5,
              itemBuilder: (context, index, realIndex) {
                if (movies.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final imageUrl =
                    'https://image.tmdb.org/t/p/w500${movies[index].poster_path}';
                return GestureDetector(
                  onTap: () async {
                    clearTanggalList();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    List<String> jamTayang = [
                      '11:00',
                      '13:00',
                      '14:30',
                      '18:00'
                    ];
                    DateTime tanggalSekarang = DateTime.now();

                    for (int i = 0; i < 3; i++) {
                      DateTime tanggal = tanggalSekarang.add(Duration(days: i));
                      String formattedDate =
                          DateFormat('dd MMM').format(tanggal);
                      tanggalList.add(formattedDate);
                    }
                    // List<String> hariList = [
                    //   'hari1',
                    //   'hari2',
                    //   'hari3',
                    //   'hari4'
                    // ];
                    int idFilm = movies[index].id;
                    print(idFilm);
                    for (String hari in tanggalList) {
                      for (String jam in jamTayang) {
                        // Check if the document already exists
                        int? existingIdFilm =
                            await getIdFilmFromFirebase(jam, hari);

                        if (existingIdFilm == null) {
                          // Document doesn't exist, create a new one
                          Tiket tiketToSave = Tiket(
                            id_film: idFilm,
                            waktu: jam,
                            harga: 75000,
                            kursi: Tiket.generateDefaultSeats(),
                            status: List.filled(30, false),
                            hari: hari,
                          );

                          tiketToSave.saveToFirebase();
                        } else {
                          print('Data Sudah Ada');
                        }
                      }
                    }

                    // Close the loading indicator
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    //  clearTanggalList();

                    // Navigate to the movie detail page
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyMovieDetailPage(
                          movieId: movies[index].id,
                          tanggalList: tanggalList,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 200.0,
                        height: 300.0,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 350,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildIndicator(),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider.builder(
              itemCount: 3, // Number of promotion containers
              itemBuilder: (context, index, realIndex) {
                // Replace with the actual PromotionContainer widget
                // return PromotionContainer();
                return Container(
                  width: 300,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                  ),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
              options: CarouselOptions(
                height: 100, // Adjust the height as needed
                enableInfiniteScroll: false, // To prevent infinite scrolling
                onPageChanged: (index, reason) {
                  setState(() {
                    activePromotionIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            buildPromotionIndicator(),
            Container()
          ],
        ),
      ),
    );
  }

  // Widget buildImage(String imageUrl, int index) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10),
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 5),
  //       decoration: ShapeDecoration(
  //         image: DecorationImage(
  //           image: AssetImage(imageUrl),
  //           fit: BoxFit.contain,
  //         ),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: movies.length,
        effect: ExpandingDotsEffect(
          activeDotColor: primaryColor,
          dotColor: Colors.grey,
          dotHeight: 8,
          dotWidth: 8,
        ),
      );

  Widget buildPromotionIndicator() => AnimatedSmoothIndicator(
        activeIndex: activePromotionIndex, // Use your active index variable
        count: 3, // Set the total count of promotion items
        effect: ExpandingDotsEffect(
          activeDotColor: primaryColor, // Customize the active dot color
          dotColor: Colors.grey, // Customize the inactive dot color
          dotHeight: 8, // Customize the dot height
          dotWidth: 8, // Customize the dot width
        ),
      );
}

// Future<ProfileUser> getProfile(String id_akun) async {
//   try {
//     DocumentSnapshot profileUserr = await FirebaseFirestore.instance
//         .collection('id_akun')
//         .doc(id_akun)
//         .get();

//     if (profileUserr.exists) {
//       // Pastikan dokumen ada sebelum mencoba mengambil datanya
//       Map<String, dynamic>? profileUser =
//           profileUserr.data() as Map<String, dynamic>?;

//       if (profileUser != null) {
//         return ProfileUser.fromMap(profileUser);
//       } else {
//         // Handle case where profileUser is null
//         throw Exception('Data Profile null');
//       }
//     } else {
//       // Handle case where the document doesn't exist
//       throw Exception('Dokumen tiket tidak ditemukan');
//     }
//   } catch (error) {
//     print('Error fetching tiket: $error');
//     // Handle error as needed
//     throw error;
//   }
// }

List<String> imageUrls = [
  'https://iili.io/JINDsiF.png',
  'https://iili.io/JINDQKg.png',
  'https://iili.io/JINDZla.png',
];
