import 'package:cloud_firestore/cloud_firestore.dart';

class SaldoUserModels {
  
  int? pengeluaran;
  int? topup;  
  String? id_akun;

  SaldoUserModels({
    required this.pengeluaran,    
    required this.topup,
    required this.id_akun,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'pengeluaran' : pengeluaran,
      'topup': topup,
      'id_akun': id_akun,      
    };
  }

  factory SaldoUserModels.fromMap(Map<String, dynamic> map) {
    return SaldoUserModels(      
      id_akun: map['id_akun'],
      topup: map['topup'],
      pengeluaran: map['pengeluaran'],      
    );
  }

  void saveToFirebase() {
    FirebaseFirestore.instance
        .collection('Saldo')
        .doc(id_akun)        
        .set(toMap())
        .then((_) {
      print("Tiket berhasil disimpan di Firebase");
    }).catchError((error) {
      print("Error: $error");
    });
  }
}