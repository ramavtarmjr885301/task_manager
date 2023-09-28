// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Auth/LoginScreen.dart';
import 'package:todo_app/Database/Database.dart';
import 'package:todo_app/Models/Note_Model.dart';
import 'package:todo_app/Screens/AddTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  get signOut => null;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 

  late Future<List<Note>> _noteList;
  final DateFormat _dateFormatter = DateFormat("MMM dd, yyy");
  // ignore: unused_field
  // DatabaseHelper _databaseHelper = DatabaseHelper.instance;
   @override
  void initState() {
    // todo: implement initState
    super.initState();
    _updateNoteList();
  }

  _updateNoteList() {
    _noteList = DatabaseHelper.instance.getNoteList();
  }

  //Sign Out Function
// _signOut()async{
//   await FirebaseAuth.instance.signOut();
//   await GoogleSignIn().signOut();
//   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
// }
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildNotes(Note note) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                note.title!,
                style: TextStyle(
                  decorationColor: Colors.black,
                    fontSize: 18.0,
                    color: Colors.white,
                    decoration: note.status == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough),
              ),
              subtitle: Text(
                '${_dateFormatter.format(note.date!)} - ${note.priority}',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decorationColor: Colors.black,
                    decoration: note.status == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,),
              ),
              trailing: Checkbox(
                onChanged: (value) {
                  note.status = value! ? 1 : 0;
                  DatabaseHelper.instance.updateNote(note);
                  _updateNoteList();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                },
                activeColor: Theme.of(context).primaryColor,
                value: note.status == 1 ? true : false,
              ),
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>  AddTaskScreen(

                          updateNoteList:_updateNoteList(),
                          note: note,
                          ))),
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
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: const Text("Task Manager"),
          backgroundColor: Colors.amber,
          centerTitle: true,
          elevation: 5,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  AddTaskScreen(
                    updateNoteList: _updateNoteList,
                  ),
                ));
          },
          // ignore: prefer_const_constructors, sort_child_properties_last
          child: Center(
              child:  const Icon(
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
        body: FutureBuilder(
          future: _noteList,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final int completedNoteCount = snapshot.data!
                .where((Note note) => note.status == 1)
                .toList()
                .length;

            return ListView.builder(
              itemCount: int.parse(snapshot.data!.length.toString()) + 1,
              itemBuilder: (BuildContext context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "My Tasks",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$completedNoteCount of ${snapshot.data.length}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  );
                }
                return _buildNotes(snapshot.data![index - 1]);
              },
            );
          },
        ));
  }
}
