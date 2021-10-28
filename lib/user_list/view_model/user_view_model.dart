import 'package:flutter/material.dart';
import 'package:mvvm_example/user_list/model/user_error.dart';
import 'package:mvvm_example/user_list/model/user_list_model.dart';
import 'package:mvvm_example/user_list/repo/api_status.dart';
import 'package:mvvm_example/user_list/repo/user_service.dart';

/*
   Holds business logic.
   View-Model is just a middle man between your 'View' and the 'Service/Data Layer'
   View ← → View-Model ← → Repo
   The idea is to handle all the state related things and business logic
   in the View-Model so that our screens will remain Stateless,
   independent and easily testable and maintainable.
*/

// Here, we set the loading, UserListModel and UserError
// in the View-Model so we read it in the UI, aka View.
class UserViewModel extends ChangeNotifier {
  //
  bool _loading = false;
  List<UserModel> _userListModel = [];
  late UserError _userError;
  late UserModel _selectedUser;
  late UserModel _addingUser; // = UserModel();

  bool get loading => _loading;
  List<UserModel> get userListModel => _userListModel;
  UserError get userError => _userError;
  UserModel get selectedUser => _selectedUser;
  UserModel get addingUser => _addingUser;

  UserViewModel() {
    getUsers();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setSelectedUser(UserModel userModel) {
    _selectedUser = userModel;
  }

  addUser() async {
    if (!isValid()) {
      return;
    }
    _userListModel.add(addingUser);

    _addingUser = UserModel(
      id: 0,
      name: '',
      username: '',
      email: '',
      address: _addingUser.address,
      phone: '',
      website: '',
      company: _addingUser.company,
    );
    notifyListeners();
    return true;
  }

  isValid() {
    if (addingUser.name == null || addingUser.name.isEmpty) {
      return false;
    }
    if (addingUser.email == null || addingUser.email.isEmpty) {
      return false;
    }
    return true;
  }

  getUsers() async {
    //
    setLoading(true);
    //
    print('About to get users from an http API.');
    var getUsersResponse =
        await UserServices.getUsers(); // Get users from an http API.
    print('Got users from an http API.');
    //
    print('getUsersResponse=$getUsersResponse');

    if (getUsersResponse is Success) {
      print('getUsersResponse.code=${getUsersResponse.code}');
      print('getUsersResponse.response=${getUsersResponse.response}');
      print('class UserViewModel.getUsers: success');
      setUserListModel(getUsersResponse.response as List<UserModel>);
    }
    //
    else if (getUsersResponse is Failure) {
      print('getUsersResponse.code=${getUsersResponse.code}');
      print('getUsersResponse.response=${getUsersResponse.errorResponse}');
      print('class UserViewModel.getUsers: failure');
      UserError userError = UserError(
        code: getUsersResponse.code,
        message: getUsersResponse.errorResponse as String,
      );
      setUserError(userError);
    }
    //
    setLoading(false);
    //
  }
}
