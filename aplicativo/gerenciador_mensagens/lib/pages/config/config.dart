import 'package:flutter/material.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<StatefulWidget> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  
  bool monitorBackground = false;
  bool saveInList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuração')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Salvar mensagens em lista"),
                  const Spacer(),
                  Switch(
                    value: saveInList,
                    onChanged: (value) {
                      setState(() {
                        saveInList = value;
                      });
                    },
                    activeTrackColor: Colors.lightBlue,
                    activeColor: Colors.lightBlue[50],
                  )
                ],
              ),
              Row(
                children: [
                  const Text("Monitorar mensagens em segundo plano"),
                  const Spacer(),
                  Switch(
                    value: monitorBackground,
                    onChanged: (value) {
                      setState(() {
                        monitorBackground = value;
                      });
                    },
                    activeTrackColor: Colors.lightBlue,
                    activeColor: Colors.lightBlue[50],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
