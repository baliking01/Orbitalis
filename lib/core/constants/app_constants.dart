abstract final class AppConstants {
  static const String celestrakBaseUrl =
      'https://celestrak.org/NORAD/elements/gp.php';

  // Single-satellite ISS fetch — 3 lines, loads in <1 second
  static const String issTleUrl =
      'https://celestrak.org/NORAD/elements/gp.php?CATNR=25544&FORMAT=TLE';

  static const String launchLibraryBaseUrl = 'https://ll.thespacedevs.com/2.2.0/';
  static const String spaceNewsBaseUrl = 'https://api.spaceflightnewsapi.net/v4/';

  static const String issNoradId = '25544';

  // TLE groups loaded in priority order — earlier groups appear first.
  // Each group is fetched independently and cached for 6 hours.
  static const List<String> tleGroups = [
    'stations',  // space stations (ISS, CSS) — ~5 sats, loads first
    'visual',    // ~100 brightest naked-eye sats
    'weather',   // weather satellites ~30
    'noaa',      // NOAA ~15
    'resource',  // Earth observation ~50
    'sarsat',    // search & rescue ~30
  ];

  static const Duration tleCacheDuration = Duration(hours: 6);
  static const Duration issTleCacheDuration = Duration(hours: 1);
  static const Duration launchCacheDuration = Duration(hours: 1);
  static const Duration newsCacheDuration = Duration(hours: 1);

  static const Duration networkConnectTimeout = Duration(seconds: 15);
  static const Duration networkReceiveTimeout = Duration(seconds: 30);

  // Starred / ISS: fast update; detail screen only, not the catalog list
  static const Duration trackedPositionInterval = Duration(seconds: 15);
  static const Duration issPositionInterval = Duration(seconds: 15);

  // Kept for backward compat — no longer drives list-row updates
  static const Duration satellitePositionInterval = Duration(seconds: 30);

  static const int launchPageSize = 10;
  static const int newsPageSize = 20;
}
