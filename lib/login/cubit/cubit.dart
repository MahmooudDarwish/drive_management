import 'package:driver_management/login/cubit/states.dart';
import 'package:driver_management/services/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/google_service.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(AppInitialState());

  Future<void> loginWithGoogle() async {
    emit(LoginLoadingState());
    final result = await sl<GoogleService>().login();

    result.fold((leftError) {
      emit(LoginErrorState(errorMessage: leftError));
    },
        (rightAccount) {
      emit(LoginSuccessState(googleSignInAccount: rightAccount!));
    });
  }
}
