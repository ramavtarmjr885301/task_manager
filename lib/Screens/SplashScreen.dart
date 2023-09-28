// ignore: file_names
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/Auth/LoginScreen.dart';
import 'package:todo_app/Screens/HomeScreen.dart';




// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
@override
// ignore: library_private_types_in_public_api
_SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
	super.initState();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  Future.delayed(const Duration(seconds: 3),(){

     
    if(FirebaseAuth.instance.currentUser !=null){
      Navigator.pushReplacement(context,
										MaterialPageRoute(builder:
														(_) =>
														const HomeScreen()
														)
									);
    }
    else{
      Navigator.pushReplacement(context,
										MaterialPageRoute(builder:
														(_) =>
														const LoginScreen()
														)
									);
    }
  });
 
	
}
@override
Widget build(BuildContext context) {
  
	return  Scaffold(

    body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height*.3,
        width: MediaQuery.of(context).size.width*2,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/icons/todo.png"))
        ),
      ),
    )
  );
}
}

