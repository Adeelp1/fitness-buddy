import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/view_videos.dart';

import 'chat.dart';
import 'view_tips.dart';

class view_trainer extends StatelessWidget {
  const view_trainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: view_trainer_sub(),);
  }
}

class view_trainer_sub extends StatefulWidget {
  const view_trainer_sub({Key? key}) : super(key: key);

  @override
  State<view_trainer_sub> createState() => _view_trainer_subState();
}

class _view_trainer_subState extends State<view_trainer_sub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("uid").toString();
    // String foodimage = "";
    var data = await http.post(
        Uri.parse(prefs.getString("ip").toString()+"/view_trainer"),
        body: {"uid":b}
    );

    var jsonData = json.decode(data.body);
//    print(jsonData);
    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      Joke newJoke = Joke(
          // id:       joke["id"].toString(),
          // login:    joke["login"].toString(),
          name:     joke["name"].toString(),
          email:    joke["email"].toString(),
          photo:    joke["photo"].toString(),
          phone:    joke["phone"].toString(),
          place:    joke["place"].toString(),
          post:     joke["post"].toString(),
          pin:      joke["pin"].toString(),
          joinDate: joke["joinDate"].toString(),
          bio:      joke["bio"].toString(),
          tid: joke["tid"].toString(),
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view trainer"),
      ),
      body:
      Container(
        child:
        FutureBuilder(
          future: _getJokes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
//              print("snapshot"+snapshot.toString());
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var i = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            _buildRow("Name:", i.name.toString()),
                            _buildRow("Email:", i.email.toString()),
                            _buildRow("Phone:", i.phone.toString()),
                            _buildRow("Photo:", i.photo.toString()),
                            _buildRow("Place:", i.place.toString()),
                            _buildRow("post:", i.post.toString()),
                            _buildRow("Pin:", i.pin.toString()),
                            _buildRow("Join Date:", i.joinDate.toString()),
                            _buildRow("Bio:", i.bio.toString()),

                            Row(children: [
                              ElevatedButton(onPressed: () async {
                                SharedPreferences sh=await SharedPreferences.getInstance();
                                sh.setString('tid', i.tid.toString());
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>MyChatApp()));
                              }, child: Text("CHAT")),


                              ElevatedButton(onPressed: () async {
                                SharedPreferences sh=await SharedPreferences.getInstance();
                                sh.setString('tid', i.tid.toString());
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>view_tips_sub()));
                              }, child: Text("View Tips")),
                              ElevatedButton(onPressed: () async {
                                SharedPreferences sh=await SharedPreferences.getInstance();
                                sh.setString('tid', i.tid.toString());
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>ViewVideos()));
                              }, child: Text("View Videos"))
                            ],)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 5),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Joke {
  // final String id;
  // final String login;
  final String name;
  final String email;
  final String photo;
  final String phone;
  final String place;
  final String post;
  final String pin;
  final String joinDate;
  final String bio;
  final String tid;

  Joke({
    // required this.id,
    // required this.login,
    required this.name,
    required this.email,
    required this.photo,
    required this.phone,
    required this.place,
    required this.post,
    required this.pin,
    required this.joinDate,
    required this.bio,
    required this.tid
  });
}

