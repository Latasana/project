import 'dart:developer';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homeservice/router/router.gr.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/side.jpg?alt=media&token=c7414349-6ca4-4389-a870-e4352d260f38'))),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Profile'),
              onTap: () {}),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Feedback'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('About'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () async {
              log('Log Out');
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (prefs.containsKey("jwt")) {
                prefs.remove("jwt");
                prefs.remove('username');
                prefs.remove('statuscode');
                context.router.push(LoginRoute());
              }
            },
          ),
        ],
      ),
    );
  }
}
