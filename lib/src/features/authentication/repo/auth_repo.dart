import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nvisust_test/src/services/base_response/base_reponse.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> signIn(String email, String password);

  Future<Either<Failure, bool>> signOut();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class AuthRepoImplements extends AuthRepo {
  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseError(e)));
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseError(e)));
    } catch (e) {
      return Left(Failure(message: "Logout Failed"));
    }
  }

  // Convert FirebaseAuthException codes to user-friendly messages
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "The email address is badly formatted.";
      case 'user-disabled':
        return "This user has been disabled.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";
      case 'email-already-in-use':
        return "This email is already registered.";
      case 'weak-password':
        return "Password should be at least 6 characters.";
      case 'operation-not-allowed':
        return "Email/password accounts are not enabled.";
      default:
        return "Authentication error. Please try again.";
    }
  }
}
