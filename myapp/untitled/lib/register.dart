import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// =====================================================
// 📦 IMPORTS (Required Libraries for Image Upload)
// =====================================================
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'dart:typed_data';

import 'home.dart';
import 'login.dart';

void main(){
  runApp(Registration());
}

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Registrationsub(),debugShowCheckedModeBanner: false,);
  }
}

class Registrationsub extends StatefulWidget {
  const Registrationsub({Key? key}) : super(key: key);

  @override
  State<Registrationsub> createState() => _RegistrationsubState();
}

class _RegistrationsubState extends State<Registrationsub> {

  final name = new TextEditingController();
  final email = new TextEditingController();
  final phone = new TextEditingController();
  final gender = new TextEditingController();
  final dob = new TextEditingController();
  final bio = new TextEditingController();
  final level = new TextEditingController();
  final password = new TextEditingController();
  final confirm_password = new TextEditingController();

  // =====================================================
  // 📸 FILE UPLOAD VARIABLES
  // =====================================================
  PlatformFile? _selectedFile;
  Uint8List? _webFileBytes;
  String? _result;
  bool _isLoading = false;

  // =====================================================
  // 📦 BATCH VARIABLES
  // =====================================================
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

  // =====================================================
  // 📸 PICK FILE FUNCTION
  // =====================================================
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any, // Any file type allowed
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
        _result = null;
      });

      if (kIsWeb) {
        _webFileBytes = result.files.first.bytes;
      }
    }
  }
  // =====================================================
  // 📸 END FILE PICK SECTION
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:
    SingleChildScrollView(child:
    SizedBox(height: 800,width: 500,child:
    Column(children: [

      // =====================================================
      // 📸 FILE SELECTOR BUTTON + PREVIEW
      // =====================================================
      ElevatedButton.icon(
        icon: Icon(Icons.upload_file),
        label: Text("Select File"),
        onPressed: _pickFile,
      ),
      if (_selectedFile != null) ...[
        SizedBox(height: 10),
        Text("Selected: ${_selectedFile!.name}"),
      ],
      // =====================================================
      // 📸 END FILE SELECTOR
      // =====================================================

      SizedBox(height: 20),
      TextField(controller: name,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'enter name',
          labelText: 'Name',
        ),),SizedBox(height: 20,),
      TextField(controller: email,
        // maxLines: 5,
        decoration: InputDecoration(
            hintText: 'Enter Email',
            labelText: 'Email',
            border: OutlineInputBorder()
        ),),SizedBox(height: 20,),
      TextField(controller: phone,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'enter phone no',
          labelText: 'phone no',
        ),),SizedBox(height: 20,),
      TextField(controller: gender,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'enter gender',
          labelText: 'gender',
        ),),SizedBox(height: 20,),
      TextField(controller: dob,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'enter dob',
          labelText: 'dob',
        ),),SizedBox(height: 20,),
      TextField(controller: bio,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'enter bio',
          labelText: 'bio',
        ),),SizedBox(height: 20,),
      // TextField(controller: level,
      //   decoration: InputDecoration(
      //     border: OutlineInputBorder(),
      //     hintText: 'enter level',
      //     labelText: 'level',
      //   ),),SizedBox(height: 20,),
      DropdownButtonFormField<String>(
        value: level.text.isNotEmpty ? level.text : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Select Level',
        ),
        items: ['Beginner', 'Intermediate', 'Advanced'].map((lvl) {
          return DropdownMenuItem<String>(
            value: lvl,
            child: Text(lvl),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            level.text = value!;
          });
        },
      ),SizedBox(height: 20,),
      DropdownButtonFormField<int>(
        value: selectedBatch,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Select Batch',
        ),
        items: batches.map((batch) {
          return DropdownMenuItem<int>(
            value: batch['id'],
            child: Text('${batch['batch']} (${batch['from_time']} - ${batch['to_time']})'),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedBatch = value;
          });
        },
      ),SizedBox(height: 20,),
      TextField(controller: password,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'enter password',
          labelText: 'password',
        ),),SizedBox(height: 20,),
      TextField(controller: confirm_password,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'enter confirm_password',
          labelText: 'confirm_password',
        ),),SizedBox(height: 20,),



      ElevatedButton(onPressed: () async {
        // print(item_name.text);
        // print(description.text);
        // print(location.text);

        SharedPreferences sh=await SharedPreferences.getInstance();

        // =====================================================
        // 🌐 SERVER REQUEST (POST to Django)
        // =====================================================
        var request =   await http.MultipartRequest(
            'POST',
            Uri.parse('${sh.getString('ip')}/user_registration')
        );

        // 🔹 Normal Form Data
        request.fields['name'] = name.text;
        request.fields['email'] = email.text;
        request.fields['phone'] = phone.text;
        request.fields['gender'] = gender.text;
        request.fields['dob'] = dob.text;
        request.fields['bio'] = bio.text;
        request.fields['level'] = level.text;
        request.fields['batch'] = selectedBatch.toString();
        request.fields['password'] = password.text;
        request.fields['confirm_password'] = confirm_password.text;
        // request.fields['uid'] = sh.getString('uid').toString();

        // 🔹 File Upload Part
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
        // =====================================================
        // 🌐 END SERVER UPLOAD SECTION
        // =====================================================

        var response = await request.send();

        Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));

      }, child: Text('register'))

    ],),),),),);
  }
}