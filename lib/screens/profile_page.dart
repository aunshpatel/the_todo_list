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
  //String activeUserEmail='', activeUserName = '';

  @override
  void initState(){
    // TODO: implement initState
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
    /*if(darkTheme == true){
      _value = 1;
    }
    else{
      _value = 0;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kWhiteColor,
          endDrawerEnableOpenDragGesture: false,
          drawer: MyDrawer(),
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
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
            title: const Text('My Profile'),
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
                    height: 180,
                    child: CurrentUserDetails(),
                  ),
                  /*const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Application Theme:',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 7.0,
                      ),
                      SizedBox(
                        width: 70.0,
                        child: DropdownButton(
                          value: _value,
                          dropdownColor: darkTheme == false ? kLightBackgroundColor: Colors.blueGrey,
                          items: const <DropdownMenuItem<int>>[
                            DropdownMenuItem(
                              child: Text(
                                'Light',
                                style: kTextStyle,
                              ),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Dark',
                                style: kTextStyle,
                              ),
                              value: 1,
                            ),
                          ],
                          onChanged: (int? value) async{
                            setState(() {
                              _value = value!;
                              if(value == 0){
                                darkTheme = false;
                              }
                              else if(value == 1){
                                darkTheme = true;
                              }
                              SharedPreferences.getInstance().then((prefs) {
                                prefs.setBool("darkTheme", darkTheme);
                              });
                            });
                          },
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          )
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
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
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


/*class CurrentUserDetails extends StatelessWidget {
  late bool isContactListEmpty = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('registeredUsers').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data();
              if(data['emailID'].toString() == loggedInUser.email.toString()){
                nameController.text = data['fullName'].toString();
                emailController.text = data['emailID'].toString();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name:',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Container(
                      height:50,
                      decoration: kMessageContainerDecoration,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: nameController,
                              style: const TextStyle(color: kWhiteColor),
                              decoration: const InputDecoration(
                                enabled: false,
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                //hintText: 'Type your message here...',
                                hintStyle: TextStyle(color: kWhiteColor),
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
                        color: kWhiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Container(
                      height:50,
                      decoration: kMessageContainerDecoration,
                      child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: emailController,
                                style: const TextStyle(color: kWhiteColor),
                                decoration: const InputDecoration(
                                  enabled: false,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  //hintText: 'Type your message here...',
                                  hintStyle: TextStyle(color: kWhiteColor),
                                  border: InputBorder.none,
                                ),
                                onChanged: null,
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                );
              }
              else{
                return SizedBox(height:0);
              }
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}*/
