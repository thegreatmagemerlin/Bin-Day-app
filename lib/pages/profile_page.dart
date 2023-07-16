import 'package:bin_day_final_prototype/components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('Users');

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> colors = [
    'Green',
    'Red',
    'Yellow',
    'Blue',
    'Purple',
  ];

  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Edit $field",
          style: TextStyle(
            color: Colors.grey[300],
          ),
        ),
        backgroundColor: Colors.grey[800],
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.grey[300]),
          decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: TextStyle(color: Colors.grey[300])),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[300],
              ),
            ),
          ),

          // Saving Button
          TextButton(
            onPressed: () async {
              // Update in Firestore
              if (newValue.trim().isNotEmpty) {
                await userCollection
                    .doc(currentUser.email)
                    .update({field: newValue});
              }
              Navigator.of(context).pop(newValue);
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.grey[300],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> selectField(String field, List<String> items, double height) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Select $field",
          style: TextStyle(
            color: Colors.grey[300],
          ),
        ),
        backgroundColor: Colors.grey[800],
        content: SizedBox(
          height: height,
          child: Column(
            children: items.map((item) =>
                TextButton(onPressed: () async {
                  if (item.trim().isNotEmpty) {
                    await userCollection.doc(currentUser.email).update({field: item});
                  }
                  Navigator.of(context).pop(item);
                }, child:
                Text(
                  item,
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),))
            ).toList(),
          ),
        ),




        actions: [
          // Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> questionField(String field, String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "What is $field",
          style: TextStyle(
            color: Colors.grey[300],
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.grey[300],
          ),
        ),
        backgroundColor: Colors.grey[800],
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Back',
              style: TextStyle(
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text(
            'Profile Page',
            style: TextStyle(
              letterSpacing: 2.0,
            ),
          ),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Get user Data
                final userData = snapshot.data!.data() as Map<String, dynamic>;

                // Page
                return ListView(
                  children: [
                    // Icon
                    const SizedBox(
                      height: 50.0,
                    ),
                    const Icon(
                      Icons.person,
                      size: 70.0,
                    ),

                    // Email
                    Text(
                      currentUser.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                      ),
                    ),

                    // User Details
                    const SizedBox(
                      height: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'My Details',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 25.0,
                        ),
                      ),
                    ),

                    // Username
                    MyTextBox(
                      text: userData['username'],
                      sectionName: 'Username',
                      icon: Icons.settings,
                      onTap: () => editField('username'),
                      onTapQ: () => questionField(
                          'Username', 'What should we call you? '),
                    ),

                    // Bin Details
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Bin Details',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 25.0,
                        ),
                      ),
                    ),

                    // Bin Day
                    MyTextBox(
                      text: userData['bin day'],
                      sectionName: 'Bin Day',
                      icon: Icons.settings,
                      onTap: () => selectField('bin day', days, 340.0),
                      onTapQ: () => questionField(
                        'Bin Day',
                        'When do you have to take your bins out?',
                      ),
                    ),
                    MyTextBox(
                      text: userData['constant bin'],
                      sectionName: 'Constant Bin',
                      icon: Icons.restore_from_trash,
                      onTap: () => selectField('constant bin', colors, 240),
                      onTapQ: () => questionField(
                        'Constant Bin',
                        'What color bin do you keep out every week?',
                      ),
                    ),
                    MyTextBox(
                      text: userData['second'],
                      sectionName: 'Second Bin',
                      icon: Icons.restore_from_trash,
                      onTap: () => selectField('second', colors, 240),
                      onTapQ: () => questionField(
                        'Second Bin',
                        'What is the second bin you take out? Change this to correctly fit the home screen',
                      ),
                    ),
                    MyTextBox(
                      text: userData['third'],
                      sectionName: 'Third Bin',
                      icon: Icons.restore_from_trash,
                      onTap: () => selectField('third', colors, 240),
                      onTapQ: () => questionField(
                        'Third Bin',
                        'What is the third bin you take out? Change this to correctly fit the home screen',
                      ),
                    ),

                    // Ending Spacer Box
                    const SizedBox(
                      height: 50.0,
                    )
                  ],
                );
              } else {
                return Center(child: Text('Error${snapshot.error}'));
              }
            }));
  }
}
