import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xgh_location_picker_ios/xgh_location_picker_ios_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelXghLocationPickerIos platform = MethodChannelXghLocationPickerIos();
  const MethodChannel channel = MethodChannel('xgh_location_picker_ios');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
