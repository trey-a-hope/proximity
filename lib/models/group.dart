import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Group {
  final String id;
  final String leaderID;
  final int radius;
  final String name;

  Group(
      {@required this.id,
      @required this.leaderID,
      @required this.radius,
      @required this.name});

  factory Group.fromDoc({@required DocumentSnapshot doc}) {
    return Group(
        id: doc.data['id'],
        leaderID: doc.data['groupID'],
        radius: doc.data['radius'],
        name: doc.data['name']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'leaderID': leaderID, 'radius': radius, 'name': name};
  }
}
