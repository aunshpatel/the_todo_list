import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

int tasksLength = 0;

const kLightThemeColor = Colors.lightBlueAccent;

const kWhiteColor = Colors.white;

const kBlueAccent = Colors.blueAccent;

const kThemeBlueColor = Color(0XFF003366);

const kBlackColor = Colors.black;

//String currentUser = 'patelaunsh28@gmail.com';
String currentUser = '';

//late User loggedInUser;

String activeUserEmail = '', activeUserName = '';

const kTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kThemeBlueColor,
);

var kDisabledInputFieldDecoration = const BoxDecoration(
  border: Border(
    top: BorderSide(color: Color(0XFF787878), width: 2.0,),
    left: BorderSide(color: Color(0XFF787878), width: 2.0),
    right: BorderSide(color: Color(0XFF787878), width: 2.0),
    bottom: BorderSide(color: Color(0XFF787878), width: 2.0),
  ),
);

const kBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

var kEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kBlackColor, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

var kFocusedBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kBlueAccent, width: 2.0),
  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
);

class HeroLogo extends StatelessWidget {
  HeroLogo({required this.height,required this.image, required this.tag});

  final double height;
  final String image, tag;
  @override
  Widget build(BuildContext context) {
    return Hero(

      tag:tag,
      child: Container(
        height: height,
        child: Image.asset(image),
      ),
    );
  }
}

InputDecoration emailInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: kThemeBlueColor),
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
  );
}

InputDecoration passwordInputDecoration(String hintText, bool _passwordVisible, void toggle()){
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: kThemeBlueColor),
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
    suffixIcon: IconButton(
      icon: Icon(
        _passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: kThemeBlueColor,
      ),
      onPressed: toggle,
    ),
  );
}