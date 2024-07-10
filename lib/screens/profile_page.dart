import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_todo_list/screens/widgets/side_drawer.dart';

import '../consts.dart';

TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
String registeredEmailID = '';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String id = 'profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    final user = auth.currentUser;
    if(user!=null){
      activeUserEmail = user.email.toString();
      emailController.text =  user.email.toString();
      activeUserName = user.displayName.toString();
      nameController.text = user.displayName.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        endDrawerEnableOpenDragGesture: false,
        drawer: MyDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                color: kWhiteColor,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: <Widget>[

          ],
          centerTitle: true,
          title: const Text('My Profile', style:TextStyle(color: kWhiteColor),),
          backgroundColor: kThemeBlueColor,
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 15.0,),
                SizedBox(
                  height: 190,
                  child: CurrentUserDetails(),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class CurrentUserDetails extends StatelessWidget {
  late bool isContactListEmpty = true;
  @override

  Widget build(BuildContext context) {
    emailController.text =  activeUserEmail;
    nameController.text = activeUserName;
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Name:',
            style: TextStyle(
              color: kThemeBlueColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 5.0,),
          Container(
            height:50,
            decoration: kDisabledInputFieldDecoration,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(color: kThemeBlueColor,fontSize: 18),
                    decoration: const InputDecoration(
                      enabled: false,
                      contentPadding: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 10.0),
                      hintStyle: TextStyle(color: kThemeBlueColor),
                      border: InputBorder.none,
                    ),
                    onChanged: null,
                  ),
                ),
              ],
            )
          ),
          const SizedBox(height: 20,),
          const Text(
            'Email ID:',
            style: TextStyle(
              color: kThemeBlueColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 5.0,),
          Container(
            height:50,
            decoration: kDisabledInputFieldDecoration,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(color: kThemeBlueColor,fontSize: 18),
                    decoration: const InputDecoration(
                      enabled: false,
                      contentPadding: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 10.0),
                      hintStyle: TextStyle(color: kThemeBlueColor),
                      border: InputBorder.none,
                    ),
                    onChanged: null,
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}