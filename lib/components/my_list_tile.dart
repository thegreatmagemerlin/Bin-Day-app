import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey[300],
          size: 30.0,
        ),
        title: Text(
          text,
          style: TextStyle(
              color: Colors.grey[300],
              fontFamily: 'SF',
              letterSpacing: 2.0,
              fontSize: 20.0
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
