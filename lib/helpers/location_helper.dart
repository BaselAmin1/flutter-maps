import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position> getCurrentLocation(context) async {
    LocationPermission permission;
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('please enaple location services'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
        ),
      );
    }

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
