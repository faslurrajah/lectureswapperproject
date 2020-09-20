
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'const.dart';


class CardCourses extends StatelessWidget {
  final Image image;
  final String title;
  final String hours;
  //final String progress;
  //final double percentage;
  final Color color;

  CardCourses({
    Key key,
    @required this.image,
    @required this.title,
    @required this.hours,
    //@required this.percentage,
    //@required this.progress,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: Row(
        children: <Widget>[
          image,
          SizedBox(width: 5.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Constants.textDark),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  hours,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFF18C8E),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          ],
      ),
    );
  }
}
