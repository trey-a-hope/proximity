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

  factory User.fromDoc({@required DocumentSnapshot doc}) {
    return User(
        email: doc.data['email'],
        id: doc.data['id'],
        imgUrl: doc.data['imgUrl'],
        fcmToken: doc.data['fcmToken'],
        isOnline: doc.data['isOnline'],
        time: doc.data['time'].toDate(),
        uid: doc.data['uid'],
        firstName: doc.data['firstName'],
        lastName: doc.data['lastName']);
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
