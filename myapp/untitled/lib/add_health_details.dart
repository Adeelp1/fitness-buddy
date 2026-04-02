import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class add_health_details extends StatelessWidget {
  const add_health_details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: add_health_details_sub(),);
  }
}

class add_health_details_sub extends StatefulWidget {
  const add_health_details_sub({Key? key}) : super(key: key);

  @override
  State<add_health_details_sub> createState() => _add_health_details_subState();
}

class _add_health_details_subState extends State<add_health_details_sub> {
  final title = new TextEditingController();
  final details = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(height: 50,),
          Text("Add Health Details", style: TextStyle(color: Colors.green, fontSize: 30,),),
          SizedBox(height: 50,),
          SizedBox(height: 80, width: 300, child: TextField(
            controller: title,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.limeAccent,
              hintText: "Enter Title",
              border: OutlineInputBorder()
            ),
          ),),
          SizedBox(height: 80, width: 300, child: TextField(
            controller: details,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.limeAccent,
              hintText: "Enter your details",
              border: OutlineInputBorder()
            ),
          ),),
          SizedBox(height: 50, width: 150, child: ElevatedButton(onPressed: ()async{
            SharedPreferences sh = await SharedPreferences.getInstance();
            var data = await http.post(Uri.parse("${sh.getString('ip')}/add_health_details"),
            body: {
              'title': title.text,
              'details': details.text,
              'uid':sh.getString('uid').toString()
            });
            var decodd=json.decode(data.body);
            if(decodd['status']=='ok'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
            }
          },
              child: const Text("Add")),)
        ],),
      ),
    );
  }
}
