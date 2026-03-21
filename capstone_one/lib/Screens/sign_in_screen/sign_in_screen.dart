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

    //! I had to search for this
    // useMemoized so the key doesn't get destroyed (changed) with every rebuild
    // Remember and save the formKey
    // If the screen rebuilds and the key changes, the new form starts completely fresh
    // The red error text will vanish, even if the user hasn't fixed the format yet
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(),
      // Purpose: React to state changes without rebuilding UI
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          // To handle loadingIndicator
          if (loadingKey.currentContext != null &&
              // .mounted means triggered currently on the screen
              loadingKey.currentContext!.mounted) {
            // Remove from screen
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
                child: Form(
                  key: formKey,
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
                      Align(
                        alignment: .centerEnd,
                        child: TextButton(
                          onPressed: () {
                            context.push(RouteKeys.forgotPasswordScreen);
                          },
                          child: Text('Forgot Password?'),
                        ),
                      ),
                      FilledButton(
                        child: Text("Sign In"),
                        onPressed: () {
                          // This triggers 'validator' in every InputFormWidget
                          // It returns 'true' ONLY if no fields return red error text
                          if (formKey.currentState!.validate()) {
                            // We can access SignInBloc because we wrapped SignInScreen
                            // with BlocProvider in route_app
                            context.read<SignInBloc>().add(
                              SignInRequestEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              context.push(RouteKeys.signUpScreen);
                            },
                            child: Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
