import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/const/app_color.dart';
import 'package:myflutix/models/profileUser.dart';
import 'package:myflutix/models/tiket.dart';
import 'package:myflutix/services/SaldoUser.dart';
import 'package:myflutix/services/getDataUser.dart';
import 'package:myflutix/ui/pages/checkout.dart';

class OrderSeat extends StatefulWidget {
  final int movieId;
  final String selectedDate;

  OrderSeat({required this.movieId, required this.selectedDate});

  @override
  State<OrderSeat> createState() => _OrderSeatState();
}

class _OrderSeatState extends State<OrderSeat> {
  int selectedJamIndex = -1;
  int totalHarga = 0;
  late String selectedJam;
  // String waktu = '27_11:00';
  int saldoWallet = 0;
  DataUser dataku = DataUser();
  saldoService riwayatSaldo = saldoService();
  User? userAktif;
  List<daftarKursi> selectedSeats = []; // untuk menyimpan data yg dipilih
  late List<daftarKursi> daftarkursiku;
  late int idFilm;
  ProfileUser? profileKu;
  // String hari = '01 Dec'; // Sesuaikan dengan hari yang sesuai
  String jam = '13.00'; // Sesuaikan dengan jam yang sesuai

  @override
  void initState() {
    super.initState();
    idFilm = widget.movieId;
    daftarkursiku = [];
    fetchData();
    getUserID();
  }

  int calculateTotalHarga() {
    int totalHarga = 0;

    for (int i = 0; i < daftarkursiku.length; i++) {
      if (daftarkursiku[i].slect) {
        totalHarga += daftarkursiku[i].harga;
      }
    }

    return totalHarga;
  }

