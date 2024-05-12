import 'package:auth_with_nodejs/services/http/http_services.dart';

class AuthServices {
  Future<dynamic> onSignUp(
    String email,
    String password,
    String name,
  ) async {
    const apiUrl = 'api/signup';

    try {
      final signUpResponse = await HttpServices().post(
          apiUrl: apiUrl,
          headers: HttpServices.headerWithoutAccessToken(),
          body: {"userName": name, "email": email, "password": password});

      return signUpResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> onLoginUser(String email, String password) async {
    const apiUrl = 'api/login';

    try {
      final response = await HttpServices().post(
          apiUrl: apiUrl,
          headers: HttpServices.headerWithoutAccessToken(),
          body: {
            "email": email,
            "password": password,
          });

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
