import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:touchless_elevator/app_brain/controller.dart';
import 'package:touchless_elevator/screens/control_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:touchless_elevator/app_brain/mqtt_wrapper.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  MQTTClientWrapper clientWrapper;

  @override
  void initState() {
    clientWrapper = MQTTClientWrapper();
    clientWrapper.prepareMqttClient();
    super.initState();
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;
  bool _isFlash = false;
  bool _isFoundQRcode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 70.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: TypewriterAnimatedTextKit(
                  text: ['Touchless Elevator'],
                  textStyle: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 40.0,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 8,
                  borderLength: 130,
                  borderWidth: 5,
                  overlayColor: Color(0xFF1D1E33),
                ),
              ),
            ),
            FlatButton.icon(
              color: Colors.white,
              shape: CircleBorder(),
              padding: EdgeInsets.all(10.0),
              icon: !_isFlash
                  ? Icon(
                      Icons.flash_off,
                      color: Colors.red,
                      size: 30.0,
                    )
                  : Icon(
                      Icons.flash_on,
                      color: Colors.red,
                    ),
              onPressed: () {
                if (!_isFlash)
                  setState(() {
                    _isFlash = true;
                    controller.toggleFlash();
                  });
                else
                  setState(() {
                    _isFlash = false;
                    controller.toggleFlash();
                  });
              },
              label: Text(''),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    try {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        setState(() {
          qrText = scanData;
          _isFoundQRcode = true;
          var qrArray = qrText.split("-");
          String elevatorId = qrArray[0];
          String enteredFloor = qrArray[1];

          this.dispose();
          if (_isFoundQRcode && elevatorId == elevatorAccesId) {
            ElevatorController elevator =
                ElevatorController(clientWrapper, enteredFloor);
            //elevator.setEnteredFloor();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ControlPage(elevator);
            }));
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
