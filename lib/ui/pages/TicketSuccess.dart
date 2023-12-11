import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/const/app_color.dart';
import 'package:myflutix/models/seats.dart';
import 'package:intl/intl.dart';
import 'package:myflutix/ui/pages/buttonNav.dart';

class MovieTicketSuccessScreen extends StatefulWidget {
  @override
  final String id_transaksi;
  final String tanggalSelect;
  final String jamSelect;
  final String judulMovie;
  const MovieTicketSuccessScreen(
      {required this.id_transaksi,
      required this.jamSelect,
      required this.judulMovie,
      required this.tanggalSelect});
  State<MovieTicketSuccessScreen> createState() => _MovieTicketSuccessScreen();
}

class _MovieTicketSuccessScreen extends State<MovieTicketSuccessScreen> {
  User? currentUser;
  late String id_transaksiii;
  late String SelectTanggal;
  late String SelectJam;
  String waktu = "";

  void initState() {
    getUserID();
    super.initState();
    fetchData();
  }

  void getUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
        id_transaksiii = widget.id_transaksi;
        SelectTanggal = widget.tanggalSelect;
        SelectJam = widget.jamSelect;
        waktu = "$SelectTanggal $SelectJam";
      });
    }
  }

  // int akun = 1;
  bool isLoading = true;
  late List<String> dateDanJam;

  String bioskop = "Bioskop ABC";
  List<Seats> transaksi = [];
  Future<Seats> fetchData() async {
    try {
      Seats tiket = await getTransaksiTiket(
        currentUser!.uid,
        id_transaksiii,
        waktu,
        bioskop,
      );
      setState(() {
        transaksi.add(tiket);
        isLoading = false;

        // dateDanJam = transaksi[0].waktu.split(" ");
        // isLoading = false;
        // formattedDate =
        //     DateFormat('y-MMMM-dd').format(DateTime.parse(dateDanJam[0]));
      });
      return tiket;
    } catch (error) {
      // Handle errors here
      print('Error fetching data: $error');
      // print('Nama Film: ${transaksi.isNotEmpty ? transaksi[0].namaFilm : 'Nama Film Tidak Tersedia'}');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : buildTicketContent(),
      ),
    );
  }

  Widget buildTicketContent() {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Ticket',
              style: TextStyle(
                color: Colors.black,
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 300.0,
                    height: 400.0,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.judulMovie,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date & Time:',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Text("Thursday, 25 June",
                              Text(widget.tanggalSelect,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              Text(widget.jamSelect,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Studio :",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              Text("Seat :",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(transaksi[0].bioskop,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              Text(
                                  transaksi.isNotEmpty
                                      ? transaksi[0].kursi.join(', ')
                                      : 'Data Tidak Tersedia',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Order: ",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${transaksi[0].id_transaksi_ticket}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(21, (index) {
                            return Container(
                              width: 10,
                              height: 3,
                              color: Colors.white,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                            );
                          }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 280,
                              child: Image.asset('assets/Frame.png'),
                            )

                            // Image.asset('assets/Frame.png'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.8, // Set the width to 80% of screen width
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Share Ticket",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              primaryColor), // Set the background color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.8, // Set the width to 80% of screen width
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Go to Home",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              primaryColor), // Set the background color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Seats> getTransaksiTiket(String akun, String id_transaksi_ticket,
    String waktu, String bioskop) async {
  // print('ID Film: $bioskop, Hari: $id_transaksi_ticket, Jam: $waktu');
  try {
    DocumentSnapshot tiketSnapshot = await FirebaseFirestore.instance
        .collection('akun')
        .doc(akun.toString())
        .collection('id_transaksi_ticket')
        .doc(id_transaksi_ticket)
        .get();

    if (tiketSnapshot.exists) {
      // Pastikan dokumen ada sebelum mencoba mengambil datanya
      Map<String, dynamic>? tiketData =
          tiketSnapshot.data() as Map<String, dynamic>?;

      if (tiketData != null) {
        return Seats.fromMap(tiketData);
      } else {
        // Handle case where tiketData is null
        throw Exception('Data tiket null');
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
