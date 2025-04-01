import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'xgh_location_picker_ios_platform_interface.dart';

/// An implementation of [XghLocationPickerIosPlatform] that uses method channels.
class MethodChannelXghLocationPickerIos extends XghLocationPickerIosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xgh_location_picker_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<(double, double)?> openLocationPicker() async {
    final location = await methodChannel.invokeMethod<String>(
      'openLocationPicker',
    );

    print(location);
    if (location == null) {
      return null;
    }
    final splitedLocation = location.split(', ');
    print("latitude: ${splitedLocation[0]}");
    print("longitude: ${splitedLocation[1]}");
    return (double.parse(splitedLocation[0]), double.parse(splitedLocation[1]));
  }
}