  void getUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userAktif = user;
      });
    }
  }

  void fetchData() async {
    ProfileUser profile = await dataku.getProfile(userAktif!.uid);
    if (jam.isNotEmpty) {
      Tiket tiket =
          await getTiketFromFirebase(idFilm, widget.selectedDate, jam);

      setState(() {
        profileKu = profile;
        saldoWallet = profileKu?.saldo ?? 0;
        daftarkursiku = tiket.kursi.map((nomorKursi) {
          int index = tiket.kursi.indexOf(nomorKursi.toString());
          bool status = index != -1 ? tiket.status[index] : false;
          return daftarKursi(
              nomorKursi: nomorKursi.toString(),
              statusKursi: status,
              idFilm: widget.movieId,
              hari: widget.selectedDate,
              jam: jam,
              harga: tiket.harga);
        }).toList();
      });
    }
  }

  List<jamNonton> jamTonton = [
    jamNonton(jam: "11:00"),
    jamNonton(jam: "13:00"),
    jamNonton(jam: "14:30"),
    jamNonton(jam: "18:00"),
  ];

  Future<bool> saveSeatStatusToDatabase() async {
    totalHarga = calculateTotalHarga();
    if (jam.isNotEmpty) {
      // Memeriksa apakah saldo mencukupi
      if (saldoWallet >= totalHarga) {
        // Saldo cukup, lanjutkan dengan penyimpanan status kursi
        Tiket tiket =
            await getTiketFromFirebase(idFilm, widget.selectedDate, jam);

        List<String> updatedKursiList = [];
        List<bool> updatedStatusList = [];

        for (int i = 0; i < daftarkursiku.length; i++) {
          updatedKursiList.add(daftarkursiku[i].nomorKursi);
          updatedStatusList.add(daftarkursiku[i].statusKursi);
          // Jika kursi dipilih, tambahkan harga tiket ke total
          // if (daftarkursiku[i].statusKursi) {
          //   totalHarga += daftarkursiku[i].harga;
          // }
        }

        tiket.kursi = updatedKursiList;
        tiket.status = updatedStatusList;

        try {
          await FirebaseFirestore.instance
              .collection('id_film')
              .doc(widget.movieId.toString())
              .collection('tiket')
              .doc(widget.selectedDate)
              .collection('jam')
              .doc(jam)
              .set(tiket.toMap());
          print('Status kursi berhasil disimpan di Firebase.');

          totalHarga = totalHarga + 5000;
          selectedJam = jam;
          print('Total Harga Tiket: $totalHarga');
          print('Saldo Wallet: $saldoWallet');
          int SaldoSekrang = saldoWallet - totalHarga;
          // Lakukan pengurangan saldo di sini

          dataku.topUpAndSaveToFirebase(SaldoSekrang);
          print("Saldo AKhir: $SaldoSekrang");
          riwayatSaldo.topUpAndSaveToFirebase(0, totalHarga);
          return true; // Indicates a successful payment
        } catch (error) {
          print('Error saving seat status to Firebase: $error');
          return false; // Indicates a failed payment
        }
      } else {
        // Saldo tidak mencukupi
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Checkout Gagal'),
              content: Text('Saldo tidak mencukupi untuk pembelian tiket.'),
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
        return false; // Indicates a failed payment
      }
    }

    // Indicates a failed payment (for other cases)
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time & Seat'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_outlined, size: 40,color: primaryColor,), 
          onPressed: () {          
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.04,
              //   width: MediaQuery.of(context).size.width * 1,
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       Positioned(
              //         left: -8,
              //         child: IconButton(
              //           onPressed: () {},
              //           icon: Icon(Icons.arrow_circle_left_outlined),
              //           iconSize: 30,
              //           color: primaryColor,
              //         ),
              //       ),
              //       Align(
              //         alignment: Alignment.center,
              //         child: Text(
              //           // 'Select Time & Seat',
              //           // widget.selectedDate,
              //           // "${profileKu?.saldo ?? '0'}",
              //           "$saldoWallet",
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontFamily: 'Raleway',
              //             fontWeight: FontWeight.w500,
              //             height: 0,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/Vector 66.png"),
                  ),
                ),
              ),
              //membuat kursi
              Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 0.99,
                  ),
                  itemCount: daftarkursiku.length,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        setState(() {
                          if (daftarkursiku[i].statusKursi) {
                            // Jika status kursi sudah true (diambil), maka izinkan untuk di-unselect
                            daftarkursiku[i].slect = !daftarkursiku[i].slect;
                            daftarkursiku[i].statusKursi =
                                !daftarkursiku[i].statusKursi;

                            if (daftarkursiku[i].slect) {
                              selectedSeats.add(daftarkursiku[i]);
                            } else {
                              selectedSeats.remove(daftarkursiku[i]);
                            }
                          } else if (!daftarkursiku[i].statusKursi) {
                            // Jika status kursi belum diambil, maka izinkan untuk di-select
                            daftarkursiku[i].slect = !daftarkursiku[i].slect;
                            daftarkursiku[i].statusKursi =
                                !daftarkursiku[i].statusKursi;

                            if (daftarkursiku[i].slect) {
                              selectedSeats.add(daftarkursiku[i]);
                            } else {
                              selectedSeats.remove(daftarkursiku[i]);
                            }
                          } else {
                            print('Kursi sudah dipilih atau sudah diambil.');
                          }
                        });
                      },
                      child: buildContentItem(daftarkursiku[i]),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Available',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: Color(0xFF0E1629),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Reserved',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: primaryColor,
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Selected',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.26,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                  ),
                  itemCount: jamTonton.length,
                  itemBuilder: (_, i) {
                    final isItemSelected = selectedJamIndex == i;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (isItemSelected) {
                            // Jika item sudah dipilih, batalkan pemilihan
                            selectedJamIndex = -1;
                            jam = '';
                          } else {
                            // Jika item belum dipilih, pilih item ini dan batalkan pemilihan yang sebelumnya
                            selectedJamIndex = i;
                            jam = jamTonton[i].jam;
                            selectedJam = jam;
                            print("Jam$jam");
                            print("JamBUU$selectedJam");
                          }
                        });
                        if (jam.isNotEmpty) {
                          fetchData();
                        }
                      },
                      child: buildContentItems(jamTonton[i],
                          isItemSelected: isItemSelected),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
                child: InkWell(
                  onTap: () {
                    // saveSeatStatusToDatabase();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => checkOut(
                          movieId: widget.movieId,
                          selectedSeats: selectedSeats,
                          tanggalSelect: widget.selectedDate,
                          jamSelect: selectedJam,
                          totalHarga: calculateTotalHarga(),
                          saveOrderSeat: saveSeatStatusToDatabase,
                        ),
                      ),
                    );
                    // Add any additional logic you want to perform when the ticket is bought
                    setState(() {});
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: ShapeDecoration(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Buy Ticket IDR ${calculateTotalHarga()}',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildContentItems(jamNonton item, {bool isItemSelected = false}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        color: isItemSelected ? primaryColor : Color(0xFFD9D9D9),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '${item.jam}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      ),
    ),
  );
}

