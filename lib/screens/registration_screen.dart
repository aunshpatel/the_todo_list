import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_todo_list/screens/widgets/rounded_buttons.dart';
import '../consts.dart';

final _registrationScreenFirestore = FirebaseFirestore.instance;


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String emailID = '', pwd = '', fullName = '', confirmationPwd = '';
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_screen');
                  },
                  color: kThemeBlueColor,
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: kWhiteColor,
          ),
          body:Container(
            decoration: BoxDecoration(
              color: kWhiteColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: HeroLogo(height:250,image:'images/todo-list-blue-transparent-bg.png', tag:'photo')
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    onChanged:(value){
                      fullName = value;
                    },

                    style: const TextStyle(color: kThemeBlueColor),
                    decoration: emailInputDecoration('Enter your full name'),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    onChanged:(value){
                      emailID = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: kThemeBlueColor),
                    decoration: emailInputDecoration('Enter your email'),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    obscureText: _passwordVisible == false ? true : false,
                    onChanged:(value){
                      pwd = value;
                    },
                    style: TextStyle(color: kThemeBlueColor),
                    decoration: passwordInputDecoration(
                      'Enter your password',
                      _passwordVisible,
                      (){
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    obscureText: _confirmPasswordVisible == false ? true : false,
                    onChanged:(value){
                      confirmationPwd = value;
                    },
                    style: TextStyle(color: kThemeBlueColor),
                    decoration: passwordInputDecoration(
                      'Confirm your password',
                      _confirmPasswordVisible,
                    (){
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    colour:kThemeBlueColor,
                    title:'Register',
                    onPress:() async{
                      if(emailID != '' && pwd != ''){
                        if(pwd.length < 6){
                          setState(() {
                            showSpinner = false;
                          });
                          _showMyDialog('Please at least 6 characters for your password.');
                        }
                        else{
                          if(confirmationPwd == pwd){
                            setState(() {
                              showSpinner = true;
                            });
                            try{
                              final user = await _auth.createUserWithEmailAndPassword(email: emailID, password: pwd);
                              user.user?.updateDisplayName(fullName);
                              if(user != null){
                                _registrationScreenFirestore.collection('registeredUsers').add({'fullName':fullName, 'emailID':emailID,});
                                //final user = await _auth.signInWithEmailAndPassword(email: emailID, password: pwd);
                                if(user != null){
                                  //Navigator.pushNamed(context, '/login_screen');
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Success!'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('User created successfully. You will now be redirected to login page.'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/login_screen');
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                                else{
                                  _showMyDialog('Incorrect email or password. Please enter your email and password again.');
                                }
                              }
                            } catch(e){
                              setState(() {
                                showSpinner = false;
                              });
                              return _showMyDialog('${e.toString()}');
                            }
                          }
                          else {
                            _showMyDialog('Your passwords are not same. Please check and enter again.');
                          }
                        }
                      }
                      else if(pwd.isEmpty && emailID.isNotEmpty){
                        _showMyDialog('No password entered. Please enter the your password.');
                      }
                      else if(pwd.isNotEmpty && emailID.isEmpty){
                        _showMyDialog('No email id entered. Please enter your email id.');
                      }
                      else if(emailID.isEmpty && pwd.isEmpty){
                        _showMyDialog('Email and password fields are empty. Please enter both values to login.');
                      }
                      else if(emailID == '' && pwd != ''){
                        _showMyDialog('Please enter your email id to login.');
                      }
                      else if(emailID == '' && pwd != ''){
                        _showMyDialog('Please enter your password to login.');
                      }
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Future<void> _showMyDialog(String text) async {
    String AlertText = text;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!', style: TextStyle(color: kThemeBlueColor),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AlertText, style: TextStyle(color: kThemeBlueColor)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: kThemeBlueColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

SomethingWentWrong(){
  print('Something went wrong');
}