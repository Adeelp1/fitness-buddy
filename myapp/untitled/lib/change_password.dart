import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class change_passwordsub extends StatefulWidget {
  const change_passwordsub({Key? key}) : super(key: key);

  @override
  State<change_passwordsub> createState() => _change_passwordsubState();
}

class _change_passwordsubState extends State<change_passwordsub> {
  TextEditingController current_password=TextEditingController();
  TextEditingController new_password=TextEditingController();
  TextEditingController confirm_new_password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(children: [
      SizedBox(height: 20,),
      SizedBox(width: 200,child:
      TextField(controller: current_password,decoration:
      InputDecoration(hintText: "current password",border:
      OutlineInputBorder()),
      ),
      ),
      SizedBox(height: 20,),
      SizedBox(width: 200,child:
      TextField(controller: new_password,decoration:
      InputDecoration(hintText: "new password",border:
      OutlineInputBorder()),
      ),
      ),
      SizedBox(height: 20,),
      SizedBox(width: 200,child:
      TextField(controller: confirm_new_password,decoration:
      InputDecoration(hintText: "enter password again",border:
      OutlineInputBorder()),
      ),
      ),
      SizedBox(height: 20,),
      ElevatedButton(onPressed: ()async{
        SharedPreferences sh=await SharedPreferences.getInstance();
        print(current_password.text);

        if(current_password.text.isEmpty ||
            new_password.text.isEmpty ||
            confirm_new_password.text.isEmpty)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are required"),
          ),
          );
          return;
        }

        if(sh.getString('password').toString() != current_password.text)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Current password is incorrect"),
          ),
          );
          return;
        }

        if( new_password.text !=  confirm_new_password.text)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New password is incorrect"),
          ),
          );
          return;
        }

        var data=await http.post(Uri.parse("${sh.getString('ip')}/change_password_user"),
            body: {
              'uid':sh.getString('uid').toString(),
              'confirm_new_password':confirm_new_password.text,
              'new_password':new_password.text,
            }
        );
        var decoddata=json.decode(data.body);
        if(decoddata['status']=='ok'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password changed"),
          ),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
        }
      }, child: Text('change'))
    ],),),);
  }
}
