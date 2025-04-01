import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:xgh_location_picker_ios/xgh_location_picker_ios.dart';
import 'package:xgh_location_picker_ios/xgh_location_picker_ios_method_channel.dart';
import 'package:xgh_location_picker_ios/xgh_location_picker_ios_platform_interface.dart';

class MockXghLocationPickerIosPlatform
    with MockPlatformInterfaceMixin
    implements XghLocationPickerIosPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<(double, double)?> openLocationPicker() {
    // TODO: implement openLocationPicker
    throw UnimplementedError();
  }
}

void main() {
  final XghLocationPickerIosPlatform initialPlatform =
      XghLocationPickerIosPlatform.instance;

  test('$MethodChannelXghLocationPickerIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelXghLocationPickerIos>());
  });

  test('getPlatformVersion', () async {
    XghLocationPickerIos xghLocationPickerIosPlugin = XghLocationPickerIos();
    MockXghLocationPickerIosPlatform fakePlatform =
        MockXghLocationPickerIosPlatform();
    XghLocationPickerIosPlatform.instance = fakePlatform;

    expect(await xghLocationPickerIosPlugin.getPlatformVersion(), '42');
  });
}
