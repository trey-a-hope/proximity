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

  static Group extractDocument(DocumentSnapshot ds) {
    return Group(
        id: ds.data['id'],
        leaderID: ds.data['groupID'],
        radius: ds.data['radius'],
        name: ds.data['name']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'leaderID': leaderID, 'radius': radius, 'name': name};
  }
}
