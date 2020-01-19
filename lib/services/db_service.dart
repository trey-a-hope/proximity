import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proximity/models/user.dart';

abstract class DBService {
  //Users
  Future<void> createUser({@required User user});
  Future<User> retrieveUser({@required String id});
  Future<List<User>> retrieveUsers({bool isAdmin, int limit, String orderBy});
  Future<void> updateUser(
      {@required String userID, @required Map<String, dynamic> data});
}

class DBServiceImplementation extends DBService {
  final CollectionReference _usersDB = Firestore.instance.collection('Users');

  @override
  Future<void> createUser({User user}) async {
    try {
      DocumentReference docRef = await _usersDB.add(
        user.toMap(),
      );
      await _usersDB.document(docRef.documentID).updateData(
        {'id': docRef.documentID},
      );
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<User> retrieveUser({String id}) async {
    try {
      DocumentSnapshot documentSnapshot = await _usersDB.document(id).get();
      return User.fromDoc(doc: documentSnapshot);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateUser({String userID, Map<String, dynamic> data}) async {
    try {
      await _usersDB.document(userID).updateData(data);
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<List<User>> retrieveUsers(
      {bool isAdmin, int limit, String orderBy}) async {
    try {
      Query query = _usersDB;

      if (isAdmin != null) {
        query = query.where('isAdmin', isEqualTo: isAdmin);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy);
      }

      List<DocumentSnapshot> docs = (await query.getDocuments()).documents;
      List<User> users = List<User>();
      for (int i = 0; i < docs.length; i++) {
        users.add(
          User.fromDoc(doc: docs[i]),
        );
      }

      return users;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
