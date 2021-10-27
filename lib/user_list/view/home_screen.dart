import 'package:flutter/material.dart';
import 'package:mvvm_example/component/app_error.dart';
import 'package:mvvm_example/component/app_loading.dart';
import 'package:mvvm_example/component/user_list_row.dart';
import 'package:mvvm_example/user_list/model/user_list_model.dart';
import 'package:mvvm_example/user_list/view_model/user_view_model.dart';
import 'package:mvvm_example/util/navigation_util.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserViewModel usersViewModel = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            onPressed: () async {
              openAddUser(context);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              usersViewModel.getUsers();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _ui(usersViewModel),
          ],
        ),
      ),
    );
  }

  _ui(UserViewModel usersViewModel) {
    if (usersViewModel.loading) {
      return AppLoading();
    }
    if (usersViewModel.userError != null) {
      return AppError(
        errortxt: usersViewModel.userError.message,
      );
    }
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          UserModel userModel = usersViewModel.userListModel[index];
          return UserListRow(
            userModel: userModel,
            onTap: () async {
              usersViewModel.setSelectedUser(userModel);
              openUserDetails(context);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: usersViewModel.userListModel.length,
      ),
    );
  }
}
