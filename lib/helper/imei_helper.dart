import 'dart:async';
import 'dart:developer';

import 'package:device_info/device_info.dart';
import 'package:crypto/crypto.dart';

import 'dart:convert'; // for the utf8.encode method

class DeviceIdHelper {
  static Future<String> deviceInfoDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    log('Android ID: ${androidInfo.androidId}'); // e.g. "Moto G (4)"
    var bytes = utf8.encode(androidInfo.androidId); // data being hashed

    var digest = sha1.convert(bytes);
    return digest.toString();
  }
}
