// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AddN extends StatefulWidget {
//   const AddN({super.key});

//   @override
//   State<AddN> createState() => _AddNState();
// }

// class _AddNState extends State<AddN> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     saveTask();
//   }

//   var tValue = '';
//   var dValue = '';
//   final _formKey = GlobalKey<FormState>();
//   var titleController = TextEditingController();
//   var descController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.purpleAccent,
//         centerTitle: true,
//         title: Text("Add New Task",
//             style:
//                 GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 radius: 40,
//                 backgroundColor: Colors.amber,
//                 child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       size: 40,
//                       color: Colors.black54,
//                     )),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.05,
//               ),
//               Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: titleController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please enter the title";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             hintText: "Enter Title"),
//                         keyboardType: TextInputType.text,
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       TextFormField(
//                         controller: descController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please add the description";
//                           }
//                         },
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             hintText: "Description"),
//                         maxLines: 3,
//                         keyboardType: TextInputType.text,
//                       ),
//                       Container(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.064,
//                         width: MediaQuery.of(context).size.width,
//                         child: Center(
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(

//                                   // ignore: dead_code
//                                   backgroundColor: Colors.amber),
//                               onPressed: () async {
//                                 if (_formKey.currentState!.validate()) {
//                                   var title = titleController.text.toString();
//                                   var description =
//                                       descController.text.toString();
//                                   var titlepref =
//                                       await SharedPreferences.getInstance();
//                                   var despref =
//                                       await SharedPreferences.getInstance();
//                                   titlepref.setString("tkey", title);
//                                   despref.setString("dkey", description);
//                                 }
//                                 setState(() {});
//                               },
//                               child: Center(
//                                   child: Text("SAVE TASK",
//                                       style: GoogleFonts.poppins(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w700)))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Card(
                        
//                         elevation: 0,
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.14,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade200,
//                             borderRadius: BorderRadius.circular(20)
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 10, left: 10, right: 5, bottom: 5),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     tValue,
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(dValue)
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void saveTask() async {
//     var titlepref = await SharedPreferences.getInstance();
//     var getTitle = titlepref.getString("tkey");
//     var descpref = await SharedPreferences.getInstance();
//     var getDes = descpref.getString("dkey");
//     tValue = getTitle ?? "No TItle";
//     dValue = getDes ?? "No Title";
//     setState(() {});
//   }
// }
