import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController{

  //creamos una instancia de FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //crear una instancia del cloud firestore
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //registrar usuario
  Future<String> registerUser(String email, String password) async{

    String response = "Something went wrong";
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //debemos guardar el usuario en la base de datos
      await _firestore.collection("users").doc(userCredential.user!.uid).set(
          {
            "fullName": "",
            "profileImage":"",
            "email": email,
            "uid": userCredential.user!.uid,
            "creationDate": DateTime.now(),
          }
      );
      response = "Success";

    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        response = ('The account already exists for that email.');
      }
    }catch(e){
      response = e.toString();
    }
    return response;
  }

  //login de usuario
  Future<String> loginUser(String email, String password) async{
    String response = "Something went wrong";
    try{
      // CAMBIO AQUÍ: Eliminamos "UserCredential userCredential ="
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      response = "Success";
    }
    on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        response = 'No user found for that email';
      }
      else if(e.code == 'wrong-password'){
        response = 'Wrong password provided for that user';
      }
    }
    catch(e){
      response = e.toString();
    }
    return response;
  }
  // Future<String> loginUser(String email, String password) async{
  //   String response = "Something went wrong";
  //   try{
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     response = "Success";
  //   }
  //   on FirebaseAuthException catch(e){
  //     if(e.code == 'user-not-found'){
  //       response = 'No user found for that email';
  //     }
  //     else if(e.code == 'wrong-password'){
  //       response = 'Wrong password provided for that user';
  //     }
  //   }
  //   catch(e){
  //     response = e.toString();
  //   }
  //   return response;
  // }
}