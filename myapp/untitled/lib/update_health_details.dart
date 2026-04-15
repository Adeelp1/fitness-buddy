// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import 'home.dart';

// class update_health_details_sub extends StatefulWidget {
//   final String id;
//   final String title;
//   final String details;

//   const update_health_details_sub({
//     Key? key,
//     required this.id,
//     required this.title,
//     required this.details,
//   }) : super(key: key);

//   @override
//   State<update_health_details_sub> createState() =>
//       _update_health_details_subState();
// }

// class _update_health_details_subState
//     extends State<update_health_details_sub> {
//   final title = TextEditingController();
//   final details = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     // ✅ FIX: set initial values
//     title.text = widget.title;
//     details.text = widget.details;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(height: 50),
//             Text(
//               "Edit Health Details",
//               style: TextStyle(color: Colors.green, fontSize: 30),
//             ),
//             SizedBox(height: 50),

//             SizedBox(
//               height: 80,
//               width: 300,
//               child: TextField(
//                 controller: title,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.limeAccent,
//                   hintText: "Enter Title",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),

//             SizedBox(
//               height: 80,
//               width: 300,
//               child: TextField(
//                 controller: details,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.limeAccent,
//                   hintText: "Enter details",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),

//             SizedBox(
//               height: 50,
//               width: 150,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   SharedPreferences sh =
//                   await SharedPreferences.getInstance();

//                   var data = await http.post(
//                     Uri.parse(
//                         "${sh.getString('ip')}/update_health_details"),
//                     body: {
//                       // ✅ FIX: include id
//                       'id': widget.id,
//                       'title': title.text,
//                       'details': details.text,
//                       'uid': sh.getString('uid').toString()
//                     },
//                   );

//                   var decodd = json.decode(data.body);

//                   if (decodd['status'] == 'ok') {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => home()),
//                     );
//                   }
//                 },
//                 child: const Text("Update"), // ✅ better label
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class update_health_details_sub extends StatefulWidget {
  final String id;
  final String title;
  final String details;

  const update_health_details_sub({
    Key? key,
    required this.id,
    required this.title,
    required this.details,
  }) : super(key: key);

  @override
  State<update_health_details_sub> createState() =>
      _update_health_details_subState();
}

class _update_health_details_subState
    extends State<update_health_details_sub> {
  final title = TextEditingController();
  final details = TextEditingController();

  @override
  void initState() {
    super.initState();
    title.text = widget.title;
    details.text = widget.details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F14),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFB6FF3B)),
        title: const Text(
          "Edit Health Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 30),

              /// 🔥 Title Field
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF12181F),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFB6FF3B)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB6FF3B).withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: TextField(
                  controller: title,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: "Enter Title",
                    hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 Details Field
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF12181F),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFB6FF3B)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB6FF3B).withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: TextField(
                  controller: details,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: "Enter details",
                    hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// 🚀 Update Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB6FF3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 10,
                    shadowColor: const Color(0xFFB6FF3B),
                  ),
                  onPressed: () async {
                    SharedPreferences sh =
                        await SharedPreferences.getInstance();

                    var data = await http.post(
                      Uri.parse(
                          "${sh.getString('ip')}/update_health_details"),
                      body: {
                        'id': widget.id,
                        'title': title.text,
                        'details': details.text,
                        'uid': sh.getString('uid').toString()
                      },
                    );

                    var decodd = json.decode(data.body);

                    if (decodd['status'] == 'ok') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => home()),
                      );
                    }
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}