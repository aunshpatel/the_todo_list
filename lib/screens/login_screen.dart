import 'package:flutter/material.dart';
import 'package:the_todo_list/screens/widgets/rounded_buttons.dart';
import '../consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '', pwd = '';
  String loginEmailID = '', loginPassword = '';
  bool showSpinner = false;
  bool _passwordVisible = false;
  bool _isRememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _loadUserEmailPassword();
    appCount();
    super.initState();
  }

  appCount(){
    setState(() {
      loginCount++;
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('loginCount', loginCount);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar:  AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return SizedBox();
          },
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhiteColor,
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: HeroLogo(height:250,image:'images/todo-list-blue-transparent-bg.png', tag:'photo'),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged:(value){
                email = emailController.text;
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('email', email);
                },);
              },
              style: const TextStyle(color: kThemeBlueColor),
              decoration: emailInputDecoration('Enter your email',),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: passwordController,
              obscureText: _passwordVisible == false ? true : false,
              onChanged:(value){
                pwd = passwordController.text;
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('password', pwd);
                },);
              },
              style: const TextStyle(color: kThemeBlueColor),
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
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'New User?',
                  style: TextStyle(
                      color: kThemeBlueColor,
                      fontSize: 16
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/registration_screen');
                  },
                  child: const Text(
                    'Register Here',
                    style: TextStyle(
                        color: kThemeBlueColor,
                        decoration: TextDecoration.underline,
                        fontSize: 16
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      checkColor: kThemeBlueColor,
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(width: 1.0, color: kThemeBlueColor),
                      ),
                      fillColor: MaterialStateProperty.all(Colors.transparent),
                      value: _isRememberMe,
                      onChanged: isRememberMeDisabled == false ? (value){
                        setState(() {
                          _isRememberMe = value!;
                        });
                        actionRemeberMe(_isRememberMe);
                      } : null,
                    ),
                    const Text(
                      'Remember Me',
                      style: TextStyle(
                          color: kThemeBlueColor,
                          fontSize: 16
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: kThemeBlueColor,
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(width: 1.0, color: kThemeBlueColor),
                      ),
                      fillColor: MaterialStateProperty.all(Colors.transparent),
                      value: automaticLogin,
                      onChanged: (value){
                        setState(() {
                          automaticLogin = value!;
                        });
                        autoLogin(automaticLogin);
                      },
                    ),
                    const Text(
                      'Auto Login',
                      style: TextStyle(
                          color: kThemeBlueColor,
                          fontSize: 16
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              colour:kThemeBlueColor,
              title:'Login',
              onPress:() async {
                if(emailController.text != '' && passwordController.text != '') {
                  if(emailController.text.length < 6){
                    _showMyDialog('Incorrect password! Please check your password length and try again.');
                  }
                  else{
                    setState(() {
                      showSpinner = true;
                    });
                    try{
                      final user = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                      if(user != null){
                        Navigator.pushNamed(context, '/task_screen');
                        setState(() {
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setBool('isLoggedIn', true);
                          },);
                          isLoggedIn = true;
                          currentUser = emailController.text;
                          showSpinner = false;
                        });

                      }
                      else{
                        _showMyDialog('Incorrect email or password. Please enter your email and password again.');
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch(e){
                      setState(() {
                        showSpinner = false;
                      });
                      return _showMyDialog('${e.toString()}');
                    }
                  }
                }
                else if(passwordController.text.isEmpty && emailController.text.isNotEmpty){
                  _showMyDialog('No password entered. Please enter the your password.');
                }
                else if(passwordController.text.isNotEmpty && emailController.text.isEmpty){
                  _showMyDialog('No email id entered. Please enter your email id.');
                }
                else if(emailController.text.isEmpty && passwordController.text.isEmpty){
                  _showMyDialog('Email and password fields are empty. Please enter both values to login.');
                }
                else if(emailController.text == '' && passwordController.text != ''){
                  _showMyDialog('Please enter your email id to login.');
                }
                else if(emailController.text == '' && passwordController.text != ''){
                  _showMyDialog('Please enter your password to login.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  actionRemeberMe(bool value) {
    _isRememberMe = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember_me", _isRememberMe);
    },);
    setState(() {
      _isRememberMe = value;
    });
  }

  autoLogin(bool autoLogin){
    if(autoLogin == true){
      actionRemeberMe(true);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('autoLogin', autoLogin);
        setState(() {
          isRememberMeDisabled = true;
        });
        prefs.setBool('isRememberMeDisabled', isRememberMeDisabled);
      },);
    }
    else{
      actionRemeberMe(true);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('autoLogin', autoLogin);
        setState(() {
          isRememberMeDisabled = false;
        });
        prefs.setBool('isRememberMeDisabled', isRememberMeDisabled);
      },);
    }
  }


  void _loadUserEmailPassword() async {
    try {
      prefs = await SharedPreferences.getInstance();
      loginEmailID = prefs.getString('email') ?? '';
      loginPassword = prefs.getString('password') ?? '';
      bool rememberMe = prefs.getBool('remember_me') ?? false;
      automaticLogin = prefs.getBool('autoLogin') ?? false;
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      isRememberMeDisabled = prefs.getBool('isRememberMeDisabled') ?? false;
      if (rememberMe == true) {
        setState(() {
          _isRememberMe = true;
        });
        emailController.text = loginEmailID;
        passwordController.text = loginPassword;
      }
      else{
        setState(() {
          _isRememberMe = false;
        });
        emailController.text = '';
        loginEmailID = '';
        passwordController.text = '';
        loginPassword = '';
      }

      if(automaticLogin == true && isLoggedIn == true){
        final user = await auth.signInWithEmailAndPassword(email: loginEmailID, password: loginPassword);
        if(user != null){
          Navigator.pushNamed(context, '/task_screen');
          setState(() {
            currentUser = emailController.text;
            showSpinner = false;
          });
        }
        else{
          _showMyDialog('Incorrect email or password. Please enter your email and password again.');
          setState(() {
            showSpinner = false;
          });
        }
      }
      else{
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool('isLoggedIn', false);
        },);
      }
    } catch (e) {
      print(e);
    }
  }

  //Alert box
  Future<void> _showMyDialog(String text) async {
    String AlertText = text;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!', style: TextStyle(color: kThemeBlueColor, fontSize: 20.0)),
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