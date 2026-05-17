// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import 'home.dart';

// class add_health_details extends StatelessWidget {
//   const add_health_details({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: add_health_details_sub(),);
//   }
// }

// class add_health_details_sub extends StatefulWidget {
//   const add_health_details_sub({Key? key}) : super(key: key);

//   @override
//   State<add_health_details_sub> createState() => _add_health_details_subState();
// }

// class _add_health_details_subState extends State<add_health_details_sub> {
//   final title = new TextEditingController();
//   final details = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(children: [
//           SizedBox(height: 50,),
//           Text("Add Health Details", style: TextStyle(color: Colors.green, fontSize: 30,),),
//           SizedBox(height: 50,),
//           SizedBox(height: 80, width: 300, child: TextField(
//             controller: title,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.limeAccent,
//               hintText: "Enter Title",
//               border: OutlineInputBorder()
//             ),
//           ),),
//           SizedBox(height: 80, width: 300, child: TextField(
//             controller: details,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.limeAccent,
//               hintText: "Enter your details",
//               border: OutlineInputBorder()
//             ),
//           ),),
//           SizedBox(height: 50, width: 150, child: ElevatedButton(onPressed: ()async{
//             SharedPreferences sh = await SharedPreferences.getInstance();
//             var data = await http.post(Uri.parse("${sh.getString('ip')}/add_health_details"),
//             body: {
//               'title': title.text,
//               'details': details.text,
//               'uid':sh.getString('uid').toString()
//             });
//             var decodd=json.decode(data.body);
//             if(decodd['status']=='ok'){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
//             }
//           },
//               child: const Text("Add")),)
//         ],),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class add_health_details extends StatelessWidget {
  const add_health_details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: add_health_details_sub(),
    );
  }
}

class add_health_details_sub extends StatefulWidget {
  const add_health_details_sub({Key? key}) : super(key: key);

  @override
  State<add_health_details_sub> createState() =>
      _add_health_details_subState();
}

class _add_health_details_subState extends State<add_health_details_sub> {
  final title = TextEditingController();
  final details = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0F14),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B0F14),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFB6FF3B)),
        title: Text(
          "Add Health Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF12181F),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFB6FF3B).withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Health Details",
                  style: TextStyle(
                    color: Color(0xFFB6FF3B),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),

                // Title Field
                TextField(
                  controller: title,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter Title",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFF0B0F14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFB6FF3B), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Details Field
                TextField(
                  controller: details,
                  maxLines: 3,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your details",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFF0B0F14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFB6FF3B), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Neon Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB6FF3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      shadowColor:
                          Color(0xFFB6FF3B).withOpacity(0.6),
                    ),
                    onPressed: () async {
                      SharedPreferences sh =
                          await SharedPreferences.getInstance();
                      var data = await http.post(
                        Uri.parse(
                            "${sh.getString('ip')}/add_health_details"),
                        body: {
                          'title': title.text,
                          'details': details.text,
                          'uid': sh.getString('uid').toString()
                        },
                      );

                      var decodd = json.decode(data.body);
                      if (decodd['status'] == 'ok') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => home()));
                      }
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}