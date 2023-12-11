import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myflutix/models/profileUser.dart';
import 'package:myflutix/models/saldo.dart';
import 'package:myflutix/services/SaldoUser.dart';
import 'package:myflutix/ui/pages/WalletTopup.dart';

class MyWalletPage extends StatefulWidget {
  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  ProfileUser? profileKu;
  SaldoUserModels? topUp;
  SaldoUserModels? Pengeluaran;
  User? currentUser;
  List<Ticket> myTickets = [];
  List<Ticket> filteredTickets = [];
  late int saldo;
  late String formattedSaldo;
  late String pengeluaranRP;
  late String topUPRP;
  bool isLoading = true;
  int pengeluarannya = 0;
  int topUPKU = 0;
  saldoService hisrotySaldo = saldoService();
  void initState() {
    getUserID();

    // Ganti inisialisasi myTickets dengan pemanggilan fungsi getTransactionHistory
    getTransactionHistory(currentUser?.uid ?? '').then((tickets) {
      setState(() {
        myTickets = tickets;
        filteredTickets = myTickets;
      });
    });
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      ProfileUser profile = await getProfile(currentUser!.uid);
      SaldoUserModels saldoHistoy = await hisrotySaldo.getSaldo(currentUser!.uid);
      List<Ticket> tickets = await getTransactionHistory(currentUser?.uid ?? '');
      setState(() {
        
        // topUp = saldoHistoy;
        // Pengeluaran = saldoHistoy;
        // pengeluarannya = Pengeluaran!.pengeluaran!;
        // topUPKU = Pengeluaran!.topup!;
        myTickets = tickets;
        filteredTickets = myTickets;
        profileKu = profile;
        saldo = profileKu!.saldo;
        topUPRP = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(saldoHistoy.topup!);
        pengeluaranRP = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(saldoHistoy.pengeluaran!);
        formattedSaldo = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(saldo);
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      isLoading = false;
    }
  }

  // Function untuk mendapatkan ID pengguna
  void getUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  // Function untuk mendapatkan riwayat transaksi berdasarkan ID pengguna
  Future<List<Ticket>> getTransactionHistory(String idAkun) async {
    List<Ticket> transactionHistory = [];

    try {
      // Ambil referensi ke koleksi id_transaksi_ticket dalam dokumen dengan id_akun tertentu
      CollectionReference transactionCollection = FirebaseFirestore.instance
          .collection('akun')
          .doc(idAkun)
          .collection('id_transaksi_ticket');

      // Ambil data dari Firestore
      QuerySnapshot querySnapshot = await transactionCollection.get();

      // Iterasi melalui dokumen-dokumen dalam koleksi
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        print('Raw data dari Firestore: ${doc.data()}');
        try {
          // Ganti pemanggilan fromMap dengan kolom yang sesuai
          Ticket ticket = Ticket.fromMap(doc.data() as Map<String, dynamic>);
          print('Ticket dibuat: $ticket');
          transactionHistory.add(ticket);
        } catch (e) {
          print('Error membuat Ticket: $e');
        }
      }

      print('Riwayat transaksi: $transactionHistory');
      print('ID Akun: $idAkun');
    } catch (error) {
      print('Error mengambil riwayat transaksi: $error');
      throw error;
    }

    return transactionHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dompet Saya'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xFF6558F5),
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: <Widget>[
                        const Text(
                          'Saldo Anda',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        Text(
                          (formattedSaldo = NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp', decimalDigits: 0)
                              .format(saldo ?? 0)),
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  const Text(
                                    'Topup',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  Text(
                                    topUPRP,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1.0,
                              height: 50.0,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                const Text(
                                    'Pengeluaran',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  Text(
                                    pengeluaranRP,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Pindah ke halaman baru di sini
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TopupPage()),
                  );
                },
                child: Container(
                  color: Color(0xFF6558F5),
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    "TOP UP",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Transaksi Terbaru',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            FutureBuilder<List<Ticket>>(
              future: getTransactionHistory(currentUser?.uid ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Menampilkan indikator loading
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Tidak ada riwayat transaksi.');
                } else {
                  // Menampilkan riwayat transaksi
                  List<Ticket> transactionHistory = snapshot.data!;
                  return Container(
                    height: MediaQuery.of(context).size.height *
                        0.6, // Set an arbitrary height
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: transactionHistory.length,
                      itemBuilder: (context, index) {
                        return TransactionCard(
                          ticket: transactionHistory[index],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Ticket {
  final String image;
  final String title;
  final String date;
  final String Bioskop;
  final String time;
  final String id_transaksi;
  final List<dynamic> seatNumber;

  Ticket({
    required this.image,
    required this.Bioskop,
    required this.id_transaksi,
    required this.title,
    required this.date,
    required this.time,
    required this.seatNumber,
  });

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      Bioskop: map['bioskop'] ?? '',
      image: map['gambar'] ?? '',
      title: map['nama_film'] ?? '',
      id_transaksi: map['id_transaksi_ticket'],
      date: map['waktu'] ?? '', // Sesuaikan dengan kolom yang ada di Firestore
      time: map['jam'] ?? '', // Sesuaikan dengan kolom yang ada di Firestore
      seatNumber: map['kursi'] ?? '',
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Ticket ticket; // Tambahkan deklarasi parameter ticket

  TransactionCard({
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.15;

    return Card(
      margin: EdgeInsets.all(8.0),
      color: Color(0xFF6558F5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.network(
              ticket.image, // Gunakan URL gambar dari objek Ticket
              height: imageHeight,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 2,
            child: ListTile(
              title: Text(
                ticket.title,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '${ticket.date}\n${ticket.time}\n${ticket.seatNumber.join(', ')}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
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
