import 'package:driver_management/login/cubit/states.dart';
import 'package:driver_management/services/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../services/google_service.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(AppInitialState());

  late GoogleSignInAccount? user;
  Future<void> loginWithGoogle() async {
    emit(LoginLoadingState());
    final result = await sl<GoogleService>().login();

    result.fold((leftError) {
      emit(LoginErrorState(errorMessage: leftError));
    }, (rightAccount) {
      user = rightAccount;
      emit(LoginSuccessState(googleSignInAccount: rightAccount!));
    });
  }
}
