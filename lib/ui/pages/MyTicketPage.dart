import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myflutix/ui/pages/TicketSuccess.dart';

class MyTicketPage extends StatefulWidget {
  @override
  _MyTicketPageState createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  User? currentUser;
  List<Ticket> myTickets = [];

  List<Ticket> filteredTickets = [];

  TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    getUserID();

    // Ganti inisialisasi myTickets dengan pemanggilan fungsi getTransactionHistory
    getTransactionHistory(currentUser?.uid ?? '').then((tickets) {
      setState(() {
        myTickets = tickets;
        filteredTickets = myTickets;
      });
    });

    super.initState();
  }

  Future<void> fetchData() async {
    try {
      List<Ticket> tickets =
          await getTransactionHistory(currentUser?.uid ?? '');
      setState(() {
        myTickets = tickets;
        filteredTickets = myTickets;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
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

  // Function to get transaction history based on user ID
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
        print('Raw data from Firestore: ${doc.data()}');
        try {
          // Ganti pemanggilan fromMap dengan kolom yang sesuai
          Ticket ticket = Ticket.fromMap(doc.data() as Map<String, dynamic>);
          print('Ticket created: $ticket');
          transactionHistory.add(ticket);
        } catch (e) {
          print('Error creating Ticket: $e');
        }
      }

      print('Transaction history: $transactionHistory');
      print('ID Akun: $idAkun');
    } catch (error) {
      print('Error fetching transaction history: $error');
      throw error;
    }

    return transactionHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tickets'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Container(
// child: myTickets,
            child: Text(currentUser?.uid ?? 'Not logged in'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredTickets = myTickets
                      .where((ticket) => ticket.title
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          FutureBuilder<List<Ticket>>(
            future: getTransactionHistory(currentUser?.uid ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No transaction history found.');
              } else {
                // Display the transaction history
                List<Ticket> transactionHistory = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: transactionHistory.length,
                    itemBuilder: (context, index) {
                      return TicketCard(ticket: transactionHistory[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
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

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.2;

    return GestureDetector(
      onTap: () {        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieTicketSuccessScreen(
              id_transaksi: ticket.id_transaksi,
              tanggalSelect: ticket.date,
              judulMovie: ticket.title,
              jamSelect: ticket.time,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        color: Color(0xFF6558F5), 
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.network(
                ticket.image,
                height: imageHeight,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(
                  ticket.title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      ticket.date,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      ticket.Bioskop, // Tambahkan informasi Bioskop di sini
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      ticket.seatNumber.join(', '),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                // trailing: ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => MovieTicketSuccessScreen(
                //           id_transaksi: ticket.id_transaksi,
                //           tanggalSelect: ticket.date,
                //           jamSelect: ticket.time,
                //         ),
                //       ),
                //     );
                //   },
                //   child: Text('Details'),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
