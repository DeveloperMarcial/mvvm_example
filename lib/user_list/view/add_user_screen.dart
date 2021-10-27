import 'package:flutter/material.dart';
import 'package:mvvm_example/user_list/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the state in the UserViewModel.
    // We are calling this in the build method because whenever the
    // ViewModel calls notifyListeners(), the build method in the
    // corresponding UI will be triggered and
    // it will be re-rendered and we will get the latest state value.
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
        actions: [
          IconButton(
              onPressed: () async {
                bool userAdded = await userViewModel.addUser();
                if (!userAdded) {
                  return;
                }
                Navigator.pop(context);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(hintText: 'Name'),
              onChanged: (val) async {
                userViewModel.addingUser.name = val;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (val) async {
                userViewModel.addingUser.email = val;
              },
            )
          ],
        ),
      ),
    );
  }
}
