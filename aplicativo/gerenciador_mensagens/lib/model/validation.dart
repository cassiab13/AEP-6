class Validation {
  int _id;
  String _message;
  bool _isSafeAPI = true;
  bool _isSafeRF = true;
  DateTime _date;
  String _cause;
  List<String> _urls = [];

  Validation._internal(
    this._id,
    this._message,
    this._isSafeAPI,
    this._isSafeRF,
    this._date,
    this._cause,
    this._urls,
  );

  int get id => _id;
  String get message => _message;
  bool get isSafeAPI => _isSafeAPI;
  bool get isSafeRF => _isSafeRF;
  DateTime get date => _date;
  String get cause => _cause;
  List<String> get urls => _urls;

  factory Validation.fromMap(Map<String, dynamic> body) {
    int id = body['id'] ?? 0;
    String message = body['message'];
    bool isSafeAPI = body['isSafeAPI'];
    bool isSafeRF = body['isSafeRF'];
    DateTime date = DateTime.parse(body['date']);
    String cause = body['cause'] ?? '';
    List<String> urls = List<String>.from(body['urls'] ?? []);

    return Validation._internal(
        id, message, isSafeAPI, isSafeRF, date, cause, urls);
  }

  static List<Validation> fromList(List<dynamic> list) {
    return list.map((item) => Validation.fromMap(item)).toList();
  }
}
