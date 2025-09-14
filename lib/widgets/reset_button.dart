import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structural_slab_validator/providers/validation.dart';
import 'package:structural_slab_validator/theme/styles.dart';
import 'package:structural_slab_validator/widgets/input_widget.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        for (var controller in controllers) {
          controller.clear();
        }

        ref.read(validationProvider.notifier).reset();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
      child: Text(
        "Reset",
        style: Styles.font20WhiteBold,
      ),
    );
  }
}
