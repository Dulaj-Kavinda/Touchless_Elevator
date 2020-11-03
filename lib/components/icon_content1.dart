import 'package:flutter/material.dart';

class IconContent1 extends StatelessWidget {
  IconContent1({this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 100.0,
        ),
      ],
    );
  }
}
