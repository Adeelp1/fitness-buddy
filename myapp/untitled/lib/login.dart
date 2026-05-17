// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import 'forgotemail.dart';
// import 'home.dart';
// import 'register.dart';

// void main(){
//   runApp(login());
// }

// class login extends StatelessWidget {
//   const login({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: login_sub(),);
//   }
// }

// class login_sub extends StatefulWidget {
//   const login_sub({Key? key}) : super(key: key);

//   @override
//   State<login_sub> createState() => _login_subState();
// }

// class _login_subState extends State<login_sub> {
//   final username=new TextEditingController(text: 'hi@gmail.com');
//   final password=new TextEditingController(text: '12345678');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar:AppBar(title: Text('LOGIN PAGE'),centerTitle: true,),
//     body: Center(
//       child: Column(children: [
//         SizedBox(height: 50,),
//         Text("LOGIN", style: TextStyle(color: Colors.green, fontSize: 30,),),
//         const SizedBox(height: 50,),
//         SizedBox(height: 80, width:  300, child: TextField(
//           controller: username,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.limeAccent,
//             prefixIcon: Icon(Icons.person),
//             hintText: "Enter your Name",
//             border: OutlineInputBorder()
//           ),
//         ),),
//         SizedBox(height: 80, width: 300, child: TextField(
//           controller: password,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.limeAccent,
//             prefixIcon: Icon(Icons.password),
//             hintText: "Enter your Password",
//             border: OutlineInputBorder()
//           ),
//         ),),
//         SizedBox(height: 50, width: 150, child: ElevatedButton(onPressed: ()async{
//           SharedPreferences sh = await SharedPreferences.getInstance();
//           var data = await http.post(Uri.parse("${sh.getString('ip')}/user_login"),
//           body: {
//             'username': username.text,
//             'password': password.text,

//           });
//           var decoded = json.decode(data.body);
//           if(decoded['status'] == 'ok'){
//             sh.setString('uid',decoded['uid'].toString());
//             sh.setString('password',password.text);
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('login sucess')));
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
//           }


//         }, child: const Text("LOGIN")),),
//         ElevatedButton(onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
//         }, child: Text("Register")),
//         ElevatedButton(onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotemail()));
//         }, child: Text("Forgot password"))
//       ],),
//     )
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'forgotemail.dart';
import 'home.dart';
import 'register.dart';

void main() {
  runApp(login());
}

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_sub(),
    );
  }
}

class login_sub extends StatefulWidget {
  const login_sub({Key? key}) : super(key: key);

  @override
  State<login_sub> createState() => _login_subState();
}

class _login_subState extends State<login_sub> {
  final username = TextEditingController(text: 'hi@gmail.com');
  final password = TextEditingController(text: '12345678');

  final Color bgColor = const Color(0xFF0B0F14);
  final Color cardColor = const Color(0xFF12181F);
  final Color accent = const Color(0xFFB6FF3B);
  final Color textSecondary = const Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 👋 Greeting
              const SizedBox(height: 20),
              const Text(
                "Hello User 👋",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Welcome back, login to continue",
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 40),

              /// 🧾 Login Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    /// Username Field
                    _buildTextField(
                      controller: username,
                      hint: "Email",
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 20),

                    /// Password Field
                    _buildTextField(
                      controller: password,
                      hint: "Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 30),

                    /// Login Button (LOGIC NOT CHANGED)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences sh =
                              await SharedPreferences.getInstance();

                          var data = await http.post(
                            Uri.parse("${sh.getString('ip')}/user_login"),
                            body: {
                              'username': username.text,
                              'password': password.text,
                            },
                          );

                          var decoded = json.decode(data.body);

                          if (decoded['status'] == 'ok') {
                            sh.setString('uid', decoded['uid'].toString());
                            sh.setString('password', password.text);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('login sucess')),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => home()),
                            );
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// Forgot Password
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => forgotemail()),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: textSecondary),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Register
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Registration()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: textSecondary),
                      children: [
                        TextSpan(
                          text: "Register",
                          style: TextStyle(
                            color: accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔁 Reusable Input Field (UI only)
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}