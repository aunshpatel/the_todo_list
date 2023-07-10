import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_todo_list/consts.dart';
import 'package:the_todo_list/screens/login_screen.dart';
import 'package:the_todo_list/screens/profile_page.dart';
import 'package:the_todo_list/screens/registration_screen.dart';
import 'package:the_todo_list/screens/tasks_screen.dart';
import 'firebase_options.dart';
import 'onboarding/onboarding_screen.dart';

void main() async{
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{
  late AnimationController animationController;
  bool isFirstTimeOpeningApp = false;
  late int loginNumber;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
    appCount();
  }

  appCount() async{
    prefs = await SharedPreferences.getInstance();
    loginNumber = prefs.getInt('loginCount') ?? 0;
    print("loginNumber:$loginNumber");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:Firebase.initializeApp(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return somethingWentWrong();
          }
          if(snapshot.connectionState == ConnectionState.done){
            return MaterialApp(
              initialRoute: (loginNumber == 0) ? '/onboarding_screen' : '/login_screen',
              //initialRoute: '/login_screen',
              routes: {
                '/login_screen' : (context) => LoginScreen(),
                '/task_screen' : (context) => TasksScreen(),
                '/registration_screen':(context) => RegistrationScreen(),
                '/profile_page':(context) => ProfilePage(),
                '/onboarding_screen': (context) => OnboardingScreen(),
              },
            );
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                //valueColor: AlwaysStoppedAnimation<Color>(kThemeBlueColor),
                  backgroundColor: kThemeBlueColor,
                  strokeWidth: 4.0,
                  color: Colors.white,
                  valueColor: animationController
                      .drive(ColorTween(begin: Colors.blueAccent, end: kThemeBlueColor)),
                //backgroundColor: Colors.white,
              ),
            ),
          );
        }
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future:Firebase.initializeApp(),
//         builder: (context, snapshot){
//           if(snapshot.hasError){
//             return somethingWentWrong();
//           }
//           if(snapshot.connectionState == ConnectionState.done){
//             return MaterialApp(
//               initialRoute: '/login_screen',
//               routes: {
//                 '/login_screen' : (context) => LoginScreen(),
//                 '/task_screen' : (context) => TasksScreen(),
//                 '/registration_screen':(context) => RegistrationScreen(),
//                 '/profile_page':(context) => ProfilePage(),
//               },
//             );
//           }
//           return Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.height,
//             color: Colors.white,
//             child: Center(
//               child: CircularProgressIndicator(
//                 //valueColor: AlwaysStoppedAnimation<Color>(kThemeBlueColor),
//                 backgroundColor: kThemeBlueColor,
//                 strokeWidth: 4.0,
//                 color: Colors.white,
//                 valueColor: animationController
//                     .drive(ColorTween(begin: Colors.blueAccent, end: Colors.red)),,
//                 //backgroundColor: Colors.white,
//               ),
//             ),
//           );
//         }
//     );
//   }
//   /*Widget build(BuildContext context) {
//     return MaterialApp(
//       home:TasksScreen(),
//     );
//   }*/
// }
somethingWentWrong(){
  return const AlertDialog(
    title: Text('Warning!'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text('Something Went Wrong!'),
        ],
      ),
    ),
  );
}