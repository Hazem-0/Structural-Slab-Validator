import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structural_slab_validator/providers/validation.dart';
import 'package:structural_slab_validator/theme/app_colors.dart';
import 'package:structural_slab_validator/widgets/input_widget.dart';
import 'package:structural_slab_validator/widgets/output_card.dart';
import 'package:structural_slab_validator/widgets/validator_button.dart';

class SSVScreen extends StatelessWidget {
  const SSVScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.surfaceLight,
        title: const Text("Solid Slab Design"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Consumer(
              builder: (context ,ref , child) {
                final validator = ref.watch(validationProvider);
                return Column(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        childAspectRatio: constraints.maxWidth > 600 ? 4 : 3,
                      ),
                      itemBuilder: (context, index) => Container(
                        child: textFields[index],
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.8,
                      child: Consumer(builder: (context, ref, child) {
                        return validatorButton();
                      }),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                   (validator!=null)? SizedBox(
                      width: constraints.maxWidth * 0.9,
                      height: constraints.maxHeight * 0.4,
                      child: const OutputCard(),
                    ):const SizedBox(),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                  ],
                );
              }
            ),
          );
        },
      ),
    );
  }
}
