import 'package:flutter/material.dart';
import 'package:gerenciador_mensagens/model/validation.dart';
import 'package:gerenciador_mensagens/requests/validation_request.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final ValidationRequest validationRequest = ValidationRequest(
      baseUrl: 'http://127.0.0.1:8000/', endpoint: 'analyze_message');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mensagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    ),
                    labelText: 'Informe o SMS recebido',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0)),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o SMS';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var results = await validationRequest
                            .analyzeMessage(_messageController.text);
                        _showResultsDialog(results);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Enviar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultsDialog(List<dynamic> results) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: SingleChildScrollView(
            child: ListBody(
              children: results.map<Widget>((result) {
                Validation validationResult = Validation.fromMap({
                  'id': 1,
                  'message': _messageController.text,
                  'isSafeAPI': result['api_safe'],
                  'isSafeRF': result['rf_safe'],
                  'date': DateTime.now().toIso8601String(),
                  'cause': 'Nenhum problema encontrado',
                  'urls': [result['url']]
                });

                String apiMessage = validationResult.isSafeAPI
                    ? 'De acordo com a API a URL é segura'
                    : 'De acordo com a API a URL é insegura. Não clique!';

                String rfMessage = validationResult.isSafeRF
                    ? 'De acordo com a IA a URL é segura'
                    : 'De acordo com a IA a URL é insegura. Não clique!';

                Color textColor =
                    (validationResult.isSafeAPI && validationResult.isSafeRF)
                        ? Colors.green
                        : Colors.red;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(apiMessage,
                        style: TextStyle(color: textColor, fontSize: 20)),
                    const SizedBox(height: 10),
                    Text(rfMessage,
                        style: TextStyle(color: textColor, fontSize: 20)),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
