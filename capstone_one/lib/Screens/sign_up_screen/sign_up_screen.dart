import 'package:capstone_one/Screens/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final loadingKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<SignUpBloc, SignUpState>(
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
            case SignUpInitial _:
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
                builder: (context) => Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Text(state.message),
                  ),
                ),
              );
            case ErrorState _:
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Text(state.message),
                  ),
                ),
              );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Logo'),
              Text('Create Account', style: TextStyle(fontWeight: .bold)),
              Text('Join us now to manage your medicines'),
              Card(
                child: Column(
                  children: [
                    InputFormWidget(
                      title: 'Full name',
                      hint: 'Enter your full name',
                      controller: fullNameController,
                    ),
                    InputFormWidget(
                      title: 'Email',
                      hint: 'Enter your email',
                      controller: emailController,
                    ),
                    InputFormWidget(
                      title: 'Password',
                      hint: 'Create a password',
                      controller: passwordController,
                    ),
                    InputFormWidget(
                      title: 'Confirm Password',
                      hint: 'Confirm your password',
                      controller: confirmPasswordController,
                    ),
                    FilledButton(
                      child: Text("Sign Up"),
                      onPressed: () {
                        // We can access SignInBloc because we wrapped SignInScreen
                        // with BlocProvider in route_app
                        context.read<SignUpBloc>().add(
                          SignUpRequestEvent(
                            name: fullNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            context.push(RouteKeys.signInScreen);
                          },
                          child: Text('Sign In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
