import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/Auth/LoginScreen.dart';
import 'package:todo_app/Screens/AddTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  get signOut => null;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Sign Out Function
// _signOut()async{
//   await FirebaseAuth.instance.signOut();
//   await GoogleSignIn().signOut();
//   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
// }
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildNotes(int index) {
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text("Note Title"),
              subtitle: Text("Aug 40, 5050 - High"),
              trailing: Checkbox(
                onChanged: (value) {
                  print(value);
                },
                activeColor: Theme.of(context).primaryColor,
                value: true,
              ),
            ),
            const Divider(
              color: Colors.deepPurple,
              height: 4.0,
              thickness: 3.0,
            )
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: const Color(0xFFd4f1f9),
        appBar: AppBar(
          title: const Text("Todo App"),
          backgroundColor: Colors.amber,
          centerTitle: true,
          elevation: 5,
          iconTheme:const  IconThemeData(color: Colors.black),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddTaskScreen(),));
          },
          // ignore: prefer_const_constructors
          child:  Center(
              child: const Icon(
            Icons.add,
            color: Colors.purple,
            
            size: 30,
          )),
          backgroundColor: Colors.amber,
          shape: const CircleBorder(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 76, 231, 4),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 150,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout,
                      size: 30,
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(
                        left: 5,
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "My Notes",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "0 Of 10",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              );
            }
            return _buildNotes(index);
          },
        ));
  }
}
