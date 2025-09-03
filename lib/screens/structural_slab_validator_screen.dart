import 'package:flutter/material.dart';
import 'package:structural_slab_validator/widgets/input_widget.dart';
import 'package:structural_slab_validator/widgets/validator_button.dart';

class SSVScreen extends StatelessWidget {

  SSVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 210, 255),
        title: const Text("Structural Slab Validator"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
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
                const SizedBox(height: 20),
                ValidatorButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
