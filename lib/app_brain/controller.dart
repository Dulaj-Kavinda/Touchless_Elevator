import 'dart:io';

import 'package:touchless_elevator/app_brain/mqtt_wrapper.dart';

const elevatorAccesId = '12345';

class ElevatorController {
  ElevatorController(this.elevatorClient, this.enteredFloor);
  final MQTTClientWrapper elevatorClient;
  String enteredFloor;

  void goUpward() {
    elevatorClient.publishCommand('go=UP&currentFloor=${this.enteredFloor}');
  }

  void goDownward() {
    elevatorClient.publishCommand('go=DOWN&currentFloor=${this.enteredFloor}');
  }

  void doorOpen() {
    elevatorClient.publishCommand('door=OPEN');
  }

  void doorClose() {
    elevatorClient.publishCommand('door=CLOSE');
  }

  void selectFloor(int floorNumber) {
    elevatorClient.publishCommand('floor=$floorNumber');
    this.enteredFloor = floorNumber.toString();
  }

  void onAlarm() {
    elevatorClient.publishCommand('alarm=ON');
  }

  void offAlarm() {
    //http.get('$elevatorIp/alarm=OFF');
  }

  void exitElevator() {
    elevatorClient.disconnectCommand();
    exit(0);
  }
}
