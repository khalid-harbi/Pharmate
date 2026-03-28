import 'package:any_image_view/any_image_view.dart';
import 'package:capstone_one/Screens/forgot_password_screen/bloc/forgot_password_bloc.dart';
import 'package:capstone_one/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends HookWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final loadingKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          // To handle loadingIndicator
          if (loadingKey.currentContext != null &&
              // .mounted means triggered currently on the screen
              loadingKey.currentContext!.mounted) {
            // Remove from screen
            context.pop();
          }

          // Determine sign up state
          switch (state) {
            case ForgotPasswordInitial _:
              break;
            case LoadingState _:
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    // Set loadingKey to this Center widget
                    Center(key: loadingKey, child: CircularProgressIndicator()),
              );
              break;
            case SuccessState _:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Succeeded'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            case ErrorState _:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Failed'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AnyImageView(
                  imagePath: 'assets/images/Phramate-logo.png',
                  width: 100,
                  height: 100,
                ),
                Gap(16),
                Text(
                  'Forgot Password?',
                  style: TextStyle(fontWeight: .bold, fontSize: 24),
                ),
                Gap(8),
                Text(
                  'Enter your email to receive a reset link',
                  style: TextStyle(fontSize: 16),
                ),
                Gap(32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        InputFormWidget(
                          title: 'Email',
                          hint: 'Enter your email',
                          controller: emailController,
                        ),

                        FilledButton(
                          child: Text("Send reset link"),
                          onPressed: () {
                            context.read<ForgotPasswordBloc>().add(
                              ForgotPasswordRequestEvent(
                                email: emailController.text,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
