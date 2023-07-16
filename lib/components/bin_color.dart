import 'package:flutter/material.dart';

class MyBinColor extends StatelessWidget {
  final String constColor;
  final String secondColor;
  final String thirdColor;
  const MyBinColor({
    super.key,
    required this.constColor,
    required this.secondColor,
    required this.thirdColor,
  });

  MaterialColor getColor(String color) {
    if (color.toLowerCase() == 'green') {
      return Colors.green;
    } else if (color.toLowerCase() == 'red') {
      return Colors.red;
    } else if (color.toLowerCase() == 'yellow') {
      return Colors.yellow;
    }else if (color.toLowerCase() == 'blue') {
      return Colors.blue;
    } else if (color.toLowerCase() == 'purple') {
      return Colors.deepPurple;
    }
    else {return Colors.grey;}
  }

  MaterialColor getOtherBin(day) {
    if (day % 2 == 0) {
      return getColor(secondColor);
    } else {return getColor(thirdColor);}
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime start = DateTime(2023, 1, 1);
    int day = (now.difference(start).inDays / 7).ceil();
    MaterialColor constBin = getColor(constColor);
    MaterialColor otherBin = getOtherBin(day);



    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // First Bin Color
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: constBin,
          ),
          height: 200.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
        ),

        // Second Bin Color
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: otherBin,
          ),
          height: 200.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
