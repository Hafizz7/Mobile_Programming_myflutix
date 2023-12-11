import 'package:cloud_firestore/cloud_firestore.dart';

class Seats {
  int harga;
  String akun;
  String? id_transaksi_ticket;
  String gambar;
  String namaFilm;
  String waktu;
  String bioskop;
  List<String> kursi;

  Seats({
    required this.akun,
    required this.harga,
    required this.id_transaksi_ticket,
    required this.gambar,
    required this.waktu,
    required this.kursi,
    required this.bioskop,
    required this.namaFilm,
  });

  Map<String, dynamic> toMap() {
    return {
      'akun': akun,
      'waktu': waktu,
      'harga': harga,
      'kursi': kursi,
      'bioskop': bioskop,
      'nama_film': namaFilm,
      'gambar': gambar,
      'id_transaksi_ticket': id_transaksi_ticket,
    };
  }

  factory Seats.fromMap(Map<String, dynamic> map) {
    return Seats(
      akun: map['akun'],
      harga: map['harga'],
      id_transaksi_ticket: map['id_transaksi_ticket'],
      bioskop: map['bioskop'],
      waktu: map['waktu'],
      gambar: map['gambar'],
      kursi: List<String>.from(map['kursi']),
      namaFilm: map['nama_film'],
    );
  }

  void saveToFirebase() {
    FirebaseFirestore.instance
        .collection('akun')
        .doc(akun.toString())
        .collection('id_transaksi_ticket')
        .doc(id_transaksi_ticket)      
        .set(toMap())
        .then((_) {
      print("Tiket berhasil disimpan di Firebase");
    }).catchError((error) {
      print("Error: $error");
    });
  }
}
// .collection('waktu')
// .doc(waktu)
// .collection('bioskop')
// .doc(bioskop)
