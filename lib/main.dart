
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/Screens/SplashScreen.dart';
import 'package:todo_app/firebase_options.dart';
late Size mq;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//     final auth=FirebaseAuth.instance;
// final user=auth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
        primarySwatch: Colors.purple
      ),
      home:SplashScreen()
    );
  }
}
// StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){

//         if(snapshot.hasData){}
//         else{}
//       })

