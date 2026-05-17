// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// // =====================================================
// // 📦 IMPORTS (Required Libraries for Image Upload)
// // =====================================================
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart'; // kIsWeb
// import 'dart:typed_data';
//
// import 'home.dart';
// import 'login.dart';
//
// void main(){
//   runApp(Registration());
// }
//
// class Registration extends StatelessWidget {
//   const Registration({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Registrationsub(),debugShowCheckedModeBanner: false,);
//   }
// }
//
// class Registrationsub extends StatefulWidget {
//   const Registrationsub({Key? key}) : super(key: key);
//
//   @override
//   State<Registrationsub> createState() => _RegistrationsubState();
// }
//
// class _RegistrationsubState extends State<Registrationsub> {
//
//   final name = new TextEditingController();
//   final email = new TextEditingController();
//   final phone = new TextEditingController();
//   final gender = new TextEditingController();
//   final dob = new TextEditingController();
//   final bio = new TextEditingController();
//   final level = new TextEditingController();
//   final password = new TextEditingController();
//   final confirm_password = new TextEditingController();
//
//   // =====================================================
//   // 📸 FILE UPLOAD VARIABLES
//   // =====================================================
//   PlatformFile? _selectedFile;
//   Uint8List? _webFileBytes;
//   String? _result;
//   bool _isLoading = false;
//
//   // =====================================================
//   // 📦 BATCH VARIABLES
//   // =====================================================
//   List<Map<String, dynamic>> batches = [];
//   int? selectedBatch;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchBatches();
//   }
//
//   Future<void> fetchBatches() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     var url = Uri.parse('${sh.getString('ip')}/get_batches');
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       if (data['status'] == 'ok') {
//         setState(() {
//           batches = List<Map<String, dynamic>>.from(data['batches']);
//         });
//       }
//     }
//   }
//
//   // =====================================================
//   // 📸 PICK FILE FUNCTION
//   // =====================================================
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.any, // Any file type allowed
//     );
//
//     if (result != null) {
//       setState(() {
//         _selectedFile = result.files.first;
//         _result = null;
//       });
//
//       if (kIsWeb) {
//         _webFileBytes = result.files.first.bytes;
//       }
//     }
//   }
//   // =====================================================
//   // 📸 END FILE PICK SECTION
//   // =====================================================
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child:
//     SingleChildScrollView(child:
//     SizedBox(height: 800,width: 500,child:
//     Column(children: [
//
//       // =====================================================
//       // 📸 FILE SELECTOR BUTTON + PREVIEW
//       // =====================================================
//       ElevatedButton.icon(
//         icon: Icon(Icons.upload_file),
//         label: Text("Select File"),
//         onPressed: _pickFile,
//       ),
//       if (_selectedFile != null) ...[
//         SizedBox(height: 10),
//         Text("Selected: ${_selectedFile!.name}"),
//       ],
//       // =====================================================
//       // 📸 END FILE SELECTOR
//       // =====================================================
//
//       SizedBox(height: 20),
//       TextField(controller: name,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'enter name',
//           labelText: 'Name',
//         ),),SizedBox(height: 20,),
//       TextField(controller: email,
//         // maxLines: 5,
//         decoration: InputDecoration(
//             hintText: 'Enter Email',
//             labelText: 'Email',
//             border: OutlineInputBorder()
//         ),),SizedBox(height: 20,),
//       TextField(controller: phone,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'enter phone no',
//           labelText: 'phone no',
//         ),),SizedBox(height: 20,),
//       TextField(controller: gender,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'enter gender',
//           labelText: 'gender',
//         ),),SizedBox(height: 20,),
//       TextField(controller: dob,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'enter dob',
//           labelText: 'dob',
//         ),),SizedBox(height: 20,),
//       TextField(controller: bio,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'enter bio',
//           labelText: 'bio',
//         ),),SizedBox(height: 20,),
//       // TextField(controller: level,
//       //   decoration: InputDecoration(
//       //     border: OutlineInputBorder(),
//       //     hintText: 'enter level',
//       //     labelText: 'level',
//       //   ),),SizedBox(height: 20,),
//       DropdownButtonFormField<String>(
//         value: level.text.isNotEmpty ? level.text : null,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           labelText: 'Select Level',
//         ),
//         items: ['Beginner', 'Intermediate', 'Advanced'].map((lvl) {
//           return DropdownMenuItem<String>(
//             value: lvl,
//             child: Text(lvl),
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             level.text = value!;
//           });
//         },
//       ),SizedBox(height: 20,),
//       DropdownButtonFormField<int>(
//         value: selectedBatch,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           labelText: 'Select Batch',
//         ),
//         items: batches.map((batch) {
//           return DropdownMenuItem<int>(
//             value: batch['id'],
//             child: Text('${batch['batch']} (${batch['from_time']} - ${batch['to_time']})'),
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             selectedBatch = value;
//           });
//         },
//       ),SizedBox(height: 20,),
//       TextField(controller: password,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'enter password',
//           labelText: 'password',
//         ),),SizedBox(height: 20,),
//       TextField(controller: confirm_password,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'enter confirm_password',
//           labelText: 'confirm_password',
//         ),),SizedBox(height: 20,),
//
//
//
//       ElevatedButton(onPressed: () async {
//         // print(item_name.text);
//         // print(description.text);
//         // print(location.text);
//
//         SharedPreferences sh=await SharedPreferences.getInstance();
//
//         // =====================================================
//         // 🌐 SERVER REQUEST (POST to Django)
//         // =====================================================
//         var request =   await http.MultipartRequest(
//             'POST',
//             Uri.parse('${sh.getString('ip')}/user_registration')
//         );
//
//         // 🔹 Normal Form Data
//         request.fields['name'] = name.text;
//         request.fields['email'] = email.text;
//         request.fields['phone'] = phone.text;
//         request.fields['gender'] = gender.text;
//         request.fields['dob'] = dob.text;
//         request.fields['bio'] = bio.text;
//         request.fields['level'] = level.text;
//         request.fields['batch'] = selectedBatch.toString();
//         request.fields['password'] = password.text;
//         request.fields['confirm_password'] = confirm_password.text;
//         // request.fields['uid'] = sh.getString('uid').toString();
//
//         // 🔹 File Upload Part
//         if (kIsWeb) {
//           request.files.add(http.MultipartFile.fromBytes(
//             'file',
//             _webFileBytes!,
//             filename: _selectedFile!.name,
//           ));
//         } else {
//           request.files.add(await http.MultipartFile.fromPath(
//             'file',
//             _selectedFile!.path!,
//           ));
//         }
//         // =====================================================
//         // 🌐 END SERVER UPLOAD SECTION
//         // =====================================================
//
//         var response = await request.send();
//
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
//
//       }, child: Text('register'))
//
//     ],),),),),);
//   }
// }

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';

void main() {
  runApp(Registration());
}

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registrationsub(),
    );
  }
}

