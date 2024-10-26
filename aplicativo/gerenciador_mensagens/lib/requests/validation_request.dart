
import 'dart:convert';

import 'package:gerenciador_mensagens/model/validation.dart';
// import 'package:gerenciador_mensagens/model/validation_send_body.dart';
import 'package:gerenciador_mensagens/requests/http_service_wrapper.dart';
import 'package:http/http.dart' as http;

class ValidationRequest extends HttpServiceWrapper<Validation>  {

  ValidationRequest({required super.baseUrl, required super.endpoint});

  @override
  Validation fromJson(Map<String, dynamic> json) {  return Validation(json);}
  Future<List<dynamic>> analyzeMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)["results"];
      } else {
        throw Exception('Erro ao analisar a mensagem');
      }
    } catch (e) {  
      throw Exception('Erro na requisição: $e');
    }  
  }  
  
}            
                       
                            
                          
                      
                     
                    
