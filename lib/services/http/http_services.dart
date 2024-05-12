// http get, put, post

import 'dart:convert';
import 'package:auth_with_nodejs/global.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class HttpServices {
  //HTTP GET method
  final baseUrl = Global.apiUrl;
  Future<dynamic> get(
      {required String apiUrl,
      required Map<String, String> headers,
      Map<String, dynamic>? query}) async {
    Map<String, dynamic> queryParams = {};

    if (query != null) {
      queryParams = query;
    }
    final tempUrl = baseUrl + apiUrl;

    Uri uri = Uri.parse(tempUrl).replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: headers);
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      String errorMessage = responseData.toString();
      throw Exception(errorMessage);
    }
  }

  Future<dynamic> post(
      {required String apiUrl,
      required Map<String, String> headers,
      required Map<String, dynamic> body,
      Map<String, dynamic>? query}) async {
    Map<String, dynamic> queryParams = {};

    if (query != null) {
      queryParams = query;
    }

    final tempUrl = baseUrl + apiUrl;
    Uri uri = Uri.parse(tempUrl).replace(queryParameters: queryParams);
    final response = await http.post(Uri.parse(uri.toString()),
        headers: headers, body: json.encode(body));
    if (kDebugMode) {
      print(response.statusCode);
      print(json.decode(response.body));
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (kDebugMode) {
        print('success');
      }
      return json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      String errorMessage = responseData['error'];
      throw Exception(errorMessage);
    }
  }

  Future<dynamic> delete({
    required String apiUrl,
    required Map<String, String> headers,
  }) async {
    final response =
        await http.delete(Uri.parse(baseUrl + apiUrl), headers: headers);
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('success');
      }
      return json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      String errorMessage = responseData.toString();

      throw Exception(errorMessage);
    }
  }

  Future<dynamic> put({
    required String apiUrl,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
  }) async {
    final response = await http.put(Uri.parse(baseUrl + apiUrl),
        headers: headers, body: json.encode(body));

    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      String errorMessage = responseData.toString();
      throw Exception(errorMessage);
    }
  }

  Future<dynamic> patch({
    required String apiUrl,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
  }) async {
    final response = await http.patch(Uri.parse(baseUrl + apiUrl),
        headers: headers, body: json.encode(body));

    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      String errorMessage = responseData['message'];
      throw Exception(errorMessage);
    }
  }

  Future<dynamic> postUserData(
      {required String apiUrl,
      required Map<String, String> headers,
      required Map<String, dynamic> body}) async {
    final response = await http.post(Uri.parse(baseUrl + apiUrl),
        headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('success');
      }

      return json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      String errorMessage = responseData.toString();
      if (kDebugMode) {
        print(errorMessage);

        print(response.statusCode);
      }

      throw Exception(errorMessage);
    }
  }

  static Map<String, String> headerWithoutAccessToken() {
    return {
      'content-type': 'application/json; charset=utf-8',
      'access-control-allow-credentials': 'true',
      'access-control-allow-origin': '*',
      'connection': 'keep-alive',
      'server': 'nginx/1.24.0',
    };
  }

  static Map<String, String> headerWithAccessToken(String accessToken) {
    print(accessToken);
    return {
      'authorization': accessToken,
      'content-type': 'application/json; charset=utf-8',
      'access-control-allow-credentials': 'true',
      'access-control-allow-origin': '*',
      'connection': 'keep-alive',
      'server': 'nginx/1.24.0',
    };
  }
}
