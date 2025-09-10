import 'package:structural_slab_validator/models/slab_type.dart';

class OutputData {
  final SlabType slabType;
  final double thickness;
  final double steelArea;

  OutputData({
    required this.slabType,
    required this.thickness,
    required this.steelArea,
  });

  OutputData copyWith({
    SlabType? slabType,
    double? thickness,
    double? steelArea,
  }) {
    return OutputData(
      slabType: slabType ?? this.slabType,
      thickness: thickness ?? this.thickness,
      steelArea: steelArea ?? this.steelArea,
    );
  }
}
