import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/api/api_service.dart';
import 'package:myflutix/const/app_color.dart';
import 'package:myflutix/models/runtime.dart';
import 'package:myflutix/models/seats.dart';
import 'package:myflutix/ui/pages/checkoutSucces.dart';
import 'package:myflutix/ui/pages/orderSeat.dart';
import 'package:uuid/uuid.dart';

class checkOut extends StatefulWidget {
  final int movieId;
  final int totalHarga;
  final String tanggalSelect;
  final String jamSelect;
  final Function saveOrderSeat;

  final List<daftarKursi> selectedSeats;

  checkOut(
      {required this.movieId,
      required this.selectedSeats,
      required this.tanggalSelect,
      required this.jamSelect,
      required this.totalHarga,
      required this.saveOrderSeat});

  @override
  State<checkOut> createState() => _checkOutState();
}

class _checkOutState extends State<checkOut> {
  OrderSeat? orderSeatKey;
  RunTime? runtimee;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? id_transaksi;
  int totalnyaBro = 0;
  String judulFilm = '';
  int movieIDD = 0;
  String pilihTanggal = '';
  final ApiService apiService = ApiService();

  // bool isReadmore = false;

  @override
  void initState() {
    getUserID();
    super.initState();
    fetchData();
  }

  // Function to get the user ID
  void getUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<void> fetchData() async {
    try {
      movieIDD = widget.movieId;
      pilihTanggal = widget.jamSelect;
      RunTime runtimes = await apiService.getRuntimeMovies(widget.movieId);
      setState(() {
        runtimee = runtimes;
        judulFilm = runtimee!.judul_film!;
      });
      print(runtimee);
    } catch (e) {
      print('Error: $e');
    }
  }

  String formatDuration(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    return '$hours h $minutes m';
  }

  int extractRating(String ratingString) {
    // Assuming the input format is 'X/5'
    List<String> parts = ratingString.split('/');
    if (parts.length == 2) {
      return int.tryParse(parts[0]) ?? 0;
    }
    return 0;
  }

  String ratingg(double rating) {
    int roundedRating = (rating / 2).round();
    return '$roundedRating/5';
  }

  String mapLanguageCodeToName(String languageCode) {
    Map<String, String> languageMap = {
      'en': 'English',
      // Tambahkan entri untuk kode bahasa lainnya sesuai kebutuhan
    };

    return languageMap[languageCode] ?? 'Unknown';
  }

  OrderSeat orderSeatt = OrderSeat(
    movieId: 0,
    selectedDate: '',
  ); // Sesuaikan dengan kelas dan konstruktor sebenarnya
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("chekout"),
        title: Text(widget.totalHarga.toString()),
        // title: Text("${widget.selectedSeats}"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: -8,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_circle_left_outlined),
                          iconSize: 30,
                          color: primaryColor,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          // 'Checkout',
                          "Selected Seats: ${widget.selectedSeats.map((seat) => seat.nomorKursi).join(', ')}",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  // width: MediaQuery.of(context).size.width * 1,
                  // color: Colors.amber,
                  // 'https://image.tmdb.org/t/p/w500${runtimee?.poster_path}',
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.42,
                        //
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${runtimee?.poster_path}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 1,
                          width: MediaQuery.of(context).size.width * 0.43,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              //Judul Film
                              Container(
                                // height: MediaQuery.of(context).size.height * 0.04,
                                // width: MediaQuery.of(context).size.width * 0.46,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        '${runtimee?.judul_film}',
                                        // 'Avatar : The Way Of Water',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w500,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // genre film
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                // height: MediaQuery.of(context).size.height * 0.04,
                                // width: MediaQuery.of(context).size.width * 0.46,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        runtimee?.genre?.take(2).join(', ') ??
                                            'No Genre',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w500,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                // height: MediaQuery.of(context).size.height * 0.04,
                                // width: MediaQuery.of(context).size.width * 0.46,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        formatDuration(runtimee?.runtime ?? 0),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: <Widget>[
                                      for (int i = 0;
                                          i <
                                              extractRating(ratingg(
                                                  runtimee?.rating ?? 0));
                                          i++)
                                        Icon(
                                          Icons.star,
                                          color: primaryColor,
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
                //bagian sub total
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(children: [
                    //sub total checkout
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: MediaQuery.of(context).size.height * 0.03,
                      // width: MediaQuery.of(context).size.width * 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //sub total checkout
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.03,
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Subtotal',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Wrap(
                                children: <Widget>[
                                  Text(
                                    'IDR ${widget.totalHarga.toString()}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //tax
                      margin: EdgeInsets.only(top: 4),
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Tax',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.451,
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'IDR 5.000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
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
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.03,
                              width: MediaQuery.of(context).size.width * 0.451,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.451,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${widget.totalHarga + 5000}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
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
                  ]),
                ),
                //baris 2
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                          width: MediaQuery.of(context).size.width * 0.451,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Saldo Wallet',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: MediaQuery.of(context).size.width * 0.451,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'IDR 100.000',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
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
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
                  child: InkWell(
                    onTap: () async {
                      // orderSeatt.callSaveSeatStatusToDatabase();
                      //  orderSeatKey?.callSaveSeatStatusToDatabase();
                      Seats tiket = Seats(
                        harga: widget.totalHarga,
                        akun: currentUser!.uid,
                        gambar:
                            'https://image.tmdb.org/t/p/w500${runtimee?.poster_path}',
                        id_transaksi_ticket: Uuid().v4(),
                        waktu: "${widget.tanggalSelect} ${widget.jamSelect}",
                        kursi: widget.selectedSeats
                            .map((seat) => seat.nomorKursi)
                            .toList(),
                        bioskop: "Bioskop ABC",
                        namaFilm: "${runtimee?.judul_film}",
                      );
                      id_transaksi = tiket.id_transaksi_ticket as String?;

                      //save orderseat di firebase                      
                      bool saveSuccess = await widget.saveOrderSeat();

                      // await widget.saveOrderSeat();

                      // ignore: use_build_context_synchronously
                      print("Status Save: $saveSuccess");
                      if (saveSuccess) {
                        tiket.saveToFirebase();
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          // MaterialPageRoute(builder: (context) => checkOutFail()),
                          MaterialPageRoute(
                            builder: (context) => CheckoutSucces(
                              id_transaksi: id_transaksi ?? 'default_value',
                              tanggalSelect: widget.tanggalSelect,
                              jamSelect: widget.jamSelect,
                              judulMovie: judulFilm,
                            ),
                          ),
                        );
                      } else {}
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: ShapeDecoration(
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Confirm Payment',
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
          )
        ],
      ),
    );
  }
}
