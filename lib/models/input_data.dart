class InputData {
  final double? longSpan;
  final double? shortSpan;
  final double? concreteStrength;
  final double? steelStrength;
  final double? liveLoad;
  final double? finishingConstant;
  final double? momentFactor;
  final double? momentPrimeFactor;

  InputData({
    this.longSpan,
    this.shortSpan,
    this.concreteStrength,
    this.steelStrength,
    this.liveLoad,
    this.finishingConstant,
    this.momentFactor,
    this.momentPrimeFactor,
  });

  InputData copyWith({
    double? longSpan,
    double? shortSpan,
    double? concreteStrength,
    double? steelStrength,
    double? liveLoad,
    double? finishingConstant,
    double? momentFactor,
    double? momentPrimeFactor,
  }) {
    return InputData(
      longSpan: longSpan ?? this.longSpan,
      shortSpan: shortSpan ?? this.shortSpan,
      concreteStrength: concreteStrength ?? this.concreteStrength,
      steelStrength: steelStrength ?? this.steelStrength,
      liveLoad: liveLoad ?? this.liveLoad,
      finishingConstant: finishingConstant ?? this.finishingConstant,
      momentFactor: momentFactor ?? this.momentFactor,
      momentPrimeFactor: momentPrimeFactor ?? this.momentPrimeFactor,
    );
  }
}
