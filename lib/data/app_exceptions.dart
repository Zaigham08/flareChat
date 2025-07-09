
class AppExceptions implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final _message, _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString(){
    return '$_prefix$_message';
  }

}

class InternetException extends AppExceptions{

  InternetException([String? message]) : super(message,'No Internet');
}

class RequestTimeOutException extends AppExceptions{

  RequestTimeOutException([String? message]) : super(message,'Request Time out');
}

class ServerException extends AppExceptions{

  ServerException([String? message]) : super(message,'Internal Server error');
}

class ValidationException extends AppExceptions{

  ValidationException([String? message]) : super(message,'');
}

class FetchDataException extends AppExceptions{

  FetchDataException([String? message]) : super(message,'');
  // FetchDataException([String? message]) : super(message,'Error while communication');
}


