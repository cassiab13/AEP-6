import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class HttpServiceWrapper<T> {
  final String baseUrl;
  final String endpoint;

  HttpServiceWrapper({required this.baseUrl, required this.endpoint});

  T fromJson(Map<String, dynamic> json);

  Future<T> get({Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        return fromJson(json);
      } else {
        throw Exception('Erro ao realizar GET: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao realizar GET: $e');
    }
  }
}
