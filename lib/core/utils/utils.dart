import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:geolocator/geolocator.dart';

class Utils {
  static String crypto(String value) {
    var bytes = utf8.encode(value);

    return sha256.convert(bytes).toString();
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  String dateToString(String data) {
    return data.split("/").reversed.join("-");
  }

  DateTime convertStringToDate(String data) {
    return DateTime.parse(dateToString(data));
  }

  ///
  /// yyyyMMdd - dd/MM/yyyy
  ///
  String dateToStringFormat(String dateWithNotFormat) {
    return "${dateWithNotFormat.substring(6)}/${dateWithNotFormat.substring(4, 6)}/${dateWithNotFormat.substring(0, 4)}";
  }
}
