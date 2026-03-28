import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class InputFormWidget extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  // matchController is to check if password field == confirm password field
  final TextEditingController? matchController;

  const InputFormWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    this.matchController,
  });

  @override
  Widget build(BuildContext context) {
    // Email with specific format using regular expressions
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: TextStyle(fontWeight: .bold)),
          Gap(8),
          TextFormField(
            // Only apply this check if this is a password field
            obscureText: title.contains('Password'),

            // Only apply this check if this is an Email field
            keyboardType: title == 'Email'
                ? TextInputType.emailAddress
                : title == 'Number of Pills'
                ? TextInputType.number
                : TextInputType.text,

            inputFormatters: title == 'Number of Pills'
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],

            controller: controller,

            // Display red validation text
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$title is required';
              }
              // Only apply this check if this is an Email field
              if (title == 'Email') {
                if (!emailRegex.hasMatch(value)) {
                  return 'Invalid email format (e.g., name@example.com)';
                }
              }

              if (title == 'Confirm Password') {
                if (value != matchController!.text) {
                  return 'Password and confirm password must be the same';
                }
              }
              return null;
            },

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
