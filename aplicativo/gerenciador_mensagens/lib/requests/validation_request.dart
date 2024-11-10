import 'dart:convert';

import 'package:gerenciador_mensagens/model/message_model.dart';
import 'package:gerenciador_mensagens/model/validation.dart';
import 'package:gerenciador_mensagens/requests/http_service_wrapper.dart';
import 'package:http/http.dart' as http;

class ValidationRequest extends HttpServiceWrapper<Validation> {
  ValidationRequest({required super.baseUrl, required super.endpoint});

  @override
  Validation fromJson(Map<String, dynamic> json) {
    return Validation.fromMap(json);
  }

  Future<List<Map<String, dynamic>>> analyzeMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        List<Map<String, dynamic>> results = [];

        for (var messageData in responseData["messages"]) {
          for (var urlData in messageData["urls"]) {
            results.add({
              "url": urlData["url"],
              "api_safe": urlData["api_safe"],
              "rf_safe": urlData["rf_safe"]
            });
          }
        }
        print(results);
        return results;
      } else {
        throw Exception('Erro ao analisar a mensagem');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<List<dynamic>> getAll() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> messagesData = List.from(data['messages'] ?? []);
        return messagesData.map((json) => MessageModel.fromMap(json)).toList();
      } else {
        throw Exception('Erro ao buscar as mensagens.');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}
