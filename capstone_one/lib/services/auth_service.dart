import 'package:fpdart/fpdart.dart';

//! GetIt #1
// Define services
class AuthService {
  // A list of maps with keys and values (name, email, password)
  final List<Map<String, String>> accounts = [];

  // ---------------------
  // ---------------------
  // ---------------------

  Future<Either<String, String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Mock real sign in process by using a token to prove
      // the sign in state (success or fail)
      final String token = "signinlakdfsjgnlasdf09kjsd-3,kajsdhf94nsdpffuqeb";

      // Mock loading with 2 seconds
      await Future.delayed(Duration(seconds: 2));

      // Check account email and password
      // is it stored in accounts[] ?
      for (var account in accounts) {
        if (email == account['email'] && password == account['password']) {
          // Success! (Because it's a Right)
          // and here is the token string to prove it
          return Either.right(token);
        }
      }

      // Fail! (Because it's a Left)
      return Either.left("Invalid email or password. Please try again.");
    } catch (error) {
      return Either.left(
        "Something went wrong while Signing in. Please try again.",
      );
    }
  }

  // ---------------------
  // ---------------------
  // ---------------------

  Future<Either<String, String>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Mock loading with 2 seconds
      await Future.delayed(Duration(seconds: 2));

      // Check if this account already exists by email
      if (accounts.any((account) => email == account['email'])) {
        // Fail! (Because it's a Left)
        return Either.left("This account already exists. Please try again.");
      }
      // Account does not exist
      // Add to accounts
      accounts.add({"name": name, "email": email, "password": password});
      // Success! (Because it's a Right)
      return Either.right('Account created successfully. You can now sign in.');
    } catch (error) {
      return Either.left(
        "Something went wrong while Signing up. Please try again.",
      );
    }
  }
}
