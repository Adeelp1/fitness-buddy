// // //*⚡ Flutter Flow: 🎨✨ Choose File from Gallery → 🚀 Send to Django Backend*
// //
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// // // =====================================================
// // // 📦 IMPORTS (Required Libraries for Image Upload)
// // // =====================================================
// // import 'package:file_picker/file_picker.dart';
// // import 'package:flutter/foundation.dart'; // kIsWeb
// // import 'dart:typed_data';
// //
// // import 'home.dart';
// //
// //
// //
// // class edit_user_profile_photosub extends StatefulWidget {
// //   const edit_user_profile_photosub({Key? key}) : super(key: key);
// //
// //   @override
// //   State<edit_user_profile_photosub> createState() => _edit_user_profile_photosubState();
// // }
// //
// // class _edit_user_profile_photosubState extends State<edit_user_profile_photosub> {
// //
// //   TextEditingController name = TextEditingController();
// //   TextEditingController email = TextEditingController();
// //   TextEditingController phone = TextEditingController();
// //   TextEditingController gender = TextEditingController();
// //   TextEditingController dob = TextEditingController();
// //   TextEditingController bio = TextEditingController();
// //
// //   String selectedLevel = "Beginner";
// //   List<String> levels = ["Beginner", "Intermediate", "Advanced"];
// //
// //   // =====================================================
// //   // 📸 FILE UPLOAD VARIABLES
// //   // =====================================================
// //   PlatformFile? _selectedFile;
// //   Uint8List? _webFileBytes;
// //   String? _result;
// //   bool _isLoading = false;
// //
// //   // =====================================================
// //   // 📸 PICK FILE FUNCTION
// //   // =====================================================
// //   Future<void> _pickFile() async {
// //     FilePickerResult? result = await FilePicker.platform.pickFiles(
// //       allowMultiple: false,
// //       type: FileType.any, // Any file type allowed
// //     );
// //
// //     if (result != null) {
// //       setState(() {
// //         _selectedFile = result.files.first;
// //         _result = null;
// //       });
// //
// //       if (kIsWeb) {
// //         _webFileBytes = result.files.first.bytes;
// //       }
// //     }
// //   }
// //   // =====================================================
// //   // 📸 END FILE PICK SECTION
// //   // =====================================================
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(body: Center(child:
// //       SingleChildScrollView(child:
// //         SizedBox(height: 500,width: 500,child:
// //           Column(children: [
// //
// //             // =====================================================
// //             // 📸 FILE SELECTOR BUTTON + PREVIEW
// //             // =====================================================
// //             ElevatedButton.icon(
// //               icon: Icon(Icons.upload_file),
// //               label: Text("Select File"),
// //               onPressed: _pickFile,
// //             ),
// //             if (_selectedFile != null) ...[
// //               SizedBox(height: 10),
// //               Text("Selected: ${_selectedFile!.name}"),
// //             ],
// //             // =====================================================
// //             // 📸 END FILE SELECTOR
// //             // =====================================================
// //
// //             SizedBox(height: 20),
// //             TextField(controller: name,
// //               decoration: InputDecoration(
// //               border: OutlineInputBorder(),
// //               hintText: 'enter name',
// //               labelText: 'Name',
// //             ),),SizedBox(height: 20,),
// //             TextField(controller: email,
// //               maxLines: 5,
// //             decoration: InputDecoration(
// //               hintText: 'enter email',
// //               labelText: 'Email',
// //               border: OutlineInputBorder()
// //             ),),SizedBox(height: 20,),
// //             TextField(controller: phone,
// //               decoration: InputDecoration(
// //               border: OutlineInputBorder(),
// //               hintText: 'enter phone',
// //               labelText: 'Phone',
// //             ),),SizedBox(height: 20,),
// //             TextField(controller: gender,
// //               decoration: InputDecoration(
// //               border: OutlineInputBorder(),
// //               hintText: 'enter gender',
// //               labelText: 'Gender',
// //             ),),SizedBox(height: 20,),
// //             TextField(controller: dob,
// //               decoration: InputDecoration(
// //               border: OutlineInputBorder(),
// //               hintText: 'enter date of birth',
// //               labelText: 'Date of Birth',
// //             ),),SizedBox(height: 20,),
// //             TextField(controller: bio,
// //               decoration: InputDecoration(
// //               border: OutlineInputBorder(),
// //               hintText: 'enter bio',
// //               labelText: 'Bio',
// //             ),),SizedBox(height: 20,),
// //
// //             ElevatedButton(onPressed: () async {
// //               print(email.text);
// //               print(phone.text);
// //               print(dob.text);
// //               print(gender.text);
// //               print(bio.text);
// //
// //               SharedPreferences sh=await SharedPreferences.getInstance();
// //
// //               // =====================================================
// //               // 🌐 SERVER REQUEST (POST to Django)
// //               // =====================================================
// //               var request =   await http.MultipartRequest(
// //                 'POST',
// //                 Uri.parse('${sh.getString('ip')}/edit_profile')
// //               );
// //
// //               // 🔹 Normal Form Data
// //               request.fields['name'] = name.text;
// //               request.fields['email'] = email.text;
// //               request.fields['phone'] = phone.text;
// //               request.fields['gender'] = gender.text;
// //               request.fields['dob'] = dob.text;
// //               request.fields['bio'] = bio.text;
// //               request.fields['uid'] = sh.getString('uid').toString();
// //
// //               // 🔹 File Upload Part
// //               if (kIsWeb) {
// //                 request.files.add(http.MultipartFile.fromBytes(
// //                   'file',
// //                   _webFileBytes!,
// //                   filename: _selectedFile!.name,
// //                 ));
// //               } else {
// //                 request.files.add(await http.MultipartFile.fromPath(
// //                   'file',
// //                   _selectedFile!.path!,
// //                 ));
// //               }
// //               // =====================================================
// //               // 🌐 END SERVER UPLOAD SECTION
// //               // =====================================================
// //
// //               var response = await request.send();
// //
// //               Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
// //
// //             }, child: Text('send'))
// //
// //           ],),),),),);
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// // 📦 FILE PICKER
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:typed_data';
//
// import 'home.dart';
//
// class edit_user_profile_photosub extends StatefulWidget {
//   final String name;
//   final String email;
//   final String phone;
//   final String gender;
//   final String dob;
//   final String bio;
//   final String level;
//
//
//
//   const edit_user_profile_photosub({Key? key, required this.name, required this.email, required this.phone, required this.gender, required this.dob, required this.bio, required this.level}) : super(key: key);
//
//   @override
//   State<edit_user_profile_photosub> createState() =>
//       _edit_user_profile_photosubState();
//
//
// }
//
// class _edit_user_profile_photosubState
//     extends State<edit_user_profile_photosub> {
//
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController gender = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   TextEditingController bio = TextEditingController();
//
//
//   String selectedLevel = "Beginner";
//   List<String> levels = ["Beginner", "Intermediate", "Advanced"];
//
//   PlatformFile? _selectedFile;
//   Uint8List? _webFileBytes;
//
//   // 📸 PICK FILE
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.image,
//     );
//
//     if (result != null) {
//       setState(() {
//         _selectedFile = result.files.first;
//       });
//
//       if (kIsWeb) {
//         _webFileBytes = result.files.first.bytes;
//       }
//     }
//   }
//
//   // 🚀 SEND DATA
//   Future<void> sendData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('${sh.getString('ip')}/edit_profile'),
//     );
//
//     request.fields['name'] = name.text;
//     request.fields['email'] = email.text;
//     request.fields['phone'] = phone.text;
//     request.fields['gender'] = gender.text;
//     request.fields['dob'] = dob.text;
//     request.fields['bio'] = bio.text;
//     request.fields['uid'] = sh.getString('uid').toString();
//     request.fields['level'] = selectedLevel;
//
//     // ✅ SAFE FILE UPLOAD
//     if (_selectedFile != null) {
//       if (kIsWeb) {
//         request.files.add(http.MultipartFile.fromBytes(
//           'file',
//           _webFileBytes!,
//           filename: _selectedFile!.name,
//         ));
//       } else {
//         request.files.add(await http.MultipartFile.fromPath(
//           'file',
//           _selectedFile!.path!,
//         ));
//       }
//     }
//
//     var response = await request.send();
//
//     if (response.statusCode == 200) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => home()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Upload Failed")),
//       );
//     }
//   }
//
//   // 🎨 DROPDOWN
//   Widget buildDropdown() {
//     return DropdownButtonFormField<String>(
//       value: selectedLevel,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: "Level",
//       ),
//       items: levels.map((level) {
//         return DropdownMenuItem(value: level, child: Text(level));
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           selectedLevel = value!;
//         });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true, // ✅ FIX
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//         backgroundColor: Colors.red,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16).copyWith(bottom: 30),
//           child: Center(
//             child: SizedBox(
//               width: double.infinity,
//               child: Column(
//                 children: [
//
//                   // 📸 IMAGE PICKER
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.upload_file),
//                     label: Text("Select Profile Image"),
//                     onPressed: _pickFile,
//                   ),
//
//                   SizedBox(height: 10),
//
//                   if (_selectedFile != null)
//                     Text("Selected: ${_selectedFile!.name}"),
//
//                   SizedBox(height: 20),
//
//                   // 📝 INPUT FIELDS
//                   TextField(
//                     controller: name,
//                     decoration: InputDecoration(
//                       labelText: "Name",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//
//                   TextField(
//                     controller: email,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//
//                   TextField(
//                     controller: phone,
//                     decoration: InputDecoration(
//                       labelText: "Phone",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//
//                   TextField(
//                     controller: gender,
//                     decoration: InputDecoration(
//                       labelText: "Gender",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//
//                   TextField(
//                     controller: dob,
//                     decoration: InputDecoration(
//                       labelText: "DOB",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//
//                   buildDropdown(),
//                   SizedBox(height: 15),
//
//                   TextField(
//                     controller: bio,
//                     decoration: InputDecoration(
//                       labelText: "Bio",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 25),
//
//                   // 🚀 BUTTON
//                   ElevatedButton(
//                     onPressed: sendData,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     ),
//                     child: Text("Update Profile"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:typed_data';
//
// import 'home.dart';
//
// class edit_user_profile_photosub extends StatefulWidget {
//   final String id;
//   final String name;
//   final String email;
//   final String phone;
//   final String photo;
//   final String gender;
//   final String dob;
//   final String bio;
//   final String level;
//
//   const edit_user_profile_photosub({
//     Key? key,
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.photo,
//     required this.gender,
//     required this.dob,
//     required this.bio,
//     required this.level,
//   }) : super(key: key);
//
//   @override
//   State<edit_user_profile_photosub> createState() =>
//       _edit_user_profile_photosubState();
// }
//
// class _edit_user_profile_photosubState
//     extends State<edit_user_profile_photosub> {
//
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController gender = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   TextEditingController bio = TextEditingController();
//
//   String selectedLevel = "Beginner";
//   List<String> levels = ["Beginner", "Intermediate", "Advanced"];
//
//   PlatformFile? _selectedFile;
//   Uint8List? _webFileBytes;
//   String? imageUrl;
//
//
//   // ✅ INIT
//   @override
//   void initState() {
//     super.initState();
//
//     name.text = widget.name;
//     email.text = widget.email;
//     phone.text = widget.phone;
//     gender.text = widget.gender;
//     dob.text = widget.dob;
//     bio.text = widget.bio;
//     imageUrl = widget.photo;
//     // 🔥 SAFE LEVEL FIX
//     if (levels.contains(widget.level)) {
//       selectedLevel = widget.level;
//     } else {
//       selectedLevel = "Beginner";
//     }
//   }
//
//   // 📸 PICK FILE
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.image,
//     );
//
//     if (result != null) {
//       setState(() {
//         _selectedFile = result.files.first;
//       });
//
//       if (kIsWeb) {
//         _webFileBytes = result.files.first.bytes;
//       }
//     }
//   }
//
//   // 🚀 SEND DATA
//   Future<void> sendData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('${sh.getString('ip')}/edit_profile'),
//     );
//
//     request.fields['name'] = name.text;
//     request.fields['email'] = email.text;
//     request.fields['phone'] = phone.text;
//     request.fields['gender'] = gender.text;
//     request.fields['dob'] = dob.text;
//     request.fields['bio'] = bio.text;
//     request.fields['uid'] = widget.id;
//     request.fields['level'] = selectedLevel;
//
//     // ✅ SAFE FILE
//     if (_selectedFile != null) {
//       if (kIsWeb) {
//         request.files.add(http.MultipartFile.fromBytes(
//           'file',
//           _webFileBytes!,
//           filename: _selectedFile!.name,
//         ));
//       } else {
//         request.files.add(await http.MultipartFile.fromPath(
//           'file',
//           _selectedFile!.path!,
//         ));
//       }
//     }
//
//     var response = await request.send();
//
//     if (response.statusCode == 200) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => home()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Upload Failed")),
//       );
//     }
//   }
//
//   // 🎨 DROPDOWN
//   Widget buildDropdown() {
//     return DropdownButtonFormField<String>(
//       value: selectedLevel,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: "Level",
//       ),
//       items: levels.map((level) {
//         return DropdownMenuItem(value: level, child: Text(level));
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           selectedLevel = value!;
//         });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//         backgroundColor: Colors.red,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16).copyWith(bottom: 30),
//           child: Column(
//             children: [
//
//               ElevatedButton.icon(
//                 icon: Icon(Icons.upload_file),
//                 label: Text("Select Profile Image"),
//                 onPressed: _pickFile,
//               ),
//
//               SizedBox(height: 10),
//
//               if (_selectedFile != null)
//                 Text("Selected: ${_selectedFile!.name}"),
//
//               SizedBox(height: 20),
//
//               TextField(controller: name, decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder())),
//               SizedBox(height: 15),
//
//               TextField(controller: email, decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder())),
//               SizedBox(height: 15),
//
//               TextField(controller: phone, decoration: InputDecoration(labelText: "Phone", border: OutlineInputBorder())),
//               SizedBox(height: 15),
//
//               TextField(controller: gender, decoration: InputDecoration(labelText: "Gender", border: OutlineInputBorder())),
//               SizedBox(height: 15),
//
//               TextField(controller: dob, decoration: InputDecoration(labelText: "DOB", border: OutlineInputBorder())),
//               SizedBox(height: 15),
//
//               buildDropdown(),
//               SizedBox(height: 15),
//
//               TextField(controller: bio, decoration: InputDecoration(labelText: "Bio", border: OutlineInputBorder())),
//               SizedBox(height: 25),
//
//               ElevatedButton(
//                 onPressed: sendData,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 ),
//                 child: Text("Update Profile"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

///////////////////////////////////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:typed_data';

// import 'home.dart';

// class edit_user_profile_photosub extends StatefulWidget {
//   final String id;
//   final String name;
//   final String email;
//   final String phone;
//   final String photo;
//   final String gender;
//   final String dob;
//   final String bio;
//   final String level;

//   const edit_user_profile_photosub({
//     Key? key,
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.photo,
//     required this.gender,
//     required this.dob,
//     required this.bio,
//     required this.level,
//   }) : super(key: key);

//   @override
//   State<edit_user_profile_photosub> createState() =>
//       _edit_user_profile_photosubState();
// }

// class _edit_user_profile_photosubState
//     extends State<edit_user_profile_photosub> {

//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController gender = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   TextEditingController bio = TextEditingController();

//   String selectedLevel = "Beginner";
//   List<String> levels = ["Beginner", "Intermediate", "Advanced"];

//   PlatformFile? _selectedFile;
//   Uint8List? _webFileBytes;
//   String? imageUrl;

//   @override
//   void initState() {
//     super.initState();

//     name.text = widget.name;
//     email.text = widget.email;
//     phone.text = widget.phone;
//     gender.text = widget.gender;
//     dob.text = widget.dob;
//     bio.text = widget.bio;
//     imageUrl = widget.photo;

//     if (levels.contains(widget.level)) {
//       selectedLevel = widget.level;
//     }
//   }

//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );

//     if (result != null) {
//       setState(() {
//         _selectedFile = result.files.first;
//       });

//       if (kIsWeb) {
//         _webFileBytes = result.files.first.bytes;
//       }
//     }
//   }

//   Future<void> sendData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();

//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('${sh.getString('ip')}/edit_profile'),
//     );

//     request.fields['uid'] = widget.id;
//     request.fields['name'] = name.text;
//     request.fields['email'] = email.text;
//     request.fields['phone'] = phone.text;
//     request.fields['gender'] = gender.text;
//     request.fields['dob'] = dob.text;
//     request.fields['bio'] = bio.text;
//     request.fields['level'] = selectedLevel;

//     if (_selectedFile != null) {
//       if (kIsWeb) {
//         request.files.add(http.MultipartFile.fromBytes(
//           'file',
//           _webFileBytes!,
//           filename: _selectedFile!.name,
//         ));
//       } else {
//         request.files.add(await http.MultipartFile.fromPath(
//           'file',
//           _selectedFile!.path!,
//         ));
//       }
//     }

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => home()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Upload Failed")),
//       );
//     }
//   }

//   Widget buildDropdown() {
//     return DropdownButtonFormField<String>(
//       value: selectedLevel,
//       items: levels.map((level) {
//         return DropdownMenuItem(value: level, child: Text(level));
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           selectedLevel = value!;
//         });
//       },
//       decoration: InputDecoration(labelText: "Level"),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Edit Profile")),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [

//             // ✅ SHOW CURRENT IMAGE
//             if (_selectedFile == null && imageUrl != null)
//               Image.network(
//                 imageUrl!,
//                 height: 150,
//                 errorBuilder: (_, __, ___) => Icon(Icons.person, size: 100),
//               ),

//             SizedBox(height: 10),

//             ElevatedButton(
//               onPressed: _pickFile,
//               child: Text("Select Image"),
//             ),

//             if (_selectedFile != null)
//               Text("Selected: ${_selectedFile!.name}"),

//             SizedBox(height: 20),

//             TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
//             TextField(controller: email, decoration: InputDecoration(labelText: "Email")),
//             TextField(controller: phone, decoration: InputDecoration(labelText: "Phone")),
//             TextField(controller: gender, decoration: InputDecoration(labelText: "Gender")),
//             TextField(controller: dob, decoration: InputDecoration(labelText: "DOB")),

//             buildDropdown(),

//             TextField(controller: bio, decoration: InputDecoration(labelText: "Bio")),

//             SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: sendData,
//               child: Text("Update Profile"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

import 'home.dart';

class edit_user_profile_photosub extends StatefulWidget {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String gender;
  final String dob;
  final String bio;
  final String level;

  const edit_user_profile_photosub({
    Key? key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
    required this.dob,
    required this.bio,
    required this.level,
  }) : super(key: key);

  @override
  State<edit_user_profile_photosub> createState() =>
      _edit_user_profile_photosubState();
}

class _edit_user_profile_photosubState
    extends State<edit_user_profile_photosub> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController bio = TextEditingController();

  String selectedLevel = "Beginner";
  List<String> levels = ["Beginner", "Intermediate", "Advanced"];

  String selectedGender = "Male";
  List<String> genders = ["Male", "Female", "Other"];

  PlatformFile? _selectedFile;
  Uint8List? _webFileBytes;
  String? imageUrl;

  final Color bgColor = Color(0xFF0B0F14);
  final Color cardColor = Color(0xFF12181F);
  final Color accent = Color(0xFFB6FF3B);
  final Color textSecondary = Color(0xFF9CA3AF);

  @override
  void initState() {
    super.initState();

    name.text = widget.name;
    email.text = widget.email;
    phone.text = widget.phone;
    gender.text = widget.gender;
    dob.text = widget.dob;
    bio.text = widget.bio;
    imageUrl = widget.photo;

    if (levels.contains(widget.level)) {
      selectedLevel = widget.level;
    }
    if (genders.contains(widget.gender)) {
      selectedGender = widget.gender;
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });

      if (kIsWeb) {
        _webFileBytes = result.files.first.bytes;
      }
    }
  }

  Future<void> sendData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${sh.getString('ip')}/edit_profile'),
    );

    request.fields['uid'] = widget.id;
    request.fields['name'] = name.text;
    request.fields['email'] = email.text;
    request.fields['phone'] = phone.text;
    request.fields['gender'] = gender.text;
    request.fields['dob'] = dob.text;
    request.fields['bio'] = bio.text;
    request.fields['level'] = selectedLevel;

    if (_selectedFile != null) {
      if (kIsWeb) {
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          _webFileBytes!,
          filename: _selectedFile!.name,
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          _selectedFile!.path!,
        ));
      }
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => home()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload Failed")),
      );
    }
  }

  // 🎨 Input Style
  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: textSecondary),
      filled: true,
      fillColor: cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: accent, width: 1.5),
      ),
    );
  }

  Widget buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedLevel,
      dropdownColor: cardColor,
      style: TextStyle(color: Colors.white),
      items: levels.map((level) {
        return DropdownMenuItem(
          value: level,
          child: Text(level),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedLevel = value!;
        });
      },
      decoration: inputStyle("Level"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // 🟢 Profile Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black,
                    backgroundImage: (_selectedFile == null && imageUrl != null)
                        ? NetworkImage(imageUrl!)
                        : null,
                    child: (_selectedFile != null)
                        ? Text("Image Selected",
                            style: TextStyle(color: Colors.white))
                        : (imageUrl == null
                            ? Icon(Icons.person,
                                size: 50, color: Colors.white)
                            : null),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: _pickFile,
                    child: Text(
                      "Change Photo",
                      style: TextStyle(color: accent),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // 🟢 Form Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  TextField(controller: name, style: TextStyle(color: Colors.white), decoration: inputStyle("Name")),
                  SizedBox(height: 12),

                  TextField(controller: email, style: TextStyle(color: Colors.white), decoration: inputStyle("Email")),
                  SizedBox(height: 12),

                  TextField(controller: phone, style: TextStyle(color: Colors.white), decoration: inputStyle("Phone")),
                  SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    dropdownColor: cardColor,
                    style: TextStyle(color: Colors.white),
                    items: genders.map((g) {
                      return DropdownMenuItem(
                        value: g,
                        child: Text(g),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                        gender.text = value;
                      });
                    },
                    decoration: inputStyle("Gender"),
                  ),

                  SizedBox(height: 12),

                  TextField(
                    controller: dob,
                    readOnly: true,
                    style: TextStyle(color: Colors.white),
                    decoration: inputStyle("DOB"),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: accent,
                                surface: cardColor,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        setState(() {
                          dob.text =
                              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        });
                      }
                    },
                  ),
                  SizedBox(height: 12),

                  buildDropdown(),
                  SizedBox(height: 12),

                  TextField(controller: bio, style: TextStyle(color: Colors.white), decoration: inputStyle("Bio")),

                  SizedBox(height: 20),

                  // 🟢 Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: sendData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "Update Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}