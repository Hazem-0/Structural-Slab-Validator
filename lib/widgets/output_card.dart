import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structural_slab_validator/providers/validation.dart';
import 'package:structural_slab_validator/theme/styles.dart';

class OutputCard extends ConsumerWidget {
  const OutputCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validator = ref.watch(validationProvider);

    return Container(
      padding: Styles.paddingLeft20Top10,
      alignment: Alignment.center,
      decoration: Styles.boxDecoration,
      child: GridView.count(
        padding: const EdgeInsets.all(5),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 2,
        crossAxisSpacing: 100,
        mainAxisSpacing: 8,
        childAspectRatio: 5,
        children: [
          Text(
            "Slab Type: ${validator?.slabType.value ?? ''}",
            style: Styles.font20WhiteBold,
          ),
          Text(
            "Slab Thickness: ${validator?.thickness.toStringAsFixed(3) ?? ''}",
            style: Styles.font20WhiteBold,
          ),
          Text(
            "Required Steel Area: ${validator?.steelArea.toStringAsFixed(3) ?? ''}",
            style: Styles.font20WhiteBold,
          ),
        ],
      ),
    );
  }
}
