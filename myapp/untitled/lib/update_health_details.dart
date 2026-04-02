import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class update_health_details_sub extends StatefulWidget {
  final String id;
  final String title;
  final String details;

  const update_health_details_sub({
    Key? key,
    required this.id,
    required this.title,
    required this.details,
  }) : super(key: key);

  @override
  State<update_health_details_sub> createState() =>
      _update_health_details_subState();
}

class _update_health_details_subState
    extends State<update_health_details_sub> {
  final title = TextEditingController();
  final details = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ FIX: set initial values
    title.text = widget.title;
    details.text = widget.details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "Edit Health Details",
              style: TextStyle(color: Colors.green, fontSize: 30),
            ),
            SizedBox(height: 50),

            SizedBox(
              height: 80,
              width: 300,
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.limeAccent,
                  hintText: "Enter Title",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(
              height: 80,
              width: 300,
              child: TextField(
                controller: details,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.limeAccent,
                  hintText: "Enter details",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences sh =
                  await SharedPreferences.getInstance();

                  var data = await http.post(
                    Uri.parse(
                        "${sh.getString('ip')}/update_health_details"),
                    body: {
                      // ✅ FIX: include id
                      'id': widget.id,
                      'title': title.text,
                      'details': details.text,
                      'uid': sh.getString('uid').toString()
                    },
                  );

                  var decodd = json.decode(data.body);

                  if (decodd['status'] == 'ok') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => home()),
                    );
                  }
                },
                child: const Text("Update"), // ✅ better label
              ),
            ),
          ],
        ),
      ),
    );
  }
}