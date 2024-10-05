import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpServiceWrapper {
  final String baseUrl;

  HttpServiceWrapper({required this.baseUrl});

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao realizar GET: $e');
    }
  }

  Future<dynamic> post(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        body: jsonEncode(body),
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao realizar POST: $e');
    }
  }
}
