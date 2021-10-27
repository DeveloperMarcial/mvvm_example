//“Success” and “Failure” which will be returned from the Service that we are going to write
// in file 'user_service.dart'

class Success {
  int code;
  Object response;
  Success({required this.code, required this.response});
}

class Failure {
  int code;
  Object errorResponse;
  Failure({required this.code, required this.errorResponse});
}
