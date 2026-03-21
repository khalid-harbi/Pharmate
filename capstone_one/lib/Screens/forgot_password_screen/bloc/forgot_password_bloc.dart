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
    on<ForgotPasswordEvent>((event, emit) {});
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
    (await authService.forgotPassword(email: event.email)).fold(
      // Check returned results from fp dart authService forgotPasswordMethod method
      (onLeft) {
        emit(ErrorState(message: onLeft));
      },
      (onRight) {
        emit(SuccessState(message: onRight));
      },
    );
  }
}
