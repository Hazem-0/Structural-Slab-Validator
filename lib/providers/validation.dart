// ignore_for_file: unnecessary_null_comparison

import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structural_slab_validator/models/out_data.dart';
import 'package:structural_slab_validator/models/slab_type.dart';
import 'package:structural_slab_validator/providers/input_controller.dart';

class ValidationNotifier extends StateNotifier<OutputData?> {
  ValidationNotifier(this._ref) : super(null);

  final Ref _ref;

  late double _r;
  late SlabType _slabType;
  late double _ts;
  late double _ultimateLoad;
  late double _moment;
  late double _effectiveDepth;
  late double _steelArea;

  void displayOutput() {
    final inputState = _ref.read(inputProvider);
    if (inputState == null) return;

    _slapClassification();
    _validate();
    _loadAnalysis();
    _momentCalculations();
    _structuralAnalysis();
    _steelReinforcementDesign();

    state = OutputData(
      slabType: _slabType,
      thickness: _ts,
      steelArea: _steelArea,
    );
  }

  void reset() {
    state = null;
  }

  void _slapClassification() {
    final input = _ref.read(inputProvider);
    _r = (input.momentFactor! * input.longSpan!) /
        (input.momentPrimeFactor! * input.shortSpan!);

    if (_r > 2) {
      _slabType = SlabType.oneWay;
    } else if (_r < 2) {
      _slabType = SlabType.twoWay;
    } else {
      _slabType = SlabType.invalid;
    }
  }

  void _validate() {
    switch (_slabType) {
      case SlabType.oneWay:
        _validateOneWaySlab();
        break;
      case SlabType.twoWay:
        _validateTwoWaySlab();
        break;
      case SlabType.invalid:
        break;
    }
  }

  void _validateOneWaySlab() {
    final input = _ref.read(inputProvider);
    _ts = input.shortSpan! / 28;
  }

  void _validateTwoWaySlab() {
    final input = _ref.read(inputProvider);
    final numerator = input.shortSpan! * (0.85 + input.steelStrength! / 1600);
    final denominator = 15 + (25 * input.shortSpan! / input.longSpan!) + 5;
    _ts = numerator / denominator;
  }

  void _loadAnalysis() {
    final input = _ref.read(inputProvider);
    final deadLoad = (_ts * 25) + input.finishingConstant!;
    _ultimateLoad = 1.5 * (deadLoad + input.liveLoad!);
  }

  void _momentCalculations() {
    switch (_slabType) {
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
    final input = _ref.read(inputProvider);
    _moment = (_ultimateLoad * input.shortSpan! * input.shortSpan!) / 8;
  }

  void _twoWaySlabCalculation() {
    final input = _ref.read(inputProvider);
    final alpha = 0.5 * _r - 0.15;
    final beta = 0.35 / (_r * _r);

    final wusLs = alpha * _ultimateLoad;
    final wusL = beta * _ultimateLoad;

    final momentShortSpan = (wusLs * input.shortSpan! * input.shortSpan!) / 8;
    final momentLongSpan = (wusL * input.longSpan! * input.longSpan!) / 8;

    _moment = max(momentShortSpan, momentLongSpan);
  }

  void _structuralAnalysis() {
    final input = _ref.read(inputProvider);
    _effectiveDepth = (_ts * 1000) - 20;

    final ru = (_moment * 1000000) / (1000 * _effectiveDepth * _effectiveDepth);
    final rootTerm = 1 - ((3 * 1.5 * ru) / input.concreteStrength!);

    final meu = (0.67 * input.concreteStrength! / 1.5) *
        (1.15 / input.steelStrength!) *
        (1 - sqrt(rootTerm));

    final menuMin = max(0.6 / input.steelStrength!, 0.0015);
    final reinforcementRatio = max(meu, menuMin);

    _steelArea = reinforcementRatio * 1000 * _effectiveDepth;
  }

  void _steelReinforcementDesign() {
    _steelArea = _steelArea;
  }
}

final validationProvider =
    StateNotifierProvider<ValidationNotifier, OutputData?>((ref) {
  return ValidationNotifier(ref);
});
