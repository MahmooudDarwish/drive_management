import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginStates extends Equatable {
  const LoginStates();
}

class AppInitialState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoadingState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginSuccessState extends LoginStates {
  final GoogleSignInAccount googleSignInAccount;
  const LoginSuccessState({required this.googleSignInAccount});
  @override
  // TODO: implement props
  List<Object?> get props => [googleSignInAccount];
}

class LoginErrorState extends LoginStates {
  final String errorMessage;
  const LoginErrorState({required this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
