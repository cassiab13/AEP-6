
import 'dart:convert';

import 'package:gerenciador_mensagens/model/validation.dart';
import 'package:gerenciador_mensagens/model/validation_send_body.dart';
import 'package:gerenciador_mensagens/requests/http_service_wrapper.dart';
import 'package:http/http.dart' as http;

class ValidationRequest extends HttpServiceWrapper<Validation>  {

  ValidationRequest({required super.baseUrl, required super.endpoint});

  @override
  Validation fromJson(Map<String, dynamic> json) {
    return Validation(json);
  }

  Future<dynamic> post(ValidationSendBody body, {Map<String, String>? headers}) async {
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