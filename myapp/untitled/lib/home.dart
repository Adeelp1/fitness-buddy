// import 'package:flutter/material.dart';
// import 'package:untitled/RazorpayScreen.dart';
// import 'package:untitled/login.dart';
// import 'package:untitled/select_payment.dart';
// import 'package:untitled/view_events.dart';
// import 'package:untitled/view_health_details.dart';
// import 'package:untitled/view_payment.dart';
// import 'package:untitled/view_profile.dart';
// import 'package:untitled/view_trainer.dart';

// import 'add_health_details.dart';
// import 'change_password.dart';
// import 'foodrecognition app.dart';

// class home extends StatefulWidget {
//   const home({Key? key}) : super(key: key);

//   @override
//   State<home> createState() => _homeState();
// }

// class _homeState extends State<home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: Text('USER HOME'),centerTitle: true,),
//     drawer: Drawer(
//       child: ListView(
//         children: [
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_profile_sub()));},title: Text('VIEW PROFILE'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>change_passwordsub()));},title: Text('CHANGE PASSWORD'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_events_sub()));},title: Text('VIEW EVENTS'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_health_details_sub()));},title: Text('VIEW HEALTH DETAILS'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_payment_sub()));},title: Text('VIEW PAYMENT'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_trainer_sub()));},title: Text('VIEW TRAINER'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentPage()));},title: Text('PAYMENT'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>add_health_details_sub()));},title: Text('ADD HEALTH DETAILS'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>login()));},title: Text('LOGOUT'),),
//           ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>FoodScannerPage()));},title: Text('food'),),

//         ],
//       ),
//     ),);
//   }
// }


import 'package:flutter/material.dart';
import 'package:untitled/RazorpayScreen.dart';
import 'package:untitled/login.dart';
import 'package:untitled/select_payment.dart';
import 'package:untitled/view_events.dart';
import 'package:untitled/view_health_details.dart';
import 'package:untitled/view_payment.dart';
import 'package:untitled/view_profile.dart';
import 'package:untitled/view_trainer.dart';

import 'add_health_details.dart';
import 'change_password.dart';
import 'foodrecognition app.dart';
import 'view_dietplans.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  final Color bgColor = const Color(0xFF0B0F14);
  final Color cardColor = const Color(0xFF12181F);
  final Color neon = const Color(0xFFB6FF3B);
  final Color textGrey = const Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          "USER HOME",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: neon),
      ),

      drawer: Drawer(
        backgroundColor: bgColor,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            const SizedBox(height: 20),

            Text("MENU",
                style: TextStyle(color: neon, fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            drawerItem("VIEW PROFILE", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => view_profile_sub()));
            }),

            drawerItem("CHANGE PASSWORD", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => change_passwordsub()));
            }),

            drawerItem("VIEW EVENTS", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => view_events_sub()));
            }),

            drawerItem("VIEW HEALTH DETAILS", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => view_health_details_sub()));
            }),

            drawerItem("VIEW PAYMENT", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => view_payment_sub()));
            }),

            drawerItem("VIEW TRAINER", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => view_trainer_sub()));
            }),

            drawerItem("PAYMENT", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
            }),

            drawerItem("ADD HEALTH DETAILS", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_health_details_sub()));
            }),

            drawerItem("VIEW DIET PLANS", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => view_dietplans()));
            }),

            drawerItem("FOOD SCAN", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FoodScannerPage()));
            }),

            drawerItem("LOGOUT", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
            }),

          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Greeting
            const Text(
              "Hello User 👋",
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              "Let's stay fit today",
              style: TextStyle(color: textGrey),
            ),

            const SizedBox(height: 20),

            /// Health Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Health Grade",
                          style: TextStyle(color: textGrey)),
                      const SizedBox(height: 10),
                      Text("A+",
                          style: TextStyle(
                              color: neon,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),

                  Icon(Icons.favorite, color: neon, size: 40)

                ],
              ),
            ),

            const SizedBox(height: 25),

            /// Quick Actions Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [

                actionCard("Profile", Icons.person, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_profile_sub()));
                }),

                actionCard("Trainer", Icons.fitness_center, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_trainer_sub()));
                }),

                actionCard("Payments", Icons.payment, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_payment_sub()));
                }),

                actionCard("Events", Icons.event, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_events_sub()));
                }),

                actionCard("Health", Icons.health_and_safety, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_health_details_sub()));
                }),

                actionCard("View Diet Plans", Icons.lock, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => view_dietplans()));
                }),

                actionCard("Food Scan", Icons.camera_alt, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoodScannerPage()));
                }),

              ],
            ),

          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: cardColor,
        selectedItemColor: neon,
        unselectedItemColor: textGrey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: ""),
        ],
      ),
    );
  }

  /// Drawer Item
  Widget drawerItem(String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: neon, size: 16),
      ),
    );
  }

  /// Action Card
  Widget actionCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, color: neon, size: 30),

            const SizedBox(height: 12),

            Text(title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),

          ],
        ),
      ),
    );
  }
}