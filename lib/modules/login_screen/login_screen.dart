import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/modules/register_screen/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../shared/components/components.dart';
// import '../register_screen/register_screen.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/state.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var user;
  var pass;
  bool _obscureText = true;

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('email');
      pass = prefs.getString('password');
    });
    print(user);
  }

  savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', user);
    prefs.setString('password', pass);

    print('------------------------------------');
    print('save login pref done successfllly');
    print(user);
  }

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  Future<void> parameter_() async {
    try {
      {
        await Future.delayed(const Duration(milliseconds: 50), () {
          emailController.text = user != null ? user : '';
          passwordController.text = pass != null ? pass : '';
        });
      }
    } catch (e) {
      print('parameter_ has failed' + e.toString());
    }
  }

  @override
  void initState() {
    getPref();
    parameter_();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
              body: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(146, 235, 249, 255),
                  Color.fromARGB(255, 227, 245, 255)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * .1),
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 250,
                            width: 300,
                            child: Image.asset('images/logo2.png'),
                          ),
                          Container(
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'Enter Username',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  hintText: 'Enter Password',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                _showResetPasswordDialog(context);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 66, 120, 212),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: 350,
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    // Attempt to log in the user
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );

                                    // Save the email and password in SharedPreferences
                                    setState(() {
                                      user = emailController.text;
                                      pass = passwordController.text;
                                    });
                                    await savePref();

                                    // Navigate to the Home screen on successful login
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    String errorMessage =
                                        'An error occurred. Please try again.';

                                    // Handle specific FirebaseAuth errors
                                    if (e.code == 'wrong-password') {
                                      errorMessage =
                                          'The password you entered is incorrect.';
                                    } else if (e.code == 'user-not-found') {
                                      errorMessage =
                                          'No user found with this email address.';
                                    } else if (e.code == 'invalid-email') {
                                      errorMessage =
                                          'Please enter a valid email address.';
                                    }

                                    // Show an error popup using AwesomeDialog
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Login Failed',
                                      desc: errorMessage,
                                      btnOkOnPress: () {}, // Close the dialog
                                    )..show();
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                fixedSize: Size(350, 100),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                padding: EdgeInsets.all(0.0),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 66, 120, 212),
                                        Color.fromARGB(255, 79, 151, 213)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 350.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Login",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          createAccountLabel(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
        listener: (context, state) {
          if (state is successLoginState) {
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
        },
      ),
    );
  }

  void _showResetPasswordDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Password'),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (emailController.text.trim().isEmpty) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Error',
                  desc: 'Please enter your email address',
                  btnOkOnPress:
                      () {}, // Do nothing, just close the AwesomeDialog
                )..show();
                return;
              }

              try {
                await FirebaseAuth.instance.sendPasswordResetEmail(
                  email: emailController.text.trim(),
                );
                Navigator.pop(context); // Close the AlertDialog
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.SUCCES,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Success',
                  desc:
                      'Password reset email has been sent to your email address.',
                  btnOkOnPress:
                      () {}, // Do nothing, just close the AwesomeDialog
                )..show();
              } on FirebaseAuthException catch (e) {
                String errorMessage = 'An error occurred. Please try again.';

                if (e.code == 'user-not-found') {
                  errorMessage = 'No user found with this email address.';
                } else if (e.code == 'invalid-email') {
                  errorMessage = 'Please enter a valid email address.';
                }

                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Error',
                  desc: errorMessage,
                  btnOkOnPress:
                      () {}, // Do nothing, just close the AwesomeDialog
                )..show();
              }
            },
            child: Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }
}

Widget submitButton(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xfffbb448), Color(0xfff7892b)])),
    child: Text(
      'Login',
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text('or'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

Widget createAccountLabel(context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Register',
            style: TextStyle(
                color: Color.fromARGB(255, 206, 104, 20),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
