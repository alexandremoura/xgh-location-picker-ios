import 'xgh_location_picker_ios_platform_interface.dart';

class XghLocationPickerIos {
  Future<String?> getPlatformVersion() {
    return XghLocationPickerIosPlatform.instance.getPlatformVersion();
  }

  Future<(double, double)?> openLocationPicker() {
    return XghLocationPickerIosPlatform.instance.openLocationPicker();
  }
}
