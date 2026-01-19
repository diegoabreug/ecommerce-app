// lib/src/models/user_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;  final String firstName;
  final String lastName;
  final String fullName;
  final String bio;
  final String phone;
  final String profileImageUrl;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.bio,
    required this.phone,
    required this.profileImageUrl,
  });

  // Fábrica para crear un UserModel a partir de un documento de Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      fullName: data['fullName'] ?? '',
      bio: data['bio'] ?? '',
      phone: data['phone'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }

  // Método para convertir un UserModel a un mapa para guardarlo en Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': '$firstName $lastName', // Actualiza el nombre completo
      'bio': bio,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
    };
  }
}