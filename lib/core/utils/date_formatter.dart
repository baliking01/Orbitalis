import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static String relativeCountdown(DateTime target) {
    final diff = target.difference(DateTime.now());
    if (diff.isNegative) return 'Launched';

    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    final minutes = diff.inMinutes.remainder(60);

    if (days > 0) return 'in ${days}d ${hours}h ${minutes}m';
    if (hours > 0) return 'in ${hours}h ${minutes}m';
    return 'in ${minutes}m';
  }

  static String countdown(DateTime target) {
    final diff = target.difference(DateTime.now());
    if (diff.isNegative) return 'T+${_format(diff.abs())}';
    return 'T-${_format(diff)}';
  }

  static String _format(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inDays}d $h:$m:$s';
  }

  static String shortDate(DateTime dt) =>
      DateFormat('dd MMM yyyy').format(dt);

  static String shortDateTime(DateTime dt) =>
      DateFormat('dd MMM HH:mm').format(dt.toLocal());
}
