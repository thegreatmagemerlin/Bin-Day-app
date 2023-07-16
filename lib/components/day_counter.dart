import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayCheck extends StatelessWidget {
  final String userbinday;

  const DayCheck({
    super.key,
    required this.userbinday
  });

  int daysToBin(String userbinday) {
    DateTime today = DateTime.now();
    int weekday = today.weekday;

    if(userbinday.toLowerCase() == 'monday'){
      DateTime next = today.add(Duration(days: 7 - weekday + 1));
      int daystobin = next.difference(today).inDays % 7;
      return daystobin;
    } else if (userbinday.toLowerCase() == 'tuesday') {
      DateTime next = today.add(Duration(days: 7 - weekday + 2));
      int daystobin = next.difference(today).inDays % 7;
      return daystobin;
    } else if (userbinday.toLowerCase() == 'wednesday') {
      DateTime next = today.add(Duration(days: 7 - weekday + 3));
      int daystobin = next.difference(today).inDays % 7;
      return daystobin;
    } else if (userbinday.toLowerCase() == 'thursday') {
      DateTime next = today.add(Duration(days: 7 - weekday + 4));
      int daystobin = next.difference(today).inDays % 7;
      return daystobin;
    } else if (userbinday.toLowerCase() == 'friday') {
      DateTime next = today.add(Duration(days: 7 - weekday + 5));
      int daystobin = next.difference(today).inDays % 7;
      return daystobin;
    } else if (userbinday.toLowerCase() == 'saturday') {
      DateTime next = today.add(Duration(days: 7 - weekday + 6));
      int daystobin = next.difference(today).inDays % 7;
      return daystobin;
    } else if (userbinday.toLowerCase() == 'sunday') {
      DateTime next = today.add(Duration(days: 7 - weekday + 7));
      int daystobin = next.difference(today).inDays % 7;
      return daystobin;
    }
    else {return 999;}
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String day = DateFormat('EEEE').format(now);
    int daystobin = daysToBin(userbinday);

    if (daystobin == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Text(
          'Today is Bin Day',
          style: TextStyle(
              fontSize: 30.0,
              color: Colors.grey[700]
          ),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          const SizedBox(height: 30.0,),
          Text(
            'Today is $day',
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.grey[700]
            ),
          ),
          const SizedBox(height: 5.0,),
          Text(
            'Next bin day in: $daystobin',
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.grey[700]
            ),
          ),
        ],
      );
    }
  }
}
