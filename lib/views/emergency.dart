// ignore_for_file: library_prefixes

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_audio_capture/flutter_audio_capture.dart';
class Emergency extends StatefulWidget {
  const Emergency({super.key});
  @override
  State<Emergency> createState() => _EmergencyState();
}
class _EmergencyState extends State<Emergency> {
  final FlutterAudioCapture _plugin =  FlutterAudioCapture();

  IO.Socket socket = IO.io('http://103.164.70.170:3000/', {
    'transports': ['websocket'],
    'autoConnect': false,
  });
  @override
  void initState() {
    super.initState();
    connect();
_listenLocationChanges();
  }
  void connect() {
    socket.connect();
  }
   Location location = Location();
   StreamSubscription<LocationData> _locationSubscription = Location().onLocationChanged.listen((event) { }) ;
  @override
  void dispose() {
    _locationSubscription.cancel(); // Cancel the subscription when disposing of the widget
    socket.disconnect();
    _plugin.stop();
    super.dispose();
  }

  // Function to listen to location changes
  void _listenLocationChanges() {
    _locationSubscription = location.onLocationChanged.listen((LocationData currentLocation) {
     socket.emit('listenToEmergency',{"userId":"lujmzh5csogj8ymt2k0000000000","lat":currentLocation.latitude,"lng":currentLocation.longitude});
    });
  }
  void sendBuffer() {
    _plugin.start(
      (obj){ socket.emit('toServer', {'userId': 'lujmzh5csogj8ymt2k0000000000', "buffer": obj});
      // socket.emit('listenToEmergency',{'userId':'1234'})
      
      // ignore: avoid_print
      }, (e){print(e);},sampleRate: 16000, bufferSize: 3000);
// "Hello" in ASCII
    // Send the buffer to the server
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendBuffer,
          child: const Text('Send Buffer'),
        ),
      ),
    );
  }
}