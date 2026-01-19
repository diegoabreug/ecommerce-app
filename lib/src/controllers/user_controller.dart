import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Obtener datos del usuario en tiempo real
  Stream<UserModel> getUserData() {
    String uid = _auth.currentUser!.uid;
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      return UserModel.fromFirestore(snapshot);
    });
  }

  // Subir imagen a Firebase Storage y obtener URL
  Future<String> uploadProfileImage(XFile image) async {
    String uid = _auth.currentUser!.uid;
    Reference ref = _storage.ref().child('profileImages').child(uid);

    // Subir archivo
    UploadTask uploadTask = ref.putFile(File(image.path));
    TaskSnapshot snapshot = await uploadTask;

    // Obtener URL de descarga
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Actualizar datos del usuario
  Future<String> updateUserData({
    required String firstName,
    required String lastName,
    required String bio,
    required String phone,
    String? profileImageUrl,
  }) async {
    String res = "Error";
    try {
      String uid = _auth.currentUser!.uid;
      Map<String, dynamic> data = {
        'firstName': firstName,
        'lastName': lastName,
        'fullName': '$firstName $lastName',
        'bio': bio,
        'phone': phone,
      };

      // Si se subió una nueva imagen, actualizamos también el campo de la URL
      if (profileImageUrl != null) {
        data['profileImageUrl'] = profileImageUrl;
      }

      await _firestore.collection('users').doc(uid).update(data);
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}