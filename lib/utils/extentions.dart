extension DoubleExtension on double {
  bool isApproximatelyEqual(double other, {double epsilon = 0.00001}) {
    return (this - other).abs() < epsilon;
  }
}
