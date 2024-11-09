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
      baseUrl: 'http://127.0.0.1:8000', endpoint: 'url_checker/analyze_url');
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
                Validation validationResult = Validation({
                  'id': 1,
                  'message': _messageController.text,
                  'isSafe': result['safe'],
                  'date': DateTime.now().toIso8601String(),
                  'cause': 'Nenhum problema encontrado'
                });

                String message = validationResult.isSafe
                    ? 'URL Segura'
                    : 'URL Insegura. Não clique!';

                Color textColor =
                    validationResult.isSafe ? Colors.green : Colors.red;

                return Text(message, style: TextStyle(color: textColor, fontSize: 20));
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
