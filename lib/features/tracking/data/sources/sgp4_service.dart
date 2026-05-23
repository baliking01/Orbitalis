import 'dart:math';

/// Minimal SGP4 orbital propagator using simplified two-body mechanics.
///
/// For a production app with sgp4_dart available, replace this with
/// the library's twoline2rv / sgp4 / eciToGeodetic calls.
/// This implementation provides reasonable accuracy for visualization.
class Sgp4Service {
  /// Parse TLE and compute geodetic position at [time].
  /// Returns {lat, lon, altKm, velKms} or null on parse failure.
  static Map<String, double>? propagate({
    required String line1,
    required String line2,
    DateTime? time,
  }) {
    try {
      final t = time ?? DateTime.now().toUtc();
      final inc = _parseDouble(line2, 8, 16) * _deg2rad;
      final raan = _parseDouble(line2, 17, 25) * _deg2rad;
      final eccStr = '0.${line2.substring(26, 33).trim()}';
      final ecc = double.tryParse(eccStr) ?? 0;
      final argPerigee = _parseDouble(line2, 34, 42) * _deg2rad;
      final meanMotionRevDay = _parseDouble(line2, 52, 63);
      final meanAnomalyDeg = _parseDouble(line2, 43, 51);

      // Epoch from line1
      final epochStr = line1.substring(18, 32).trim();
      final epochYear = int.parse(epochStr.substring(0, 2));
      final epochDay = double.parse(epochStr.substring(2));
      final fullYear = epochYear < 57 ? 2000 + epochYear : 1900 + epochYear;
      final epoch = DateTime.utc(fullYear).add(
        Duration(
          microseconds: ((epochDay - 1) * Duration.microsecondsPerDay).round(),
        ),
      );

      final dt = t.difference(epoch).inSeconds / 60.0; // minutes since epoch
      final n = meanMotionRevDay * 2 * pi / 1440; // rad/s
      final semiMajor =
          pow(398600.4418 / (n * n), 1 / 3.0).toDouble(); // km
      final altKm = semiMajor * (1 - ecc) - 6371.0;
      final velKms = sqrt(398600.4418 / semiMajor);

      var ma = meanAnomalyDeg * _deg2rad + n * dt;
      ma = ma % (2 * pi);

      // Eccentric anomaly via Newton's method
      var ea = ma;
      for (var i = 0; i < 10; i++) {
        ea = ma + ecc * sin(ea);
      }

      final ta = 2 *
          atan2(
            sqrt(1 + ecc) * sin(ea / 2),
            sqrt(1 - ecc) * cos(ea / 2),
          );

      final u = argPerigee + ta; // argument of latitude

      // ECI position
      final cosRaan = cos(raan);
      final sinRaan = sin(raan);
      final cosInc = cos(inc);
      final sinInc = sin(inc);
      final cosU = cos(u);
      final sinU = sin(u);
      final r = semiMajor * (1 - ecc * cos(ea));

      final x = r * (cosRaan * cosU - sinRaan * sinU * cosInc);
      final y = r * (sinRaan * cosU + cosRaan * sinU * cosInc);
      final z = r * sinU * sinInc;

      // Greenwich sidereal time
      final jd = _julianDate(t);
      final gst = (280.46061837 +
              360.98564736629 * (jd - 2451545.0)) *
          _deg2rad;

      // ECI → ECEF → Geodetic
      final lon = atan2(y, x) - gst;
      final lonNorm = _normAngle(lon) / _deg2rad;
      final p = sqrt(x * x + y * y);
      final lat = atan2(z, p) / _deg2rad;

      return {
        'lat': lat,
        'lon': lonNorm,
        'altKm': altKm.clamp(200, 2000),
        'velKms': velKms,
        'periodMin': (2 * pi / n) / 60,
      };
    } catch (_) {
      return null;
    }
  }

  static double _parseDouble(String line, int start, int end) =>
      double.tryParse(line.substring(start, end).trim()) ?? 0;

  static double _julianDate(DateTime t) {
    final a = (14 - t.month) ~/ 12;
    final y = t.year + 4800 - a;
    final m = t.month + 12 * a - 3;
    return t.day +
        (153 * m + 2) ~/ 5 +
        365 * y +
        y ~/ 4 -
        y ~/ 100 +
        y ~/ 400 -
        32045 +
        (t.hour + t.minute / 60.0 + t.second / 3600.0) / 24.0;
  }

  static double _normAngle(double r) {
    var a = r % (2 * pi);
    if (a > pi) a -= 2 * pi;
    if (a < -pi) a += 2 * pi;
    return a;
  }

  static const double _deg2rad = pi / 180;
}
