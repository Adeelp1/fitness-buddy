// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class edit_profile_sub extends StatefulWidget {
//   const edit_profile_sub({Key? key}) : super(key: key);
//
//   @override
//   State<edit_profile_sub> createState() => _edit_profile_subState();
// }
//
// class _edit_profile_subState extends State<edit_profile_sub> {
//
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController gender = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   TextEditingController bio = TextEditingController();
//
//   String photo = "";
//
//   // 🔥 Dropdown values
//   String selectedLevel = "Beginner";
//   List<String> levels = ["Beginner", "Intermediate", "Advanced"];
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }
//
//   Future<void> loadProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String uid = prefs.getString("uid").toString();
//
//     var data = await http.post(
//       Uri.parse(prefs.getString("ip").toString() + "/view_profile"),
//       body: {"uid": uid},
//     );
//
//     var jsonData = json.decode(data.body);
//     var user = jsonData["message"][0];
//
//     // 🔥 Convert backend level → UI level
//     String apiLevel = user["level"].toString().toLowerCase();
//
//     if (apiLevel == "normal") {
//       selectedLevel = "Intermediate";
//     } else if (apiLevel == "beginner") {
//       selectedLevel = "Beginner";
//     } else if (apiLevel == "advanced") {
//       selectedLevel = "Advanced";
//     } else {
//       selectedLevel = "Beginner"; // fallback
//     }
//
//     setState(() {
//       name.text = user["name"];
//       email.text = user["email"];
//       phone.text = user["phone"];
//       gender.text = user["gender"];
//       dob.text = user["dob"];
//       bio.text = user["bio"];
//       photo = prefs.getString("ip").toString() + user["photo"];
//     });
//   }
//
//   Future<void> updateProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String uid = prefs.getString("uid").toString();
//
//     // 🔥 Convert UI level → backend level
//     String apiLevel = "beginner";
//     if (selectedLevel == "Intermediate") {
//       apiLevel = "normal";
//     } else if (selectedLevel == "Advanced") {
//       apiLevel = "advanced";
//     }
//
//     var response = await http.post(
//       Uri.parse(prefs.getString("ip").toString() + "/edit_profile"),
//       body: {
//         "uid": uid,
//         "name": name.text,
//         "email": email.text,
//         "phone": phone.text,
//         "gender": gender.text,
//         "dob": dob.text,
//         "level": apiLevel,
//         "bio": bio.text,
//       },
//     );
//
//     var jsonData = json.decode(response.body);
//
//     if (jsonData["status"] == "ok") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Profile Updated Successfully")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Update Failed")),
//       );
//     }
//   }
//
//   Widget buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
//
//   Widget buildDropdown() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: DropdownButtonFormField<String>(
//         value: levels.contains(selectedLevel) ? selectedLevel : levels[0],
//         decoration: InputDecoration(
//           labelText: "Level",
//           border: OutlineInputBorder(),
//         ),
//         items: levels.map((String level) {
//           return DropdownMenuItem<String>(
//             value: level,
//             child: Text(level),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           setState(() {
//             selectedLevel = newValue!;
//           });
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//         backgroundColor: Colors.red,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             // 🔥 Profile Image
//             photo != ""
//                 ? ClipRRect(
//               borderRadius: BorderRadius.circular(60),
//               child: Image.network(photo, height: 120, width: 120, fit: BoxFit.cover),
//             )
//                 : Container(),
//
//             SizedBox(height: 20),
//
//             buildTextField("Name", name),
//             buildTextField("Email", email),
//             buildTextField("Phone", phone),
//             buildTextField("Gender", gender),
//             buildTextField("DOB", dob),
//
//             // 🔥 Dropdown here
//             buildDropdown(),
//
//             buildTextField("Bio", bio),
//
//             SizedBox(height: 20),
//
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//               ),
//               onPressed: {
//
//                 sharedPreferences sh = await SharedPreferences.getInstance();
//                 var data = await http.post(
//                 Uri.parse(prefs.getString("ip").toString()+"/view_tips"),
//                 body: {"uid": sh.getString("uid").toString()}
//     );
//                 updateProfile,
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => view_profile_sub())),
//               },
//               child: Text("Update Profile"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }