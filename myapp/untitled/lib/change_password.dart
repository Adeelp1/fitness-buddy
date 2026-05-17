// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import 'login.dart';

// class change_passwordsub extends StatefulWidget {
//   const change_passwordsub({Key? key}) : super(key: key);

//   @override
//   State<change_passwordsub> createState() => _change_passwordsubState();
// }

// class _change_passwordsubState extends State<change_passwordsub> {
//   TextEditingController current_password=TextEditingController();
//   TextEditingController new_password=TextEditingController();
//   TextEditingController confirm_new_password=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Column(children: [
//       SizedBox(height: 20,),
//       SizedBox(width: 200,child:
//       TextField(controller: current_password,decoration:
//       InputDecoration(hintText: "current password",border:
//       OutlineInputBorder()),
//       ),
//       ),
//       SizedBox(height: 20,),
//       SizedBox(width: 200,child:
//       TextField(controller: new_password,decoration:
//       InputDecoration(hintText: "new password",border:
//       OutlineInputBorder()),
//       ),
//       ),
//       SizedBox(height: 20,),
//       SizedBox(width: 200,child:
//       TextField(controller: confirm_new_password,decoration:
//       InputDecoration(hintText: "enter password again",border:
//       OutlineInputBorder()),
//       ),
//       ),
//       SizedBox(height: 20,),
//       ElevatedButton(onPressed: ()async{
//         SharedPreferences sh=await SharedPreferences.getInstance();
//         print(current_password.text);

//         if(current_password.text.isEmpty ||
//             new_password.text.isEmpty ||
//             confirm_new_password.text.isEmpty)
//         {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are required"),
//           ),
//           );
//           return;
//         }

//         if(sh.getString('password').toString() != current_password.text)
//         {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Current password is incorrect"),
//           ),
//           );
//           return;
//         }

//         if( new_password.text !=  confirm_new_password.text)
//         {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New password is incorrect"),
//           ),
//           );
//           return;
//         }

//         var data=await http.post(Uri.parse("${sh.getString('ip')}/change_password_user"),
//             body: {
//               'uid':sh.getString('uid').toString(),
//               'confirm_new_password':confirm_new_password.text,
//               'new_password':new_password.text,
//             }
//         );
//         var decoddata=json.decode(data.body);
//         if(decoddata['status']=='ok'){
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password changed"),
//           ),
//           );
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
//         }
//       }, child: Text('change'))
//     ],),),);
//   }
// }


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
  TextEditingController current_password = TextEditingController();
  TextEditingController new_password = TextEditingController();
  TextEditingController confirm_new_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F14),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFB6FF3B)),
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF12181F),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFB6FF3B).withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Text(
                  "Update Your Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                /// CURRENT PASSWORD
                TextField(
                  controller: current_password,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Current Password",
                    hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                    filled: true,
                    fillColor: const Color(0xFF0B0F14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFFB6FF3B)),
                  ),
                ),

                const SizedBox(height: 20),

                /// NEW PASSWORD
                TextField(
                  controller: new_password,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "New Password",
                    hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                    filled: true,
                    fillColor: const Color(0xFF0B0F14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.vpn_key, color: Color(0xFFB6FF3B)),
                  ),
                ),

                const SizedBox(height: 20),

                /// CONFIRM PASSWORD
                TextField(
                  controller: confirm_new_password,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                    filled: true,
                    fillColor: const Color(0xFF0B0F14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.check_circle, color: Color(0xFFB6FF3B)),
                  ),
                ),

                const SizedBox(height: 30),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB6FF3B),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      shadowColor: const Color(0xFFB6FF3B),
                    ),
                    onPressed: () async {
                      SharedPreferences sh =
                          await SharedPreferences.getInstance();
                      print(current_password.text);

                      if (current_password.text.isEmpty ||
                          new_password.text.isEmpty ||
                          confirm_new_password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("All fields are required")),
                        );
                        return;
                      }

                      if (sh.getString('password').toString() !=
                          current_password.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Current password is incorrect")),
                        );
                        return;
                      }

                      if (new_password.text != confirm_new_password.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("New password is incorrect")),
                        );
                        return;
                      }

                      var data = await http.post(
                          Uri.parse(
                              "${sh.getString('ip')}/change_password_user"),
                          body: {
                            'uid': sh.getString('uid').toString(),
                            'confirm_new_password':
                                confirm_new_password.text,
                            'new_password': new_password.text,
                          });

                      var decoddata = json.decode(data.body);
                      if (decoddata['status'] == 'ok') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password changed")),
                        );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()));
                      }
                    },
                    child: const Text(
                      "CHANGE PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}