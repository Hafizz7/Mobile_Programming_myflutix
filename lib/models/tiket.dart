import 'package:cloud_firestore/cloud_firestore.dart';

class Tiket {
  int id_film;
  String hari;
  String waktu;
  List<String> kursi;
  int harga;
  List<bool> status;

  Tiket({
    required this.id_film,
    required this.waktu,
    required this.kursi,
    required this.harga,
    required this.status,
    required this.hari,
  });

  Map<String, dynamic> toMap() {
    return {
      'waktu': waktu,
      'hari': hari,
      'kursi': kursi,
      'harga': harga,
      'status': status,
      'id_film': id_film,
    };
  }

  factory Tiket.fromMap(Map<String, dynamic> map) {
    return Tiket(
      id_film: map['id_film'],
      hari: map['hari'],
      waktu: map['waktu'],
      kursi: List<String>.from(map['kursi']),
      harga: map['harga'],
      status: List<bool>.from(map['status']),
    );
  }

  static List<String> generateDefaultSeats() {
    List<String> seats = [];
    for (int row = 1; row <= 5; row++) {
      for (int seat = 1; seat <= 6; seat++) {
        if (row == 1) {
          seats.add("A$seat");
        } else {
          seats.add("${String.fromCharCode(64 + row)}$seat");
        }
      }
    }
    return seats.map((seat) => '$seat').toList();
  }

  void saveToFirebase() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('id_film')
        .doc(id_film.toString())
        .collection('tiket')
        .doc(hari)
        .collection('jam')
        .doc(waktu)
        .get();

    if (!documentSnapshot.exists) {
      // Document doesn't exist, save the Tiket
      FirebaseFirestore.instance
          .collection('id_film')
          .doc(id_film.toString())
          .collection('tiket')
          .doc(hari)
          .collection('jam')
          .doc(waktu)
          .set(toMap())
          .then((_) {
        print("Tiket berhasil disimpan di Firebase");
      }).catchError((error) {
        print("Error: $error");
      });
    } else {
      print("Dokumen sudah ada di Firebase");
    }
  }
}
