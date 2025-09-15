import 'package:flutter/material.dart';
import 'package:structural_slab_validator/theme/app_colors.dart';
import 'package:structural_slab_validator/theme/styles.dart';

Widget inputWidget(TextEditingController controller, String hint) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      label: Text(hint),
      filled: true,
      fillColor: AppColors.primaryLight,
      labelStyle: Styles.font14WhiteBold,
      border: Styles.border,
      enabledBorder: Styles.border,
      focusedBorder: Styles.focusedBorder,
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
