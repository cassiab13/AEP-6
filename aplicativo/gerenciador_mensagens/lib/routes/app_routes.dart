
import 'package:flutter/material.dart';
import 'package:gerenciador_mensagens/pages/config/config.dart';
import 'package:gerenciador_mensagens/pages/message/message.dart';
import 'package:gerenciador_mensagens/pages/terms/terms.dart';

class AppRoutes {

  static Map<int, WidgetBuilder> routeByIndex = {
    0: (context) => const Message(),
    1: (context) => const Config(),
    2: (context) => const Terms(),
  };

  static WidgetBuilder getWidget(int number) {
    return routeByIndex[number]!;
  }
}