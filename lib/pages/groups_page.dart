import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:proximity/services/modal.dart';
import 'package:proximity/widgets/drawer.dart';

class GroupsPage extends StatefulWidget {
  @override
  State createState() => GroupsPageState();
}

class GroupsPageState extends State<GroupsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GetIt getIt = GetIt.I;

  @override
  void initState() {
    super.initState();

    _load();
  }

  _load() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Groups',
            style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: DrawerWidget(page: 'Groups'),
        body: Center(
          child: Text('Groups Page'),
        ));
  }
}
