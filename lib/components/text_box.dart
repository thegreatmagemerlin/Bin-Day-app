import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final IconData icon;
  final Function()? onTap;
  final Function()? onTapQ;

  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.icon,
    required this.onTap,
    required this.onTapQ,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
      padding: const EdgeInsets.only(left: 15.0, bottom: 15.0, top: 10.0),
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Section Name
              SizedBox(
                width: 260.4,
                child: Text(
                  sectionName,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.grey[600],
                  ),
                ),
              ),

              // Text
              Text(
                text,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: Colors.grey[700],
              size: 30.0,
            ),
          ),
          IconButton(
            onPressed: onTapQ,
            icon: Icon(
              Icons.question_mark,
              color: Colors.grey[700],
              size: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
