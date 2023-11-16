import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastState { error, success, warning }

Color chooseToastColor({required ToastState state}) {
  Color color;
  switch (state) {
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast({required String? message, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: message ?? "Something went wrong",
        /* if we want to make it ""msg: state.loginUser?.message"" without ""?? "Something went wrong"""
                  we need to declare message as dynamic not string? */
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: chooseToastColor(state: state),
        textColor: Colors.white,
        fontSize: 20.0);

