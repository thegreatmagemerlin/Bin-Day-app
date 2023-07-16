import 'package:bin_day_final_prototype/components/my_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function() onSignOut;


  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          children: <Widget>[
            // Header with logo
            DrawerHeader(
                child: Icon(
                  Icons.restore_from_trash_sharp,
                  size: 75,
                  color: Colors.grey[300],
                )),
            // Profile List tile
            MyListTile(
              icon: Icons.person,
              text: 'PROFILE',
              onTap: onProfileTap,
            ),

            // Logout button
            MyListTile(
              icon: Icons.logout,
              text: 'SIGN OUT',
              onTap: onSignOut,
            ),
          ],
        )
    );
  }
}
