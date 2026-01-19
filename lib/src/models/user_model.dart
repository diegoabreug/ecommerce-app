import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String firstName;
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

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      // Si el fullName viene vacío, lo construimos con nombre y apellido
      fullName: data['fullName'] != null && data['fullName'].isNotEmpty
          ? data['fullName']
          : "${data['firstName'] ?? ''} ${data['lastName'] ?? ''}".trim(),
      bio: data['bio'] ?? '',
      phone: data['phone'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }
}