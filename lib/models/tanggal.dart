import 'package:cloud_firestore/cloud_firestore.dart';

class Tanggal {  
  String? id_movie;
  List<String> tanggal;

  Tanggal({    
    required this.id_movie,
    required this.tanggal,    
  });

  Map<String, dynamic> toMap() {
    return {      
      'tanggal': tanggal,      
      'id_movie': id_movie,
    };
  }

  factory Tanggal.fromMap(Map<String, dynamic> map) {
    return Tanggal(      
      id_movie: map['id_movie'],      
      tanggal: List<String>.from(map['tanggal']),      
    );
  }

  void saveToFirebase() {
    FirebaseFirestore.instance        
        .collection('id_movie')
        .doc(id_movie)      
        .set(toMap())
        .then((_) {
      print("Tanggal berhasil disimpan di Firebase");
    }).catchError((error) {
      print("Error: $error");
    });
  }
}
