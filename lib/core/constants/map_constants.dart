import 'package:latlong2/latlong.dart';

abstract final class MapConstants {
  static const String darkTileUrl =
      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';
  static const List<String> tileSubdomains = ['a', 'b', 'c', 'd'];
  static const double maxZoom = 19;
  static const String tileAttribution =
      '© OpenStreetMap contributors © CARTO';

  static const LatLng defaultCenter = LatLng(0, 0);
  static const double defaultZoom = 2.5;
  static const double detailZoom = 5;

  static const int orbitTrackPoints = 90;
}
