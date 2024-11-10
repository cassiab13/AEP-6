import 'package:gerenciador_mensagens/model/url_info.dart';

class MessageModel {
  final String messageText;
  final List<UrlInfo> urls;

  MessageModel({
    required this.messageText,
    required this.urls,
  });

factory MessageModel.fromMap(Map<String, dynamic> map) {
  String messageText = map['message_text'];
  List<UrlInfo> urls = (map['urls'] as List).map((urlMap) {
    return UrlInfo(
      url: urlMap['url'],
      apiSafe: urlMap['api_safe'],
      rfSafe: urlMap['rf_safe'],
    );
  }).toList();

  return MessageModel(
    messageText: messageText,
    urls: urls,
  );
}

}
