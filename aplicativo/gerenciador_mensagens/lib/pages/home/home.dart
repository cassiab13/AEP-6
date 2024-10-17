import 'package:flutter/material.dart';
import 'package:gerenciador_mensagens/routes/app_routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: AppRoutes.getWidget(_selectedIndex)
      )
    );
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
      body: const Center(child: Text("Jean"),),
      bottomNavigationBar: BottomNavigationBar(
				currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Mensagem"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.headphones),
              label: "Configuração"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: "Termos de Uso"
          ),
        ],
      ),
    );
  }
}
