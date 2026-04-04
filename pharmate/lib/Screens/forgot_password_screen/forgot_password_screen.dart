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

    //! I had to search for this
    // useMemoized so the key doesn't get destroyed (changed) with every rebuild
    // Remember and save the unique formKey
    // If the screen rebuilds and the key changes, the new form starts completely fresh
    // The red error text will vanish, even if the user hasn't fixed the format yet
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(),
      // Purpose: React to state changes without rebuilding UI
      // Trigger actions (side effects) without rebuilding UI
      // Used here for pop loading, showDialog, navigation
      // BlocListener can't return UI widgets
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
                // set a context in build context
                context: context,
                // used to access and represent the location of the widget in the widget tree
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
                Form(
                  key: formKey,
                  child: Card(
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
                              // Access formKey currentState to check if all fields pass validation
                              // This triggers 'validator' in every InputFormWidget
                              // It returns 'true' ONLY if no fields return red error text
                              if (formKey.currentState!.validate()) {
                                context.read<ForgotPasswordBloc>().add(
                                  ForgotPasswordRequestEvent(
                                    email: emailController.text,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
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
