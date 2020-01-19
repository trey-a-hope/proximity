import 'package:flutter/material.dart';
import 'package:proximity/models/user.dart';
import 'package:proximity/pages/groups_page.dart';
import 'package:proximity/pages/home_page.dart';
import 'package:proximity/pages/settings_page.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key key, @required this.page, @required this.user})
      : super(key: key);
  final String page;
  final User user;

  final Color _iconColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('${user.firstName} ${user.lastName}'),
            accountEmail: Text('${user.email}'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.orange),
          ),
          //Home
          ListTile(
            leading: Icon(Icons.home, color: this._iconColor),
            title: Text('Home'),
            onTap: () {
              if (page != 'Home') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          //Groups
          ListTile(
            leading: Icon(Icons.lightbulb_outline, color: this._iconColor),
            title: Text('Groups'),
            subtitle: Text('Join or create a group.'),
            onTap: () {
              if (page != 'Groups') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupsPage()),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          //Settings
          ListTile(
            leading: Icon(Icons.settings, color: this._iconColor),
            title: Text('Settings'),
            subtitle: Text('Adjust your configurations.'),
            onTap: () {
              if (page != 'Settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
