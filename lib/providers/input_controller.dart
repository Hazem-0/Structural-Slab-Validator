import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structural_slab_validator/models/input_data.dart';

class InputController extends StateNotifier<InputData> {
  InputController()
      : super(InputData(
          longSpan: 0,
          shortSpan: 0,
          concreteStrength: 0,
          steelStrength: 0,
          liveLoad: 0,
          finishingConstant: 0,
          momentFactor: 0,
          momentPrimeFactor: 0,
        ));

  void update({required List<double> values}) {
    state = state.copyWith(
      longSpan: values[0],
      shortSpan: values[1],
      concreteStrength: values[2],
      steelStrength: values[3],
      liveLoad: values[4],
      finishingConstant: values[5],
      momentFactor: values[6],
      momentPrimeFactor: values[7],
    );
  }
}

final inputProvider = StateNotifierProvider<InputController, InputData>((ref) {
  return InputController();
});
