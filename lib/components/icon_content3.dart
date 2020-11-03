import 'package:flutter/material.dart';

class IconContent3 extends StatelessWidget {
  IconContent3({this.icon, this.colour});
  final IconData icon;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 50.0,
          color: colour,
        ),
      ],
    );
  }
}
