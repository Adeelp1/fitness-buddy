import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'forgotemail.dart';
import 'home.dart';
import 'register.dart';

void main(){
  runApp(login());
}

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: login_sub(),);
  }
}

class login_sub extends StatefulWidget {
  const login_sub({Key? key}) : super(key: key);

  @override
  State<login_sub> createState() => _login_subState();
}

class _login_subState extends State<login_sub> {
  final username=new TextEditingController(text: 'hi@gmail.com');
  final password=new TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(title: Text('LOGIN PAGE'),centerTitle: true,),
    body: Center(
      child: Column(children: [
        SizedBox(height: 50,),
        Text("LOGIN", style: TextStyle(color: Colors.green, fontSize: 30,),),
        const SizedBox(height: 50,),
        SizedBox(height: 80, width:  300, child: TextField(
          controller: username,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.limeAccent,
            prefixIcon: Icon(Icons.person),
            hintText: "Enter your Name",
            border: OutlineInputBorder()
          ),
        ),),
        SizedBox(height: 80, width: 300, child: TextField(
          controller: password,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.limeAccent,
            prefixIcon: Icon(Icons.password),
            hintText: "Enter your Password",
            border: OutlineInputBorder()
          ),
        ),),
        SizedBox(height: 50, width: 150, child: ElevatedButton(onPressed: ()async{
          SharedPreferences sh = await SharedPreferences.getInstance();
          var data = await http.post(Uri.parse("${sh.getString('ip')}/user_login"),
          body: {
            'username': username.text,
            'password': password.text,

          });
          var decoded = json.decode(data.body);
          if(decoded['status'] == 'ok'){
            sh.setString('uid',decoded['uid'].toString());
            sh.setString('password',password.text);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('login sucess')));
            Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
          }


        }, child: const Text("LOGIN")),),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
        }, child: Text("Register")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotemail()));
        }, child: Text("Forgot password"))
      ],),
    )
    );
  }
}
