import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  void showSnackbar(
      BuildContext context, String message, Color color, Color fontColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: fontColor),
        ),
        backgroundColor: color,
        duration: const Duration(
            seconds: 3), // Duration for which the snackbar is displayed
      ),
    );
  }
}
