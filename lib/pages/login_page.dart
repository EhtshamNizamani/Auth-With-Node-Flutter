import 'dart:convert';

import 'package:auth_with_nodejs/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String apiUrl = 'http://192.168.100.228:3500';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  void onLogin() async {
    try {
      print(name.text);

      final response = await http.post(Uri.parse("$apiUrl/user/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // Add any additional headers if required
          },
          body: jsonEncode({"email": email.text, "password": password.text}));

      if (response.statusCode == 200) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HomePage()));

        print("Login successful");
        print(json.decode(response.body));
        // Handle success response here (e.g., navigate to next screen)
      } else {
        print("Failed to Login. Status code: ${response.statusCode}");
        print(json.decode(response.body));
        // Handle error response here (e.g., show error message)
      }
    } catch (e) {
      print(e);
    }
  }

  void onRegister() async {
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/user/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // Add any additional headers if required
        },
        body: jsonEncode({
          "name": name.text,
          "email": email.text,
          "password": password.text,
        }),
      );
      if (response.statusCode == 200) {
        print("Registration successful");
        print(json.decode(response.body));
        // Handle success response here (e.g., navigate to next screen)
      } else {
        print("Failed to register. Status code: ${response.statusCode}");
        print(json.decode(response.body));
        // Handle error response here (e.g., show error message)
      }
    } catch (e) {
      print("Error occurred: $e");
      // Handle network or server errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(hintText: 'name'),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(
              hintText: 'password',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                onLogin();
              },
              child: const Text("login"))
        ],
      ),
    );
  }
}
