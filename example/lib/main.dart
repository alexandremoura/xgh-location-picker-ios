import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xgh_location_picker_ios/xgh_location_picker_ios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String _platformVersion;
  final _xghLocationPickerIosPlugin = XghLocationPickerIos();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _permiteUsarLocalizacao();
  }

  Future<bool> _permiteUsarLocalizacao() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<bool> updateLocation() async {
    if (_platformVersion.isEmpty) {
      final permission = await _permiteUsarLocalizacao();
      if (permission) {
        final location = await Geolocator.getCurrentPosition();
        _platformVersion = ("Location: $location");
      }
      return permission;
    }

    return true;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _xghLocationPickerIosPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin Location Picker Example')),
        body: Column(
          children: [
            Center(
              child: FutureBuilder<bool>(
                future: updateLocation(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data ?? false) {
                    return Text('Running on: $_platformVersion\n');
                  }
                  return Text('Location permission not granted');
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final location =
                    await _xghLocationPickerIosPlugin.openLocationPicker();
                setState(() {
                  _platformVersion = ("Location: $location");
                });
              },
              child: Text('Show Location Picker'),
            ),
          ],
        ),
      ),
    );
  }
}
