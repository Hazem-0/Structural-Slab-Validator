import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structural_slab_validator/providers/input_controller.dart';
import 'package:structural_slab_validator/theme/app_colors.dart';
import 'package:structural_slab_validator/widgets/input_widget.dart';

Widget validatorButton() {
  return Consumer(builder: (context, ref, child) {
    final inputState = ref.read(inputProvider.notifier);
    return ElevatedButton(
      onPressed: () {
        try {
          final values = controllers.map((controller) {
            if (controller.text.isEmpty) {
              throw const FormatException('Input fields cannot be empty');
            }
            return double.parse(controller.text);
          }).toList();
          inputState.update(values: values);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text("Please enter values right or go study again!"),
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonPrimary,
        foregroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: const Text(
        'Validate Design',
        style: TextStyle(fontSize: 18),
      ),
    );
  });
}
