import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Invite {
  final String id;
  final String groupID;

  Invite({@required this.id, @required this.groupID});

  static Invite extractDocument(DocumentSnapshot ds) {
    return Invite(id: ds.data['id'], groupID: ds.data['groupID']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupID': groupID,
    };
  }
}
