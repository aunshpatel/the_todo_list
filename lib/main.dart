import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_todo_list/screens/login_screen.dart';
import 'package:the_todo_list/screens/profile_page.dart';
import 'package:the_todo_list/screens/registration_screen.dart';
import 'package:the_todo_list/screens/tasks_screen.dart';
import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:Firebase.initializeApp(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return SomethingWentWrong();
          }
          if(snapshot.connectionState == ConnectionState.done){
            return MaterialApp(
              initialRoute: '/login_screen',
              routes: {
                '/login_screen' : (context) => LoginScreen(),
                '/task_screen' : (context) => TasksScreen(),
                '/registration_screen':(context) => RegistrationScreen(),
                '/profile_page':(context) => ProfilePage(),
              },
            );
          }
          return CircularProgressIndicator();
        }
    );
  }
  /*Widget build(BuildContext context) {
    return MaterialApp(
      home:TasksScreen(),
    );
  }*/
}
SomethingWentWrong(){}