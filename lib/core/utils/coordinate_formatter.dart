abstract final class CoordinateFormatter {
  static String latitude(double lat) {
    final dir = lat >= 0 ? 'N' : 'S';
    return '${lat.abs().toStringAsFixed(4)}° $dir';
  }

  static String longitude(double lon) {
    final dir = lon >= 0 ? 'E' : 'W';
    return '${lon.abs().toStringAsFixed(4)}° $dir';
  }

  static String latLon(double lat, double lon) =>
      '${latitude(lat)}  ${longitude(lon)}';
}
