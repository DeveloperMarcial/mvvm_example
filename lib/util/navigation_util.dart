import 'package:flutter/material.dart';
import 'package:mvvm_example/user_list/view/add_user_screen.dart';
import 'package:mvvm_example/user_list/view/user_detail_screen.dart';

void openUserDetails(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserDetailsScreen(),
    ),
  );
}

void openAddUser(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddUserScreen(),
    ),
  );
}
