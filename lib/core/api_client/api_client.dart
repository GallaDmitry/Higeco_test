import 'dart:convert';

import 'package:higeco_test/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String url = 'https://testing.higeco.com/api/v2/';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'authorization': HigecoSharedPreferences.getAuthToken() ?? '',
  };

  Future<dynamic> get(String endpoint, [Map<String, dynamic> query = const {}]) async {
    Uri uri = Uri.parse('$url$endpoint').replace(queryParameters: query);
    http.Response response = await http.get(uri, headers: headers);
    return handleResponse(response);
  }
  Future<dynamic> post(String endpoint, [Map<String, String>? body = const {}]) async {
    http.Response response = await http.post(Uri.parse('$url$endpoint'), headers: headers, body: jsonEncode(body));
    return handleResponse(response);
  }

  Future<dynamic> handleResponse(http.Response response) async {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data with status code: ${response.statusCode}, body: ${response.body}');
    }
  }
}
