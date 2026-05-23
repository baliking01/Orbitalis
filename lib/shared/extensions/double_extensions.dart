extension DoubleX on double {
  String toFixed(int places) => toStringAsFixed(places);
  String get twoDecimals => toStringAsFixed(2);
  String get oneDecimal => toStringAsFixed(1);
}
