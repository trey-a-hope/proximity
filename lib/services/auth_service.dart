import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proximity/models/user.dart';

abstract class AuthService {
  Future<User> getCurrentUser();
  Future<void> signOut();
  Stream<FirebaseUser> onAuthStateChanged();
  Future<AuthResult> signInWithEmailAndPassword(
      {@required String email, @required String password});

  Future<AuthResult> createUserWithEmailAndPassword(
      {@required String email, @required String password});
  Future<void> updatePassword({@required String password});
  Future<void> updateEmail({@required String email});

  Future<void> deleteUser({@required String userID});
  Future<void> sendPasswordResetEmail({@required String email});
}

class AuthServiceImplementation extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersDB = Firestore.instance.collection('Users');

  @override
  Future<User> getCurrentUser() async {
    try {
      FirebaseUser firebaseUser = await _auth.currentUser();
      QuerySnapshot querySnapshot = await _usersDB
          .where('uid', isEqualTo: firebaseUser.uid)
          .getDocuments();
      DocumentSnapshot documentSnapshot = querySnapshot.documents.first;
      return User.fromDoc(doc: documentSnapshot);
    } catch (e) {
      throw Exception('Could not fetch user at this time.');
    }
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  Stream<FirebaseUser> onAuthStateChanged() {
    return _auth.onAuthStateChanged;
  }

  @override
  Future<AuthResult> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      return (await _auth.signInWithEmailAndPassword(
          email: email, password: password));
    } catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  @override
  Future<AuthResult> createUserWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      return (await _auth.createUserWithEmailAndPassword(
          email: email, password: password));
    } catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  @override
  Future<void> sendPasswordResetEmail({@required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return;
    } catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  @override
  Future<void> updatePassword({String password}) async {
    try {
      FirebaseUser firebaseUser = await _auth.currentUser();
      firebaseUser.updatePassword(password);
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<void> deleteUser({String userID}) async {
    try {
      FirebaseUser firebaseUser = await _auth.currentUser();
      await firebaseUser.delete();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<void> updateEmail({String email}) async {
    try {
      FirebaseUser firebaseUser = await _auth.currentUser();
      await firebaseUser.updateEmail(email);
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
