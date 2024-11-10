import 'package:flutter/material.dart';
import 'package:gerenciador_mensagens/requests/validation_request.dart';
import 'package:gerenciador_mensagens/routes/app_routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final ValidationRequest validationRequest = ValidationRequest(
      baseUrl: 'http://127.0.0.1:8000/', endpoint: 'list_messages');
  List<dynamic> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _listAllMessages();
  }

  Future<void> _listAllMessages() async {
    try {
      var response = await validationRequest.getAll();
      setState(() {
        _messages = response;
        _isLoading = false;
      });
    } catch (erro) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.push(context,
        MaterialPageRoute(builder: AppRoutes.getWidget(_selectedIndex)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo/logo_02.png',
          height: 30,
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _messages.isEmpty
              ? const Center(child: Text('Não há mensagens analisadas'))
              : ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isSafe =
                        message.urls.isNotEmpty && message.urls[0].apiSafe;
                    return ListTile(
                      title: Text('Mensagem analisada: ${message.messageText}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var urlInfo in message.urls)
                            Text(
                              'URL: ${urlInfo.url} - API segura: ${urlInfo.apiSafe ? 'Segura' : 'Insegura'} - IA segura: ${urlInfo.rfSafe ? 'Segura' : 'Insegura'}',
                            ),
                        ],
                      ),
                      trailing: Icon(isSafe ? Icons.check_circle : Icons.error,
                          color: isSafe ? Colors.green : Colors.red),
                    );
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Mensagem"),
          BottomNavigationBarItem(
              icon: Icon(Icons.headphones), label: "Configuração"),
          BottomNavigationBarItem(
              icon: Icon(Icons.note), label: "Termos de Uso"),
        ],
      ),
    );
  }
}
