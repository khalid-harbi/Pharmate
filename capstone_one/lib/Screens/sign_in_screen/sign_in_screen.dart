import 'package:capstone_one/Screens/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends HookWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    // To handle loadingIndicator
    final loadingKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          // To handle loadingIndicator
          if (loadingKey.currentContext != null &&
              loadingKey.currentContext!.mounted) {
            context.pop();
          }
          // Determine sign in state
          switch (state) {
            case SignInInitial _:
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
              context.go(RouteKeys.homeScreen);
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
              Text('Welcome Back', style: TextStyle(fontWeight: .bold)),
              Text('Sign in to manage your medicines'),
              Card(
                child: Column(
                  children: [
                    InputFormWidget(
                      title: 'Email',
                      hint: 'Enter your email',
                      controller: emailController,
                    ),
                    InputFormWidget(
                      title: 'Password',
                      hint: 'Enter your password',
                      controller: passwordController,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Align(
                        alignment: .centerEnd,
                        child: Text('Forgot Password?'),
                      ),
                    ),
                    FilledButton(
                      child: Text("Sign In"),
                      onPressed: () {
                        context.read<SignInBloc>().add(
                          SignInRequestEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(onPressed: () {}, child: Text('Sign Up')),
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
