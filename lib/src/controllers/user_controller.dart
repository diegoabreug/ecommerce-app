// lib/src/controllers/user_controller.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Obtener el ID del usuario actual
  String? getCurrentUserUid() {
    return _auth.currentUser?.uid;
  }

  // Obtener la información del usuario desde Firestore
  Stream<UserModel> getUserData() {
    final uid = getCurrentUserUid();
    if (uid == null) {
      throw Exception("Usuario no autenticado.");
    }
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) {
        // Puedes crear un usuario por defecto aquí si lo deseas
        throw Exception("El documento del usuario no existe.");
      }
      return UserModel.fromFirestore(doc);
    });
  }

  // Actualizar la información del usuario
  Future<void> updateUserData(Map<String, dynamic> dataToUpdate) async {
    final uid = getCurrentUserUid();
    if (uid == null) return;
    await _firestore.collection('users').doc(uid).update(dataToUpdate);
  }

  // Subir imagen de perfil y actualizar la URL
  Future<String> uploadProfileImage(XFile imageFile) async {
    final uid = getCurrentUserUid();
    if (uid == null) throw Exception("Usuario no autenticado.");

    // Crear una referencia en Firebase Storage
    Reference ref = _storage.ref().child('profile_images').child('$uid.jpg');

    // Subir el archivo
    UploadTask uploadTask = ref.putFile(File(imageFile.path));

    // Esperar a que la subida se complete
    TaskSnapshot snapshot = await uploadTask;

    // Obtener la URL de descarga
    String downloadUrl = await snapshot.ref.getDownloadURL();

    // Actualizar la URL en el documento del usuario en Firestore
    await updateUserData({'profileImageUrl': downloadUrl});

    return downloadUrl;
  }
}