import 'package:fpdart/fpdart.dart';

//! GetIt #1
// Define services
class AuthService {
  Future<Either<String, String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Mock real sign in process by using a token to prove
      // the sign in state (success or fail)
      final String token = "lakdfsjgnlasdf09kjsd-3,kajsdhf94nsdpffuqeb";
      // Mock loading with 2 seconds
      await Future.delayed(Duration(seconds: 2));

      if (email == "ka14x2@gmail.com" && password == "14211421") {
        // Success! (Because it's a Right)
        // and here is the token string to prove it
        return Either.right(token);
      }
      // Fail! (Because it's a Left)
      return Either.left("Invalid email or password. Please try again.");
    } catch (error) {
      return Either.left(
        "Something went wrong while Signing in. Please try again.",
      );
    }
  }
}
