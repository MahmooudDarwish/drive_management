import 'package:dartz/dartz.dart';
import 'package:driver_management/core/api_constance.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final _googleSignIn = GoogleSignIn(scopes: ApiConstance.scopes);

  late GoogleSignInAccount? user;

  Future<Either<String, GoogleSignInAccount?>> login() async {
    try {
      user = await _googleSignIn.signIn();
      return Right(user);
    } catch (error) {
      return Left("Error ${error.toString()}");
    }
  }

  Future<Either<String, GoogleSignInAccount?>> logout() async {
    try {
      user = await _googleSignIn.disconnect();
      return Right(user);
    } catch (error) {
      return Left("Error ${error.toString()}");
    }
  }
}
