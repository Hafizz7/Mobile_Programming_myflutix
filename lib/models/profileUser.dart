import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileUser {
  String id_akun;
  int saldo;
  String username;  
  String fotoProfile;  
  String email;

  ProfileUser({
    required this.email,
    required this.id_akun,
    required this.saldo,
    required this.username,
    required this.fotoProfile,    
  });

  Map<String, dynamic> toMap() {
    return {
      'email' : email,
      'id_akun': id_akun,
      'saldo': saldo,
      'username': username,
      'fotoProfile': fotoProfile,      
    };
  }

  factory ProfileUser.fromMap(Map<String, dynamic> map) {
    return ProfileUser(      
      id_akun: map['id_akun'],
      saldo: map['saldo'],
      username: map['username'],
      fotoProfile: map['fotoProfile'],      
      email: map['email'],
    );
  }

  void saveToFirebase() {
    FirebaseFirestore.instance
        .collection('id_akun')
        .doc(id_akun)        
        .set(toMap())
        .then((_) {
      print("Tiket berhasil disimpan di Firebase");
    }).catchError((error) {
      print("Error: $error");
    });
  }
}