class daftarKursi {
  bool slect = false;
  final String nomorKursi;
  bool statusKursi;
  final int idFilm;
  final String hari;
  final String jam;
  final int harga;

  daftarKursi({
    required this.nomorKursi,
    required this.statusKursi,
    required this.idFilm,
    required this.harga,
    required this.hari,
    required this.jam,
  });

  Future<void> toggleEnlarged() async {
    try {
      DocumentSnapshot tiketSnapshot = await FirebaseFirestore.instance
          .collection('id_film')
          .doc(idFilm.toString())
          .collection('tiket')
          .doc(hari)
          .collection('jam')
          .doc(jam)
          .get();

      Map<String, dynamic>? tiketData =
          tiketSnapshot.data() as Map<String, dynamic>?;

      if (tiketData != null &&
          tiketData['kursi'] is List &&
          tiketData['status'] is List) {
        List<String> kursiList = List<String>.from(tiketData['kursi']);
        List<bool> statusList = List<bool>.from(tiketData['status']);
        int index = kursiList.indexOf(nomorKursi);
        print('Before toggle - slect: $slect, statusKursi: $statusKursi');

        if (index != -1 && index < statusList.length) {
          if (!statusList[index] && !slect) {
            if (!statusKursi) {
              slect = true;
              statusList[index] = true;
              statusKursi = statusList[index];
            } else {
              print('Kursi sudah diambil.');
            }
          } else {
            print('Kursi sudah dipilih atau sudah diambil.');
          }
        }
      }
    } catch (error) {
      print("Kursi Nulll");
      print('Error toggling seat status: $error');
    }
  }

  factory daftarKursi.fromMap(Map<String, dynamic> map) {
    return daftarKursi(
      nomorKursi: map['kursi'] ?? '',
      statusKursi: map['status'] ?? false,
      idFilm: map['id_film'] ?? 0,
      hari: map['hari'] ?? '',
      jam: map['waktu'] ?? '',
      harga: map['harga'] ?? 0,
    );
  }
}

Widget buildContentItem(daftarKursi item) {
  Color kursiColor = Colors.white;
  Color textColor = Colors.black;

  //  print('Item selected: ${item.slect}');

  if (item.slect) {
    kursiColor = Color(0xFF6558F5);
    textColor = Colors.white;
  } else if (item.statusKursi) {
    kursiColor = const Color(0xFF0E1629);
    textColor = const Color.fromARGB(255, 255, 255, 255);
  } else {
    kursiColor = const Color.fromARGB(255, 184, 183, 183);
  }
  print('slect: ${item.slect}, statusKursi: ${item.statusKursi}');

  return Container(
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: GestureDetector(
        onTap: () {
          item.toggleEnlarged();
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: ShapeDecoration(
            color: kursiColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "${item.nomorKursi}",
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class jamNonton {
  final String jam;

  jamNonton({required this.jam});
}

Future<Tiket> getTiketFromFirebase(int idFilm, String hari, String jam) async {
  print('ID Film: $idFilm, Hari: $hari, Jam: $jam');
  try {
    DocumentSnapshot tiketSnapshot = await FirebaseFirestore.instance
        .collection('id_film')
        .doc(idFilm.toString())
        .collection('tiket')
        .doc(hari)
        .collection('jam')
        .doc(jam)
        .get();

    if (tiketSnapshot.exists) {
      // Pastikan dokumen ada sebelum mencoba mengambil datanya
      Map<String, dynamic>? tiketData =
          tiketSnapshot.data() as Map<String, dynamic>?;

      if (tiketData != null) {
        return Tiket.fromMap(tiketData);
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
