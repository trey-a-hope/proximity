import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity/models/user.dart';
import 'package:proximity/services/auth_service.dart';
import 'package:proximity/widgets/drawer.dart';

class SettingsPage extends StatefulWidget {
  @override
  State createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GetIt getIt = GetIt.I;
  User user;
  @override
  void initState() {
    super.initState();

    _load();
  }

  _load() async {
    user = await getIt<AuthService>().getCurrentUser();
        setState(() {
      
    });
  }

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
          'Settings',
          style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: DrawerWidget(
        page: 'Settings',
        user: user,
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
