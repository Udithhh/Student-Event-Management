import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  //register
  Future<UserCredential?> signUpWithEmail(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _fireStore.collection("student").doc(userCredential.user?.uid).set({
        'email': email,
        'password': password,
        'name': name,
      });

      return userCredential;
    } catch (e) {
      log("Error : ${e.toString()}");
      return null;
    }
  }

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (e) {
      log("Error : ${e.toString()}");
      return null;
    }
  }

  Future<UserCredential?> orgSignUpWithEmail(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _fireStore
          .collection("organizer")
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'password': password,
        'name': name,
      });

      return userCredential;
    } catch (e) {
      log("Error : ${e.toString()}");
      return null;
    }
  }

  Future<UserCredential?> orgSignInWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (e) {
      log("Error : ${e.toString()}");
      return null;
    }
  }

  Future<void> orgLogout() async {
    await _auth.signOut();
  }
}
