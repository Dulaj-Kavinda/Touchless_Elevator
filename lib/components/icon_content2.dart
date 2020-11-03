import 'package:flutter/material.dart';

class IconContent2 extends StatelessWidget {
  IconContent2({this.icon1, this.icon2});
  final IconData icon1;
  final IconData icon2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon1,
          size: 60.0,
        ),
        Icon(
          icon2,
          size: 60.0,
        ),
      ],
    );
  }
}
