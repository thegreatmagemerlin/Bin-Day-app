import 'package:bin_day_final_prototype/components/bin_color.dart';
import 'package:bin_day_final_prototype/components/day_counter.dart';
import 'package:bin_day_final_prototype/pages/drawer_page.dart';
import 'package:bin_day_final_prototype/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Sign Out Function
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToProfilePage() {
    // Pop menu drawer
    Navigator.pop(context);

    // go to profile page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text(
          'Bin Day',
          style: TextStyle(
            letterSpacing: 2.0,
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 100.0,
                                color: Colors.grey[800],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userData['username'],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      "Bin Day: ${userData['bin day']}",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        DayCheck(userbinday: userData['bin day']),
                      ],
                    ),
                  ),
                  MyBinColor(
                    constColor: userData['constant bin'],
                    secondColor: userData['second'],
                    thirdColor: userData['third'],
                  ),
                ],
              );
            } else {
              return Center(child: Text('Error${snapshot.error}'));
            }
          }),
    );
  }
}
