import 'package:driver_management/core/toasts.dart';
import 'package:driver_management/files_data/files_data.dart';
import 'package:driver_management/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showToast(message: "Login Successfully", state: ToastState.success);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) //predicateRoute
              {
                return false;
              },
            );
          } else if (state is LoginErrorState) {
            showToast(message: state.errorMessage, state: ToastState.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: SignInButton(Buttons.Google,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ), onPressed: () {
                    sl<LoginCubit>().loginWithGoogle();
                  }),
                ),
              ));
        },
      ),
    );
  }
}
