import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;


  const MyButton({
    super.key,
    required this.onTap,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: Center(
          child: Text(text, style: const TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }
}
