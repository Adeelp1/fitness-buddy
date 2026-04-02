import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ip connect',
      home: ipconnect(),

    );
  }
}
class ipconnect extends StatefulWidget {
  const ipconnect({Key? key}) : super(key: key);

  @override
  State<ipconnect> createState() => _ipconnectState();
}

class _ipconnectState extends State<ipconnect> {
  final ip=new TextEditingController(text:'192.168.29.193');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IP CONNECTION'),centerTitle: true,),
      body:
        Center(child: Container(child:Center(child: Column(children: [
          TextField(controller: ip,decoration: InputDecoration(labelText: "IP ADDRESS",border: OutlineInputBorder()),),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async{
            SharedPreferences sh=await SharedPreferences.getInstance();
            sh.setString('ip',"http://${ip.text}:9000");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>login_sub()));
          }, child:Text('CONNECT'))
        ],),)),)
    );
  }
}

