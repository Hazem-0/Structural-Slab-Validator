import 'package:flutter/material.dart';

Widget InputWidget(TextEditingController controller, String hint) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        label: Text(hint),
        filled: true,
        fillColor: Colors.blue[50],
        labelStyle: TextStyle(color: Colors.blue[900]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
       ),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
  );
}

final List<String> hints = <String>[
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
  return InputWidget(controllers[index], hints[index]);
});
