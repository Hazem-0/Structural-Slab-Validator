import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structural_slab_validator/models/out_data.dart';
import 'package:structural_slab_validator/models/slab_type.dart';
import 'package:structural_slab_validator/providers/input_controller.dart';

class ValidationNotifier extends StateNotifier<OutputData?> {
  ValidationNotifier(this.ref) : super(null);

  final Ref ref;

  late double r;
  late SlabType slabType;
  late double ts;
  late double ultimateLoad;
  late double moment;
  late double effectiveDepth;

  void slapClassification() {
    final state = ref.read(inputProvider);
    r = (state.momentFactor! * state.longSpan!) /
        (state.momentPrimeFactor! * state.shortSpan!);
    if (r > 2) {
      slabType = SlabType.oneWay;
    } else if (r < 2) {
      slabType = SlabType.twoWay;
    } else {
      slabType = SlabType.invalid;
    }
  }

  void validate() {
    slapClassification();
    switch (slabType) {
      case SlabType.oneWay:
        _validateOneWaySlab();
        break;
      case SlabType.twoWay:
        _validateTwoWaySlab();
        break;
      case SlabType.invalid:
        // Handle invalid case
        break;
    }
  }

  void _validateOneWaySlab() {
    final state = ref.read(inputProvider);
    ts = state.shortSpan! / 28;
  }

  void _validateTwoWaySlab() {
    final state = ref.read(inputProvider);
    final numerator = state.shortSpan! * (0.85 + state.steelStrength! / 1600);
    final denominator = 15 + (25 * state.shortSpan! / state.longSpan!) + 5;
    ts = numerator / denominator;
  }

  void loadAnalysis() {
    final state = ref.read(inputProvider);
    final deadLoad = (ts * 25) + state.finishingConstant!;
    ultimateLoad = 1.5 * (deadLoad + state.liveLoad!);
  }

  void momentCalculations() {
    switch (slabType) {
      case SlabType.oneWay:
        _oneWaySlabCalculation();
        break;
      case SlabType.twoWay:
        _twoWaySlabCalculation();
        break;
      case SlabType.invalid:
        break;
    }
  }

  void _oneWaySlabCalculation() {
    final state = ref.read(inputProvider);
    moment = (ultimateLoad * state.shortSpan! * state.shortSpan!) / 8;
  }

  void _twoWaySlabCalculation() {
    final state = ref.read(inputProvider);
    final alpha = 0.5 * r - 0.15;
    final beta = 0.35 / (r * r);

    final wusLs = alpha * ultimateLoad;
    final wusL = beta * ultimateLoad;

    final momentShortSpan = (wusLs * state.shortSpan! * state.shortSpan!) / 8;
    final momentLongSpan = (wusL * state.longSpan! * state.longSpan!) / 8;

    moment = max(momentShortSpan, momentLongSpan);
  }

  void structuralAnalysis() {
    final inputState = ref.read(inputProvider);
    effectiveDepth = (ts * 1000) - 20;

    final ru = (moment * 1000000) / (1000 * effectiveDepth * effectiveDepth);
    final rootTerm = 1 - ((3 * 1.5 * ru) / inputState.concreteStrength!);

    final meu = (0.67 * inputState.concreteStrength! / 1.5) *
        (1.15 / inputState.steelStrength!) *
        (1 - sqrt(rootTerm));

    final menuMin = max(0.6 / inputState.steelStrength!, 0.0015);
    state = OutputData(
      reinforcementRatio: max(meu, menuMin),
      effectiveDepth: effectiveDepth,
    );
  }

  void steelReinforcementDesign() {
    if (state == null) return;

    final as_ = state!.reinforcementRatio * 1000 * state!.effectiveDepth;
    double barDiameter;
    double barArea;

    if (as_ <= 500) {
      barDiameter = 10;
      barArea = pi * pow(10 / 2, 2);
    } else {
      barDiameter = 12;
      barArea = pi * pow(12 / 2, 2);
    }

    final numberOfBars = (as_ / barArea).ceil();

    state = OutputData(
      reinforcementRatio: state!.reinforcementRatio,
      effectiveDepth: state!.effectiveDepth,
      steelArea: as_,
      barDiameter: barDiameter,
      numberOfBars: numberOfBars,
    );
  }
}

final validationProvider =
    StateNotifierProvider<ValidationNotifier, OutputData?>((ref) {
  return ValidationNotifier(ref);
});
