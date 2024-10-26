
class Validation {
  int _id;
  String _message;
  bool _isSafe = true;
  DateTime _date;
  String _cause;

  Validation._internal(this._id, this._message, this._isSafe, this._date, this._cause);

  int get id => _id;
  String get message => _message;
  bool get isSafe => _isSafe;
  DateTime get date => _date;
  String get cause => _cause;

  factory Validation(Map<String, dynamic> body) {
    int id = body['id'];
    String message = body['message'];
    bool isSafe = body['isSafe'];
    DateTime date = DateTime.parse(body['date']);
    String cause = body['cause'];

    return Validation._internal(id, message, isSafe, date, cause);
  }
}