import 'package:flutter/material.dart';
import 'package:structural_slab_validator/theme/app_colors.dart';

Widget inputWidget(TextEditingController controller, String hint) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      label: Text(hint),
      filled: true,
      fillColor: AppColors.primaryLight,
      labelStyle: const TextStyle(color: AppColors.primary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderDefault),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderDefault),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderFocused, width: 2),
      ),
    ),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
  );
}

const List<String> hints = <String>[
  "L",
  "Ls",
  "Fcu",
  "Fy",
  "L.L",
  "F.c",
  "m",
  "m`",
];

final List<TextEditingController> controllers =
    List.generate(8, (_) => TextEditingController());

final List<Widget> textFields = List.generate(8, (index) {
  return inputWidget(controllers[index], hints[index]);
});
