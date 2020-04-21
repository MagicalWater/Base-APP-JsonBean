import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_json/mx_json.dart';

void main() {
  const MethodChannel channel = MethodChannel('mx_json');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MxJson.platformVersion, '42');
  });
}
