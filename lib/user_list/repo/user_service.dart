import 'dart:io';
import 'package:mvvm_example/user_list/model/user_list_model.dart';
import 'package:mvvm_example/user_list/repo/api_status.dart';
import 'package:mvvm_example/util/constant.dart';
import 'package:http/http.dart' as http;

//The below service is going to fetch the list of users from the http Service.
class UserServices {
  //
  static Future<Object> getUsers() async {
    try {
      var response = await http
          //We will be using the below https service to fetch data.
          // This will respond with a list of user records.
          // We are going to display this list using the MVVM pattern in flutter.
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

      if (SUCCESS == response.statusCode) {
        return Success(
          code: SUCCESS,
          response: usersListModelFromJson(response.body),
        );
      }
      return Failure(
        code: USER_INVALID_RESPONSE,
        errorResponse: 'Invalid Response',
      );
    } on HttpException {
      return Failure(
        code: NO_INTERNET,
        errorResponse: 'No Internet          Connection',
      );
    } on SocketException {
      return Failure(
        code: NO_INTERNET,
        errorResponse: 'No Internet Connection',
      );
    } on FormatException {
      return Failure(
        code: INVALID_FORMAT,
        errorResponse: 'Invalid Format',
      );
    } catch (e) {
      return Failure(
        code: UNKNOWN_ERROR,
        errorResponse: 'Unknown Error',
      );
    }
  }
}
