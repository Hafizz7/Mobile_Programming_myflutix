import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myflutix/models/saldo.dart';

class saldoService{
  Future<void> topUpAndSaveToFirebase(int topup, int pengeluarakun) async {
    try {      
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      // Membaca data profileUser dari Firestore
      DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
          .collection('Saldo')
          .doc(userId)
          .get();

      if (profileSnapshot.exists) {
        // Jika dokumen profileUser ditemukan, update saldo
        SaldoUserModels saldoKu = SaldoUserModels.fromMap(profileSnapshot.data() as Map<String, dynamic>);

        // Menambahkan totalAmount ke saldo
        int topUp = saldoKu.topup! + topup;
        int pengeluaran = saldoKu.pengeluaran! + pengeluarakun;

        // Update saldo di Firestore
        await FirebaseFirestore.instance
            .collection('Saldo')
            .doc(userId)
            .update({'topup': topUp, 'pengeluaran' : pengeluaran});
                
      } else {
        // Handle jika dokumen profileUser tidak ditemukan
        print('Dokumen profileUser tidak ditemukan');
      }
    } catch (e) {
      // Handle error
      print('Error during top-up: $e');
    }
  }
  Future<SaldoUserModels> getSaldo(String id_akun) async {
  try {
    DocumentSnapshot profileUserr = await FirebaseFirestore.instance
        .collection('Saldo')
        .doc(id_akun)
        .get();

    if (profileUserr.exists) {
      // Pastikan dokumen ada sebelum mencoba mengambil datanya
      Map<String, dynamic>? profileUser =
          profileUserr.data() as Map<String, dynamic>?;

      if (profileUser != null) {
        return SaldoUserModels.fromMap(profileUser);
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
}