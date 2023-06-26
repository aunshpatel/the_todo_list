import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kWhiteColor,
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kBlackColor,
                  )
                )
              ),
              child: SizedBox(
                  height: 200,
                  child: Image.asset('images/todo-list-blue-transparent-bg.png')
              )
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kBlackColor,
                  )
                )
              ),
              child: ListTile(
                title: const Text(
                  'Tasks Screen',
                  style: kTextStyle,
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/task_screen');
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kBlackColor,
                  )
                )
              ),
              child: ListTile(
                title: const Text(
                  'My Profile',
                  style: kTextStyle,
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/profile_page');
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kWhiteColor,
                  )
                )
              ),
              child: ListTile(
                title: const Text(
                  'Logout',
                  style: kTextStyle,
                ),
                onTap: (){
                  isLoggedIn = false;
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setBool('isLoggedIn', isLoggedIn);
                  },);
                  auth.signOut();
                  Navigator.pushNamed(context,'/login_screen');
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
