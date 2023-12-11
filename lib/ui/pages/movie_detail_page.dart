import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/api/api_service.dart';
import 'package:myflutix/const/app_color.dart';
import 'package:myflutix/models/cast.dart';
import 'package:myflutix/models/movie_populer_list.dart';
import 'package:myflutix/models/runtime.dart';
import 'package:myflutix/models/tiket.dart';
import 'package:myflutix/ui/pages/orderSeat.dart';

class MyMovieDetailPage extends StatefulWidget {
  final int movieId;
  List<String> tanggalList = [];
  MyMovieDetailPage({required this.movieId, required this.tanggalList});

  @override
  State<MyMovieDetailPage> createState() => _MyMovieDetailPageState();
}

class _MyMovieDetailPageState extends State<MyMovieDetailPage> {
  Movie? movies;
  bool isSelected = false;
  List<Casttt> castlistt = [];
  RunTime? runtimee;
  final ApiService apiService = ApiService();
  bool isReadmore = false;
  List<String> dateList = [];
  String selectedDate = "";
  bool isLoading = true;
  //untuk hari tiket

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<Movie> result = await apiService.getPopularMovies();
      List<Casttt> castList = await apiService.getDetailMovie(widget.movieId);
      RunTime runtimes = await apiService.getRuntimeMovies(widget.movieId);

      final selectedMovie =
          result.firstWhere((movie) => movie.id == widget.movieId);
      final QuerySnapshot tiketSnapshot = await FirebaseFirestore.instance
          .collection('id_film')
          .doc(widget.movieId.toString())
          .collection('tiket')
          .get();

// Cek apakah ada dokumen yang ditemukan
      if (tiketSnapshot.docs.isNotEmpty) {
        // Melakukan looping melalui semua dokumen
        for (final doc in tiketSnapshot.docs) {
          // Mengakses data dari setiap dokumen
          final String id = doc.id;
          final Map<String, dynamic>? tiketData =
              doc.data() as Map<String, dynamic>?;

          // Cetak data dokumen
          print('ID Dokumen: $id');
          print('Data Tiket: $tiketData');

          // Cek apakah ada subkoleksi "jam" di setiap dokumen
          final QuerySnapshot jamSnapshot = await FirebaseFirestore.instance
              .collection('id_film')
              .doc(widget.movieId.toString())
              .collection('tiket')
              .doc(id)
              .collection('jam')
              .get();

          // Melakukan looping melalui semua dokumen subkoleksi "jam"
          for (final jamDoc in jamSnapshot.docs) {
            // Mengakses data dari setiap dokumen subkoleksi "jam"
            final String jamId = jamDoc.id;
            final Map<String, dynamic>? jamData =
                jamDoc.data() as Map<String, dynamic>?;

            // Cetak data dokumen subkoleksi "jam"
            print('ID Jam Dokumen: $jamId');
            print('Data Jam: $jamData');
          }
        }
      } else {
        // Tidak ada dokumen yang ditemukan
        print('Tidak ada dokumen tiket untuk film dengan ID ${widget.movieId}');
      }

      print('ID Film: ${widget.movieId.toString()}');
      print(
          'Tiket Collection Path: ${FirebaseFirestore.instance.collection('id_film').doc(widget.movieId.toString()).collection('tiket').path}');

      setState(() {
        runtimee = runtimes;
        castlistt = castList;
        movies = selectedMovie;
        dateList = widget.tanggalList;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  String formatDuration(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    return '$hours h $minutes m';
  }

  String ratingg(double rating) {
    int roundedRating = (rating / 2).round();

    return '$roundedRating/5'; // Format it as X/5
  }

  String mapLanguageCodeToName(String languageCode) {
    Map<String, String> languageMap = {
      'en': 'English',
      // Tambahkan entri untuk kode bahasa lainnya sesuai kebutuhan
    };

    return languageMap[languageCode] ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(        
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : detailPage(),
      ),
    );
  }

  Widget detailPage() {
    return Scaffold(
      body: ListView(
        children: <Widget>[          
          Container(
            width: MediaQuery.of(context).size.width,
            height: 235,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.0, 0.50, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movies?.poster_path ?? ''}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.watch_later_outlined),
                Text("${formatDuration(runtimee?.runtime ?? 0)}"),
                SizedBox(width: 15),
                Icon(Icons.star_border),
                Text("${ratingg(runtimee?.rating ?? 0)}"),
                SizedBox(width: 15),
                Text(runtimee?.genre?.take(2).join(', ') ?? 'No Genre'),
                SizedBox(width: 15),
                // Text("English"),

                Text("${mapLanguageCodeToName(runtimee?.bahasa ?? '')}"),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '${movies?.overview}',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              maxLines: (isReadmore ? null : 3),
              overflow:
                  (isReadmore ? TextOverflow.visible : TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(height: 1.5),
          InkWell(
            onTap: () {
              setState(() {
                isReadmore = !isReadmore;
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                (isReadmore ? 'Read Less' : 'Read More'),
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 11,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const Text(
            'Cast',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: castlistt.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 55,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${castlistt[index].profile_path ?? ''}',
                        ),
                        fit: BoxFit.contain,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
          const Text(
            'Select Place & Date',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'SCP XXI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: dateList.map((date) => DateBox(date)).toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: ShapeDecoration(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSeat(
                            movieId: widget.movieId,
                            selectedDate: selectedDate.toString()),
                      ),
                    );
                  },
                  child: Text(
                    'Get Reservation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget DateBox(String date) {
    bool isSelected = selectedDate == date;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          // Tambahkan logika atau tindakan yang diinginkan ketika kotak tanggal diketuk di sini
          print('Selected date: $date');
          setState(() {
            selectedDate = date;
          });
          navigateToOrderSeat(
              date); // Panggil fungsi untuk navigasi ke OrderSeat
        },
        child: Container(
          width: 60,
          height: 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color.fromARGB(255, 205, 243, 33)
                      : Colors.white, // Ganti warna saat dipilih
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToOrderSeat(String selectedDate) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         OrderSeat(movieId: widget.movieId, selectedDate: selectedDate),
    //   ),
    // );
  }
}
