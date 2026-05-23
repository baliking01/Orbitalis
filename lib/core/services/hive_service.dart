import 'package:hive_flutter/hive_flutter.dart';

abstract final class HiveBoxes {
  static const String tle = 'tle_box';
  static const String launches = 'launches_box';
  static const String articles = 'articles_box';
  static const String metadata = 'metadata_box';
}

class HiveService {
  HiveService._();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox<String>(HiveBoxes.tle),
      Hive.openBox<String>(HiveBoxes.launches),
      Hive.openBox<String>(HiveBoxes.articles),
      Hive.openBox<dynamic>(HiveBoxes.metadata),
    ]);
    _initialized = true;
  }

  static Box<String> get tle => Hive.box<String>(HiveBoxes.tle);
  static Box<String> get launches => Hive.box<String>(HiveBoxes.launches);
  static Box<String> get articles => Hive.box<String>(HiveBoxes.articles);
  static Box<dynamic> get metadata => Hive.box<dynamic>(HiveBoxes.metadata);
}
