class UrlInfo {
  final String url;
  final bool apiSafe;
  final bool rfSafe;

  UrlInfo({required this.url, required this.apiSafe, required this.rfSafe});
  
  factory UrlInfo.fromMap(Map<String, dynamic> map) {
    return UrlInfo(
      url: map['url'],
      apiSafe: map['api_safe'],
      rfSafe: map['rf_safe'],
    );
  }
}
