import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Column(
        children: [Text('Name')],
      ),
    );
  }

  void getUserData() async {
    try {
      final response = await http.get(
        Uri.parse("$apiUrl/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjM3YjM0NGFmMDJhMzM5Y2ZmMWQ5N2IiLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNzE0OTI4MzczLCJleHAiOjE3MTU1MzMxNzN9.aoxmhOVp2UI4EnERd2L_VHGfgsxPWeDdPK0J60sUm-g'

          // Add any additional headers if required
        },
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
}
