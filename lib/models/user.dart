import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String email;
  final String id;
  final String imgUrl;
  final bool isOnline;
  final String fcmToken;
  final DateTime time;
  final String uid;
  final String firstName;
  final String lastName;

  User(
      {@required this.email,
      @required this.id,
      @required this.imgUrl,
      @required this.isOnline,
      @required this.fcmToken,
      @required this.time,
      @required this.uid,
      @required this.firstName,
      @required this.lastName});

  static User extractDocument(DocumentSnapshot ds) {
    return User(
        email: ds.data['email'],
        id: ds.data['id'],
        imgUrl: ds.data['imgUrl'],
        fcmToken: ds.data['fcmToken'],
        isOnline: ds.data['isOnline'],
        time: ds.data['time'].toDate(),
        uid: ds.data['uid'],
        firstName: ds.data['firstName'],
        lastName: ds.data['lastName']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'imgUrl': imgUrl,
      'fcmToken': fcmToken,
      'isOnline': isOnline,
      'time': time,
      'uid': uid,
      'lastName': lastName,
      'firstName': firstName
    };
  }
}
