import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoordinateUtil{
    static LatLng convertToLatLng(List<double> xy) {
      double x = xy[0];
      double y = xy[1];

      final lng = (x / 20037508.34) * 180;
      final lat = (atan(exp(y / 20037508.34 * pi)) / pi) * 360 - 90;

      return LatLng(lat, lng);
    }
}