import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InputFormWidget extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  const InputFormWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: TextStyle(fontWeight: .bold)),
          Gap(8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hint,
            ),
            onTapOutside: (value) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ],
      ),
    );
  }
}
