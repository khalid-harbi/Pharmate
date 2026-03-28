import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_one/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService authService;
  SignUpBloc({required this.authService}) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {});
    on<SignUpRequestEvent>(signUpMethod);
  }

  //-----------------
  //-----------------
  //-----------------

  FutureOr<void> signUpMethod(
    // Take event from SignUpRequestEvent
    SignUpRequestEvent event,
    // Take emit from SignUpState
    Emitter<SignUpState> emit,
  ) async {
    // This will be implemented always
    emit(LoadingState());
    // Call fp dart authService signUp method
    (await authService.signUp(
      name: event.name,
      email: event.email,
      password: event.password,
    )).fold(
      // Check returned results from fp dart authService signUp method
      (onLeft) {
        emit(ErrorState(message: onLeft));
      },
      (onRight) {
        emit(SuccessState(message: onRight));
      },
    );
  }
}
