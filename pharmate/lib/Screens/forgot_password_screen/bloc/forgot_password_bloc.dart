import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_one/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthService authService;
  ForgotPasswordBloc({required this.authService})
    : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequestEvent>(forgotPasswordMethod);
  }

  FutureOr<void> forgotPasswordMethod(
    // Take event from ForgotPasswordRequestEvent
    ForgotPasswordRequestEvent event,
    // Take emit from ForgotPasswordState
    Emitter<ForgotPasswordState> emit,
  ) async {
    // This will be implemented always
    emit(LoadingState());
    // Call fp dart authService forgotPasswordMethod method

    // .fold() takes two functions, (onLeftFunction, onRightFunction)
    // The first function runs if the result is Left
    // The second function runs if the result is Right
    // wait until authService.signIn execution then check returned results
    (await authService.forgotPassword(email: event.email)).fold(
      // Check returned results from fp dart authService forgotPasswordMethod method
      //# First function
      (onLeft) {
        emit(ErrorState(message: onLeft));
      },
      //# Second function
      (onRight) {
        emit(SuccessState(message: onRight));
      },
    );
  }
}
