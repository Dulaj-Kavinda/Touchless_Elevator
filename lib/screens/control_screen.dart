import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touchless_elevator/components/reusable_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:touchless_elevator/components/icon_content1.dart';
import 'package:touchless_elevator/components/icon_content2.dart';
import 'package:touchless_elevator/components/icon_content3.dart';
import 'package:touchless_elevator/constants.dart';
import 'package:touchless_elevator/app_brain/controller.dart';
import 'package:touchless_elevator/screens/scanner_screen.dart';

enum Option {
  up,
  down,
  open,
  close,
  alarm,
  floor_one,
  floor_two,
  floor_three,
}

class ControlPage extends StatefulWidget {
  ControlPage(this.elevator);
  final ElevatorController elevator;

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  Option selectedDirection;
  Option selectedAccess;
  Option selectedFloor;
  Option selectedAlarm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Scanner();
                      }));
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    onPressed: () {
                      widget.elevator.exitElevator();
                    },
                    child: Icon(
                      Icons.close,
                      size: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 7,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          widget.elevator.goUpward();
                          selectedDirection = Option.up;
                        });
                      },
                      colour: selectedDirection == Option.up
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent1(
                        icon: FontAwesomeIcons.chevronUp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          widget.elevator.goDownward();
                          selectedDirection = Option.down;
                        });
                      },
                      colour: selectedDirection == Option.down
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent1(
                        icon: FontAwesomeIcons.chevronDown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Divider(
                color: Colors.white,
                thickness: 2.0,
                indent: 25.0,
                endIndent: 25.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          widget.elevator.doorClose();
                          selectedAccess = Option.close;
                        });
                      },
                      colour: selectedAccess == Option.close
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent2(
                        icon1: FontAwesomeIcons.stepForward,
                        icon2: FontAwesomeIcons.stepBackward,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          widget.elevator.doorOpen();
                          selectedAccess = Option.open;
                        });
                      },
                      colour: selectedAccess == Option.open
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent2(
                        icon1: FontAwesomeIcons.stepBackward,
                        icon2: FontAwesomeIcons.stepForward,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          widget.elevator.selectFloor(1);
                          selectedFloor = Option.floor_one;
                        });
                      },
                      colour: selectedFloor == Option.floor_one
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent3(
                        icon: ButtonIcons.looks_one,
                        colour: Colors.white54,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          widget.elevator.selectFloor(2);
                          selectedFloor = Option.floor_two;
                        });
                      },
                      colour: selectedFloor == Option.floor_two
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent3(
                        icon: ButtonIcons.looks_two,
                        colour: Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          widget.elevator.selectFloor(3);
                          selectedFloor = Option.floor_three;
                        });
                      },
                      colour: selectedFloor == Option.floor_three
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent3(
                        icon: ButtonIcons.looks_3,
                        colour: Colors.white54,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        widget.elevator.onAlarm();
                        setState(() {
                          selectedAlarm = Option.alarm;
                        });
                      },
                      colour: selectedAlarm == Option.alarm
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent3(
                        icon: ButtonIcons.bell_alt,
                        colour: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
