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
import 'dart:convert';
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

  PlatformFile? _selectedFile;
  Uint8List? _webFileBytes;
  String? imageUrl;


  // ✅ INIT
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
    // 🔥 SAFE LEVEL FIX
    if (levels.contains(widget.level)) {
      selectedLevel = widget.level;
    } else {
      selectedLevel = "Beginner";
    }
  }

  // 📸 PICK FILE
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
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

  // 🚀 SEND DATA
  Future<void> sendData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${sh.getString('ip')}/edit_profile'),
    );

    request.fields['name'] = name.text;
    request.fields['email'] = email.text;
    request.fields['phone'] = phone.text;
    request.fields['gender'] = gender.text;
    request.fields['dob'] = dob.text;
    request.fields['bio'] = bio.text;
    request.fields['uid'] = widget.id;
    request.fields['level'] = selectedLevel;

    // ✅ SAFE FILE
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => home()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload Failed")),
      );
    }
  }

  // 🎨 DROPDOWN
  Widget buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedLevel,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Level",
      ),
      items: levels.map((level) {
        return DropdownMenuItem(value: level, child: Text(level));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedLevel = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16).copyWith(bottom: 30),
          child: Column(
            children: [

              ElevatedButton.icon(
                icon: Icon(Icons.upload_file),
                label: Text("Select Profile Image"),
                onPressed: _pickFile,
              ),

              SizedBox(height: 10),

              if (_selectedFile != null)
                Text("Selected: ${_selectedFile!.name}"),

              SizedBox(height: 20),

              TextField(controller: name, decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder())),
              SizedBox(height: 15),

              TextField(controller: email, decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder())),
              SizedBox(height: 15),

              TextField(controller: phone, decoration: InputDecoration(labelText: "Phone", border: OutlineInputBorder())),
              SizedBox(height: 15),

              TextField(controller: gender, decoration: InputDecoration(labelText: "Gender", border: OutlineInputBorder())),
              SizedBox(height: 15),

              TextField(controller: dob, decoration: InputDecoration(labelText: "DOB", border: OutlineInputBorder())),
              SizedBox(height: 15),

              buildDropdown(),
              SizedBox(height: 15),

              TextField(controller: bio, decoration: InputDecoration(labelText: "Bio", border: OutlineInputBorder())),
              SizedBox(height: 25),

              ElevatedButton(
                onPressed: sendData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Update Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}