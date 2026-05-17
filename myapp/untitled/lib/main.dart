import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 👈 make false to HIDE DEBUG BANNER 

      theme: ThemeData(
        // scaffoldBackgroundColor: Color(0xFF0B0F14),

        appBarTheme: AppBarTheme(
          // backgroundColor: Color(0xFF0B0F14),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xFFB6FF3B), // 👈 FIX BACK BUTTON GLOBALLY
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          centerTitle: true,
        ),

        // inputDecorationTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Color(0xFF12181F),
      //     labelStyle: TextStyle(color: Color(0xFF9CA3AF)),
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(14),
      //       borderSide: BorderSide.none,
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(14),
      //       borderSide: BorderSide(color: Color(0xFFB6FF3B), width: 1.5),
      //     ),
      //   ),

      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: Color(0xFFB6FF3B),
      //       foregroundColor: Colors.black,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(14),
      //       ),
      //     ),
      //   ),
      ),

      title: 'Fitness Buddy',
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
  final ip=new TextEditingController(text:'10.96.67.106');
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

