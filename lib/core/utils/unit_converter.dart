abstract final class UnitConverter {
  static double kmToMiles(double km) => km * 0.621371;
  static double kmSToMph(double kms) => kms * 2236.94;
  static double kmToFeet(double km) => km * 3280.84;

  static String formatAltitude(double km, {bool metric = true}) {
    if (metric) return '${km.toStringAsFixed(1)} km';
    return '${kmToMiles(km).toStringAsFixed(1)} mi';
  }

  static String formatVelocity(double kms, {bool metric = true}) {
    if (metric) return '${kms.toStringAsFixed(2)} km/s';
    return '${(kmSToMph(kms) / 1000).toStringAsFixed(2)}k mph';
  }
}
