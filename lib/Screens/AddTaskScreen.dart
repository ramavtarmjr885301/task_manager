// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Database/Database.dart';
import 'package:todo_app/Models/Note_Model.dart';
import 'package:todo_app/Screens/HomeScreen.dart';

class AddTaskScreen extends StatefulWidget {
  final Note? note;
  final Function? updateNoteList;
  const AddTaskScreen({super.key, this.note, this.updateNoteList});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
 
  
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat("MMM dd,  yyyy");
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  String _title = '';
  String _priority = 'Low';
  String btnText = "Add Task";
  String titleText = "Add Task";
  DateTime _date = DateTime.now();
  @override
  void initState() {
    // todo: implement initState
    super.initState();
    if(widget.note !=null){
      _title=widget.note!.title!;
      _date=widget.note!.date!;
      _priority=widget.note!.priority!;
      setState(() {
        btnText='Update Task';
        titleText='Update Task';
      });
    }
    else{
      setState(() {
        btnText='Add Task';
        titleText='Add Task';
      });
    }
    _dateController.text=_dateFormatter.format(_date);
  }
   @override
  void dispose() {
    // todo: implement dispose
    _dateController.dispose();
    super.dispose();
  }
  
  
  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }
  _delete(){
    DatabaseHelper.instance.deleteNote(widget.note!.id!);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    widget.updateNoteList?.call();
  }

  _submmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // ignore: avoid_print
      print('$_title, $_date, $_priority');
      Note note = Note(title: _title, date: _date, priority: _priority);
      if (widget.note == null) {
        note.status = 0;
        DatabaseHelper.instance.insertNote(note);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      } else {
        note.id = widget.note!.id;
        note.status = widget.note!.status;
        DatabaseHelper.instance.updateNote(note);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const HomeScreen(),
            ));
      }
      widget.updateNoteList?.call();
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 216, 207),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.amber,
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          size: 35,
                          color: Colors.purple,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  titleText,
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            // maxLines:2 ,
                            // validator: (input) {
                            //   if(input!.isEmpty){
                            //     return "Please enter the title";
                            //   }
                            //   return null;
                            // },

                            validator: (input) => input!.trim().isEmpty
                                ? 'Please enter the task title'
                                : null,
                            // onSaved: (input)=>_title=input!,
                            // initialValue: _title,
                            onSaved: (input) => _title = input!,
                            initialValue: _title,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                                labelText: "Title",
                                labelStyle: const TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            // ignore: body_might_complete_normally_nullable
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please select the date";
                              }
                            },
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                            readOnly: true,
                            controller: _dateController,
                            onTap: _handleDatePicker,
                            decoration: InputDecoration(
                                labelText: "Date",
                                labelStyle: const TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DropdownButtonFormField(
                            isDense: true,
                            icon: const Icon(Icons.arrow_drop_down_circle),
                            iconSize: 22.0,
                            iconEnabledColor: Theme.of(context).primaryColor,
                            items: _priorities.map((String priority) {
                              return DropdownMenuItem(
                                  value: priority,
                                  child: Text(priority,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0)));
                            }).toList(),
                            style: const TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                                labelText: "Priority",
                                labelStyle: const TextStyle(fontSize: 18.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            // ignore: unnecessary_null_comparison
                            validator: (input) => _priority == null
                                ? 'Please select a priority level'
                                : null,
                            onChanged: (value) {
                              _priority = value.toString();
                            },
                            value: _priority,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),

                                    // ignore: dead_code
                                    backgroundColor: Colors.amber),
                                onPressed: _submmit,
                                child: Center(
                                    child: Text(btnText,
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)))),
                          ),
                        ),
                        widget.note!=null?Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),

                                    // ignore: dead_code
                                    backgroundColor: Colors.amber),
                                onPressed: _delete,
                                child: Center(
                                    child: Text("Delete Task",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)))),
                          ),
                        ):const SizedBox.shrink()
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
