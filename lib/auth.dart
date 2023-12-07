import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  //Creating new instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<void> register(String email, String password) async {
    String username = List.generate(6, (index) => Random().nextInt(10)).join();
    
    try {
      // This will create a new user in our firebase
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // add data to firebase database
      FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid).set({
        'username' : "user" + username,
        'email': email,
        'password': password,
        'profile':
            "https://firebasestorage.googleapis.com/v0/b/lieanna-bag.appspot.com/o/images%2Fuser_profile%2Fprofile_default.png?alt=media&token=10db65e2-58a3-430a-b469-6a693f7ac8c7",
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

    } catch (e) {
      print(e);
    }
  }

}