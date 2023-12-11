import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileService {
  // Mendapatkan ID pengguna yang aktif
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  // Mendapatkan referensi ke Firebase Storage
  Reference get _storageRef =>
      FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');

  // Mendapatkan URL gambar profil dari Firebase Storage
  Future<String?> getProfileImageUrl() async {
    try {
      // Jika userId tidak null, dapatkan URL gambar dari Firebase Storage
      if (userId != null) {
        String imageUrl = await _storageRef.getDownloadURL();
        return imageUrl;
      }

      return null;
    } catch (e) {
      print('Error getting profile image URL: $e');
      return null;
    }
  }

  // Mengupload gambar profil ke Firebase Storage
  Future<String?> uploadProfileImage(String imagePath) async {
    try {
      await _storageRef.putFile(File(imagePath));
      String imageUrl = await _storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  // Menghapus gambar profil dari Firebase Storage
  Future<void> deleteProfileImage() async {
    try {
      await _storageRef.delete();
    } catch (e) {
      print('Error deleting profile image: $e');
    }
  }
}