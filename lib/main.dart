import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_example/user_list/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'user_list/view/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here we will be using the package ‘Provider’ for state management.
    // Add to 'pubspec.yaml'
    // dependencies:
    //   provider: ^6.0.1
    //
    // We wrap the screens that are listening to the state with the provider View-Model class.
    // Here we wrapped the main root widget with the MultiProvider().
    return MultiProvider(
      providers: [
        // You can have any number of Providers as you want.
        // So we are lifting up the state from a screen to a top level Notifier class.
        // So all of our Screens will be notified when something changes
        // in the Notifier class and we don’t have to maintain any
        // state logic in every screens we have.
        // And also no need to send parameters in the screen constructor.
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'MVVM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
