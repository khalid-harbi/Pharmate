import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_one/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService authService;
  //! GetIt #4
  // Received from route_app
  SignInBloc({required this.authService}) : super(SignInInitial()) {
    // Implementation of SignInRequestEvent is separated in signInMethod
    on<SignInRequestEvent>(signInMethod);
  }

  //-----------------
  //-----------------
  //-----------------

  FutureOr<void> signInMethod(
    // Take event from SignInRequestEvent
    SignInRequestEvent event,
    // Take emit from SignInState
    Emitter<SignInState> emit,
  ) async {
    // This will be implemented always
    emit(LoadingState());
    // Call fp dart authService signIn method
    (await authService.signIn(
      email: event.email,
      password: event.password,
    )).fold(
      // Check returned results from fp dart authService signIn method
      (onLeft) {
        emit(ErrorState(message: onLeft));
      },
      (onRight) {
        emit(SuccessState());
      },
    );
  }
}
