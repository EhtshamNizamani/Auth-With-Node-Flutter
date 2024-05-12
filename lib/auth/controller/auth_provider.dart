import 'package:auth_with_nodejs/home/view/home_page.dart';
import 'package:auth_with_nodejs/services/auth/auth.dart';
import 'package:auth_with_nodejs/services/shared_preff/shared_preff_services.dart';
import 'package:auth_with_nodejs/services/toast_message/toast.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void onLogin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await AuthServices().onLoginUser(email.text, password.text);

      await SharePreServices.saveAccessToken(res['token']);
      _isLoading = false;
      notifyListeners();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      print(e.toString());
      String errorMessage = e.toString().split(": ")[1];
      CustomToast()
          .showSnackbar(context, errorMessage, Colors.red, Colors.white);
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  void onRegister() async {
    _isLoading = true;
    notifyListeners();

    try {
      await AuthServices().onSignUp(email.text, password.text, name.text);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error occurred: $e");
      // Handle network or server errors here
    }
  }

  void toggleButton() {
    _isLogin = !_isLogin;
    print(_isLogin);
    notifyListeners();
  }

  //  void getUserData() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("$apiUrl/"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization':
  //             'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjM3YjM0NGFmMDJhMzM5Y2ZmMWQ5N2IiLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNzE0OTI4MzczLCJleHAiOjE3MTU1MzMxNzN9.aoxmhOVp2UI4EnERd2L_VHGfgsxPWeDdPK0J60sUm-g'

  //         // Add any additional headers if required
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print("Registration successful");
  //       print(json.decode(response.body));
  //       // Handle success response here (e.g., navigate to next screen)
  //     } else {
  //       print("Failed to register. Status code: ${response.statusCode}");
  //       print(json.decode(response.body));
  //       // Handle error response here (e.g., show error message)
  //     }
  //   } catch (e) {
  //     print("Error occurred: $e");
  //     // Handle network or server errors here
  //   }
  // }
}
