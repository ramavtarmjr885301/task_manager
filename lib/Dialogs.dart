




import 'package:flutter/material.dart';
class Dialogs{
  // ignore: avoid_types_as_parameter_names
  static void showSnackbar(BuildContext, String msg){
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    // ScaffoldMessengerState.of(context).showSnackBar(SnackBar(content: Text(msg)));
    
   
  }
  static void showProgressBar(BuildContext context){
    showDialog(context: context, builder: (_)=>const Center(child: CircularProgressIndicator(
      color: Colors.blue,
    )));
  }
   
}