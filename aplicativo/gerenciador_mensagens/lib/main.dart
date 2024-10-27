import 'package:flutter/material.dart';
import 'package:gerenciador_mensagens/background/listen_sms.dart';
import 'package:gerenciador_mensagens/pages/splash-screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ListenSms();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}