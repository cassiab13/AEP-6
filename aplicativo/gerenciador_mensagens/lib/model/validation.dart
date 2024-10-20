
class Validation {
  int _id;
  String _message;
  bool _isValid = true;
  DateTime _date;
  String _cause;

  Validation._internal(this._id, this._message, this._isValid, this._date, this._cause);

  int get id => _id;
  String get message => _message;
  bool get isValid => _isValid;
  DateTime get date => _date;
  String get cause => _cause;

  factory Validation(Map<String, dynamic> body) {
    int id = body['id'];
    String message = body['message'];
    bool isValid = body['isValid'];
    DateTime date = DateTime.parse(body['date']);
    String cause = body['cause'];

    return Validation._internal(id, message, isValid, date, cause);
  }
}