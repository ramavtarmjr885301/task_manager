import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat("MMM dd,  yyyy");
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  // String _title='';
  String _priority = 'Low';
  String btnText = "Add Note";
  String titleText = "Add Note";
  DateTime _date = DateTime.now();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 216, 207),
      body: GestureDetector(
        onTap: () {},
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50,),
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
                const Text(
                  "Add Note",
                  style: TextStyle(
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
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Please enter the title";
                              }
                              return null;
                            },
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
                              if(value!.isEmpty){
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
                                  borderRadius: BorderRadius.circular(10)
                                ),

                                  // ignore: dead_code
                                  backgroundColor: Colors.amber),
                              onPressed: _addNoteBtn,
                              child: Center(
                                  child: Text(btnText,
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)))),
                        ),
                      ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addNoteBtn() {
    if(_formKey.currentState!.validate()){

    }
  }
}
