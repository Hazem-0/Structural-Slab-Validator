import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structural_slab_validator/models/out_data.dart';
import 'package:structural_slab_validator/providers/input_controller.dart';

class ValidationNotifier extends StateNotifier<OutputData?> {
  ValidationNotifier(this.ref) : super(null);

  Ref ref;
  double? r;
  String? slapType;
  double? ts;
  double? numerator;
  double? denominator;
  double? deadLoad;
  double? ultimateLoad;
  double? moment;
  double? alpha;
  double? beta;
  double? wusLs;
  double? wusL;
  double? momentShortSpan;
  double? momentLongSpan;
  double? effectiveDepth;
  double? ru;
  double? rootTerm;
  double? meu;
  double? menuMin;
  double? as_;
  double? barDiameter;
  int? numberofBars;
  void slapClassification() {
    final state = ref.read(inputProvider);
    r = (state.momentFactor! * state.longSpan!) /
        (state.momentPrimeFactor! * state.shortSpan!);
    if (r! > 2) {
      slapType = "One way slab";
    } else if (r! < 2) {
      slapType = "Two way slab";
    } else {
      slapType = "Invalid design";
    }
  }

  void validate() {
    slapClassification();
    switch (slapType) {
      case "One way slab":
        _validateOneWaySlab();
        break;
      case "Two way slab":
        _validateTwoWaySlab();
        break;
    }
  }

  void _validateOneWaySlab() {
    final state = ref.read(inputProvider);
    ts = state.shortSpan! / 28;
  }

  void _validateTwoWaySlab() {
    final state = ref.read(inputProvider);
    numerator = state.shortSpan! * (0.85 + state.steelStrength! / 1600);

    denominator = 15 + (25 * state.shortSpan! / state.longSpan!) + 5;

    ts = numerator! / denominator!;
  }

  void loadAnalysis() {
    final state = ref.read(inputProvider);
    deadLoad = (ts! * 25) + state.finishingConstant!;
    ultimateLoad = 1.5 * (deadLoad! + state.liveLoad!);
  }

  void momentCalculations() {
    switch (slapType) {
      case "One Way Slab":
        _oneWaySlabCalculation();
        break;
      case "Two Way Slab":
        _twoWaySlabCalculation();
        break;
    }
  }

  void _oneWaySlabCalculation() {
    final state = ref.read(inputProvider);
    moment = (ultimateLoad! * state.shortSpan! * state.shortSpan!) / 8;
  }

  void _twoWaySlabCalculation() {
    final state = ref.read(inputProvider);
    alpha = 0.5 * r! - 0.15;
    beta = 0.35 / (r! * r!);

    wusLs = alpha! * ultimateLoad!;
    wusL = beta! * ultimateLoad!;

    momentShortSpan = (wusLs! * state.shortSpan! * state.shortSpan!) / 8;

    momentLongSpan = (wusL! * state.longSpan! * state.longSpan!) / 8;

    moment = max(momentShortSpan!, momentLongSpan!);
  }

  void structuralAnalysis() {
    final state = ref.read(inputProvider);

    effectiveDepth = (ts! * 1000) - 20;

    ru = (moment! * 1000000) / (1000 * effectiveDepth! * effectiveDepth!);

    rootTerm = 1 - ((3 * 1.5 * ru!) / state.concreteStrength!);
    meu = (0.67 * state.concreteStrength! / 1.5) *
        (1.15 / state.steelStrength!) *
        (1 - sqrt(rootTerm!));

    menuMin = max(0.6 / state.steelStrength!, 0.0015);
    meu = max(meu!, menuMin!);
  }

  void steelReinforcementDesign() {
    as_ = meu! * 1000 * effectiveDepth!;
    double barArea;
    if (as_! <= 500) {
      barDiameter = 10;
       barArea = pi * pow(10 / 2, 2);
    } else {
      barDiameter = 12;
       barArea = pi * pow(12 / 2, 2);
    }
    numberofBars = (as_! / barArea).ceil();
  }
}

final validationProvider =
    StateNotifierProvider<ValidationNotifier, OutputData?>((ref) {
  return ValidationNotifier(ref);
});
