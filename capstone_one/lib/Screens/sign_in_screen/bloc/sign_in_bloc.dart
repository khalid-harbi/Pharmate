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
    //TODO: understand and explain with comments later
    on<SignInRequestEvent>(signInMethod);
  }

  //-----------------
  //-----------------
  //-----------------

  // Receive fp dart return result here
  //TODO: understand and explain with comments later
  FutureOr<void> signInMethod(
    SignInRequestEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(LoadingState());

    (await authService.signIn(
      email: event.email,
      password: event.password,
    )).fold(
      (onLeft) {
        emit(ErrorState(message: onLeft));
      },
      (onRight) {
        emit(SuccessState());
      },
    );
  }
}
