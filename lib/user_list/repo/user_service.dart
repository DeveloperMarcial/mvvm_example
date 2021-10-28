import 'package:mvvm_example/user_list/model/user_list_model.dart';
import 'package:mvvm_example/user_list/repo/api_status.dart';
import 'package:mvvm_example/util/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

//Additionally, in your AndroidManifest.xml file, add the Internet permission.
//<!-- Required to fetch data from the internet. -->
//<uses-permission android:name="android.permission.INTERNET" />

//The below service is going to fetch the list of users from the http Service.
class UserServices {
  //
  // MIKE TRY THIS
  // https://stackoverflow.com/questions/68681055/dart-flutter-http-response-is-incomplete-when-downloading-large-files
  // https://flutter.dev/docs/cookbook/networking/background-parsing
  //
  //static Future<Object> getUsers() async {
  static Future<dynamic> getUsers() async {
    print('class UserServices(): Executing http.get()');
    //var response = await http
    http.Response httpResponse = await http
        //Future<http.Response> httpResponse = await http
        //We will be using the below https service to fetch data.
        // This will respond with a list of user records.
        // We are going to display this list using the MVVM pattern in flutter.
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (kSUCCESS == httpResponse.statusCode) {
      print('class UserServices(): http get success');
      var decoded = ascii.decode(httpResponse.bodyBytes);
      print('class UserServices(): httpResponse.bodyBytes=$decoded');
      print(
          'class UserServices(): httpResponse.contentLength=${httpResponse.contentLength}');
      print('class UserServices(): httpResponse.body=${httpResponse.body}');
      print(
          'class UserServices(): httpRespon.statusCode=${httpResponse.statusCode}');
      print('class UserServices(): returning Success object...');
      return Success(
        code: kSUCCESS,
        response: usersListModelFromJson(httpResponse.body),
      );
    } else if (kNO_INTERNET == httpResponse.statusCode) {
      print('class UserServices(): No Internet          Connection');
      return Failure(
        code: kNO_INTERNET,
        errorResponse: 'No Internet          Connection',
      );
    } else if (kNO_INTERNET == httpResponse.statusCode) {
      print('class UserServices(): No Internet Connection');
      return Failure(
        code: kNO_INTERNET,
        errorResponse: 'No Internet Connection',
      );
    } else if (kINVALID_FORMAT == httpResponse.statusCode) {
      print('class UserServices(): Invalid Format');
      return Failure(
        code: kINVALID_FORMAT,
        errorResponse: 'Invalid Format',
      );
    } else if (kUSER_INVALID_RESPONSE == httpResponse.statusCode) {
      print('class UserServices(): http getfailure');
      print('class UserServices(): returning Failure object...');

      return Failure(
        code: kUSER_INVALID_RESPONSE,
        errorResponse: 'Invalid Response',
      );
    } else {
      print('class UserServices(): Unknown Error-------------------------');
      return Failure(
        code: kUNKNOWN_ERROR,
        errorResponse: 'Unknown Error',
      );
    }
  }

  ///////////////////////////////////////////////////////////////////////////
  static Future<Object> getUsersOld() async {
    try {
      print('class UserServices(): Executing http.get()');
      //var response = await http
      http.Response response = await http
          //We will be using the below https service to fetch data.
          // This will respond with a list of user records.
          // We are going to display this list using the MVVM pattern in flutter.
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (kSUCCESS == response.statusCode) {
        print('class UserServices(): http get success');
        print(
            'class UserServices(): response.contentLength=${response.contentLength}');
        print('class UserServices(): response.body=${response.body}');
        print(
            'class UserServices(): response.statusCode=${response.statusCode}');
        print('class UserServices(): returning Success object...');
        return Success(
          code: kSUCCESS,
          response: usersListModelFromJson(response.body),
        );
      } else {
        print('class UserServices(): http getfailure');
        print('class UserServices(): returning Failure object...');
        return Failure(
          code: kUSER_INVALID_RESPONSE,
          errorResponse: 'Invalid Response',
        );
      }
    } on HttpException {
      print('class UserServices(): No Internet          Connection');
      return Failure(
        code: kNO_INTERNET,
        errorResponse: 'No Internet          Connection',
      );
    } on SocketException {
      print('class UserServices(): No Internet Connection');
      return Failure(
        code: kNO_INTERNET,
        errorResponse: 'No Internet Connection',
      );
    } on FormatException {
      print('class UserServices(): Invalid Format');
      return Failure(
        code: kINVALID_FORMAT,
        errorResponse: 'Invalid Format',
      );
    } catch (e) {
      print('class UserServices(): Unknown Error-------------------------');
      return Failure(
        code: kUNKNOWN_ERROR,
        errorResponse: 'Unknown Error',
      );
    } //End 'catch'
  } //End 'getUsers() async {'
} //End 'class UserServices'
