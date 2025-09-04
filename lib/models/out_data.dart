class OutputData {
  final double reinforcementRatio;
  final double effectiveDepth;
  final double? steelArea;
  final double? barDiameter;
  final int? numberOfBars;

  OutputData({
    required this.reinforcementRatio,
    required this.effectiveDepth,
    this.steelArea,
    this.barDiameter,
    this.numberOfBars,
  });

  OutputData copyWith({
    double? reinforcementRatio,
    double? effectiveDepth,
    double? steelArea,
    double? barDiameter,
    int? numberOfBars,
  }) {
    return OutputData(
      reinforcementRatio: reinforcementRatio ?? this.reinforcementRatio,
      effectiveDepth: effectiveDepth ?? this.effectiveDepth,
      steelArea: steelArea ?? this.steelArea,
      barDiameter: barDiameter ?? this.barDiameter,
      numberOfBars: numberOfBars ?? this.numberOfBars,
    );
  }
}
