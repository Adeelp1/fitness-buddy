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

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('USER HOME'),centerTitle: true,),
    drawer: Drawer(
      child: ListView(
        children: [
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_profile_sub()));},title: Text('VIEW PROFILE'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>change_passwordsub()));},title: Text('CHANGE PASSWORD'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_events_sub()));},title: Text('VIEW EVENTS'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_health_details_sub()));},title: Text('VIEW HEALTH DETAILS'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_payment_sub()));},title: Text('VIEW PAYMENT'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>view_trainer_sub()));},title: Text('VIEW TRAINER'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentPage()));},title: Text('PAYMENT'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>add_health_details_sub()));},title: Text('ADD HEALTH DETAILS'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>login()));},title: Text('LOGOUT'),),
          ListTile(onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>FoodScannerPage()));},title: Text('food'),),

        ],
      ),
    ),);
  }
}
