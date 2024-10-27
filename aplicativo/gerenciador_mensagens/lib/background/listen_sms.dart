
import 'package:gerenciador_mensagens/requests/validation_request.dart';
import 'package:telephony/telephony.dart';

class ListenSms {

  final Telephony telephony = Telephony.instance;
  final ValidationRequest validationRequest = ValidationRequest(baseUrl: 'http://127.0.0.1:8000', endpoint: '/url_checker/analyze');

  ListenSms() {
    initialize();
  }

  Future<void> initialize() async {
    bool? permissionsGranted = await telephony.requestSmsPermissions;
    if (permissionsGranted ?? false) {
      listen();
    }
  }

  void listen() {
    telephony.requestSmsPermissions;
    telephony.listenIncomingSms(
      onNewMessage: onMessage, 
      listenInBackground: true,
    );
  }

  void onMessage(SmsMessage message) async {
    if (message.body == null) return;

    await validationRequest.analyzeMessage(message.body!);
     
  }

}