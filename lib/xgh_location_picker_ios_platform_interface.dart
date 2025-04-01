import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'xgh_location_picker_ios_method_channel.dart';

abstract class XghLocationPickerIosPlatform extends PlatformInterface {
  /// Constructs a XghLocationPickerIosPlatform.
  XghLocationPickerIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static XghLocationPickerIosPlatform _instance =
      MethodChannelXghLocationPickerIos();

  /// The default instance of [XghLocationPickerIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelXghLocationPickerIos].
  static XghLocationPickerIosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [XghLocationPickerIosPlatform] when
  /// they register themselves.
  static set instance(XghLocationPickerIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<(double, double)?> openLocationPicker() {
    throw UnimplementedError('openLocationPicker() has not been implemented.');
  }
}
