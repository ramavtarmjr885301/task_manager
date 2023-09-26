// import 'dart:math';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/Dialogs.dart';
import 'package:todo_app/Screens/HomeScreen.dart';
import 'package:todo_app/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Future.delayed(const Duration(microseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleBtnClick() {
    //For showing progressbar
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      if (user != null) {
        print('User:${user.user}');
        print('\UserAddInformation:${user.additionalUserInfo}');

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('\n Please check your internet connection:$e');
      final message = SnackBar(
        content: Center(child: Text("Please check your internet connection")),
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(message);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Welcome to Todo App"),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            top: mq.height * .15,
            width: mq.width * .5,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5,
            child: Image.asset(
              "assets/icons/todo.png",
            ),
          ),
          Positioned(
              bottom: mq.height * .15,
              width: mq.width * .8,
              left: mq.width * .1,
              height: mq.height * .06,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 110, 235, 126)),
                  onPressed: () {
                    _handleGoogleBtnClick();
                  },
                  icon: Image.asset(
                    "assets/icons/google.png",
                    height: mq.height * .04,
                  ),
                  label: RichText(
                      text: const TextSpan(
                          style: TextStyle(fontSize: 19, color: Colors.black),
                          children: [
                        TextSpan(text: " Log In with "),
                        TextSpan(
                            text: "Google",
                            style: TextStyle(fontWeight: FontWeight.w600))
                      ]))))
        ],
      ),
    );
  }
}
