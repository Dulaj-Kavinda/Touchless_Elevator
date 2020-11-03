import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';

class MQTTClientWrapper {
  final MqttClient client = MqttClient('broker.hivemq.com', '');
  final String pubTopic = 'Dart/Mqtt_client/elevator_control';

  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient();
  }

  void publishCommand(String message) {
    _publishMessage(message);
  }

  void disconnectCommand() {
    client.disconnect();
  }

  Future<void> _connectClient() async {
    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .keepAliveFor(60) // Must agree with the keep alive set above or not set
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('MQTT client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } on Exception catch (e) {
      print('client exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('MQTT client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'MQTT client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }
  }

  void _setupMqttClient() {
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
    client.pongCallback = _pong;
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    /// Subscribe to it
    print('Subscribing to the topic');
    client.subscribe(pubTopic, MqttQos.atMostOnce);

    /// Publish it
    print('Publishing our topic');
    client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload);
  }

  void _onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
  }

  void _onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print('OnDisconnected callback is solicited, this is correct');
    }
    exit(-1);
  }

  void _onConnected() {
    print('OnConnected client callback - Client connection was successful');
  }

  void _pong() {
    print('Ping response client callback invoked');
  }
}
