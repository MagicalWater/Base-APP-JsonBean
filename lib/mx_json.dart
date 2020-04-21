import 'dart:async';

import 'package:flutter/services.dart';

class MxJson {
  static const MethodChannel _channel =
      const MethodChannel('mx_json');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
