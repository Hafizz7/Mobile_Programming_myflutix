import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:myflutix/models/profileUser.dart';
import 'package:myflutix/services/SaldoUser.dart';
import 'TopupSuccess.dart';



class TopupPage extends StatefulWidget {
  @override
  _TopupPageState createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  int _customAmount = 0;
  int _selectedAmount = 0;
  int topup = 0;  
  saldoService saldosekarang = saldoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top-Up Wallet"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Text("Amount:"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 56, 56, 56),
                      width: 2.0,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _customAmount = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'IDR', // Placeholder text
                      contentPadding:
                          EdgeInsets.all(8.0), // Padding for the placeholder
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Top-Up Nominal :"),
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // This line disables scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: nominalOptions.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedAmount == nominalOptions[index];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 120.0,
                        height: 80.0,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (isSelected) {
                                // Deselect the button if it's already selected
                                _selectedAmount = 0;
                              } else {
                                // Select the button if it's not selected
                                _selectedAmount = nominalOptions[index];
                              }
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              isSelected ? primaryColor : Colors.white,
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          child: Text("Rp ${NumberFormat("#,##0", "id_ID").format(nominalOptions[index])}"
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Text("Jumlah yang akan ditop-up: Rp ${NumberFormat("#,##0", "id_ID").format(_customAmount + _selectedAmount)}"),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  int totalAmount = _customAmount + _selectedAmount;
                  topUpAndSaveToFirebase(totalAmount);
                  saldosekarang.topUpAndSaveToFirebase(totalAmount, 0);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text("Top-Up"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> topUpAndSaveToFirebase(int totalAmount) async {
    try {
      // Mendapatkan ID pengguna yang aktif
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      // Membaca data profileUser dari Firestore
      DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
          .collection('id_akun')
          .doc(userId)
          .get();

      if (profileSnapshot.exists) {
        // Jika dokumen profileUser ditemukan, update saldo
        ProfileUser profileUser = ProfileUser.fromMap(profileSnapshot.data() as Map<String, dynamic>);

        // Menambahkan totalAmount ke saldo
        int newSaldo = profileUser.saldo + totalAmount;

        // Update saldo di Firestore
        await FirebaseFirestore.instance
            .collection('id_akun')
            .doc(userId)
            .update({'saldo': newSaldo});

        // Menampilkan pesan sukses atau melakukan navigasi ke halaman selanjutnya

        print('Top-up berhasil. Saldo baru: $newSaldo');
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TopupSuccess()),
        );
      } else {
        // Handle jika dokumen profileUser tidak ditemukan
        print('Dokumen profileUser tidak ditemukan');
      }
    } catch (e) {
      // Handle error
      print('Error during top-up: $e');
    }
  }
}

List<int> nominalOptions = [50000, 75000, 100000, 250000, 1000000, 1500000];

Color primaryColor = Colors.blue; // Change this to your primary color