class Registrationsub extends StatefulWidget {
  const Registrationsub({Key? key}) : super(key: key);

  @override
  State<Registrationsub> createState() => _RegistrationsubState();
}

class _RegistrationsubState extends State<Registrationsub> {

  // 🎨 THEME COLORS
  final Color bgColor = Color(0xFF0B0F14);
  final Color cardColor = Color(0xFF12181F);
  final Color accent = Color(0xFFB6FF3B);
  final Color textSecondary = Color(0xFF9CA3AF);

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final gender = TextEditingController();
  final dob = TextEditingController();
  final bio = TextEditingController();
  final level = TextEditingController();
  final password = TextEditingController();
  final confirm_password = TextEditingController();

  PlatformFile? _selectedFile;
  Uint8List? _webFileBytes;

  List<Map<String, dynamic>> batches = [];
  int? selectedBatch;

  @override
  void initState() {
    super.initState();
    fetchBatches();
  }

  Future<void> fetchBatches() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var url = Uri.parse('${sh.getString('ip')}/get_batches');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'ok') {
        setState(() {
          batches = List<Map<String, dynamic>>.from(data['batches']);
        });
      }
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // 🔥 TITLE
                  Text(
                    "CREATE ACCOUNT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  SizedBox(height: 25),

                  // 📸 UPLOAD BUTTON
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: Icon(Icons.upload),
                    label: Text("Upload Profile"),
                    onPressed: _pickFile,
                  ),

                  if (_selectedFile != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _selectedFile!.name,
                        style: TextStyle(color: textSecondary),
                      ),
                    ),

                  SizedBox(height: 20),

                  buildInput(name, "Name"),
                  buildInput(email, "Email"),
                  buildInput(phone, "Phone"),
                  buildInput(gender, "Gender"),
                  buildInput(dob, "DOB"),
                  buildInput(bio, "Bio"),

                  SizedBox(height: 10),

                  neonDropdown(
                    child: DropdownButtonFormField<String>(
                      value: level.text.isNotEmpty ? level.text : null,
                      dropdownColor: cardColor,
                      decoration: InputDecoration(border: InputBorder.none),
                      hint: Text("Select Level",
                          style: TextStyle(color: textSecondary)),
                      items: ['Beginner', 'Intermediate', 'Advanced']
                          .map((lvl) => DropdownMenuItem(
                        value: lvl,
                        child: Text(lvl,
                            style: TextStyle(color: Colors.white)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          level.text = value!;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 15),

                  neonDropdown(
                    child: DropdownButtonFormField<int>(
                      value: selectedBatch,
                      dropdownColor: cardColor,
                      decoration: InputDecoration(border: InputBorder.none),
                      hint: Text("Select Batch",
                          style: TextStyle(color: textSecondary)),
                      items: batches.map((batch) {
                        return DropdownMenuItem<int>(
                          value: batch['id'],
                          child: Text(
                            '${batch['batch']} (${batch['from_time']} - ${batch['to_time']})',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBatch = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 15),

                  buildInput(password, "Password", obscure: true),
                  buildInput(confirm_password, "Confirm Password", obscure: true),

                  SizedBox(height: 25),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: accent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () async {
                      SharedPreferences sh =
                      await SharedPreferences.getInstance();

                      var request = await http.MultipartRequest(
                          'POST',
                          Uri.parse('${sh.getString('ip')}/user_registration'));

                      request.fields['name'] = name.text;
                      request.fields['email'] = email.text;
                      request.fields['phone'] = phone.text;
                      request.fields['gender'] = gender.text;
                      request.fields['dob'] = dob.text;
                      request.fields['bio'] = bio.text;
                      request.fields['level'] = level.text;
                      request.fields['batch'] = selectedBatch.toString();
                      request.fields['password'] = password.text;
                      request.fields['confirm_password'] =
                          confirm_password.text;

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

                      await request.send();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => login()));
                    },
                    child: Text("REGISTER",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 INPUT FIELD
  Widget buildInput(TextEditingController controller, String hint,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: cardColor,
          hintText: hint,
          hintStyle: TextStyle(color: textSecondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: accent, width: 1.5),
          ),
        ),
      ),
    );
  }

  // 🔥 DROPDOWN CONTAINER
  Widget neonDropdown({required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent),
      ),
      child: child,
    );
  }
}