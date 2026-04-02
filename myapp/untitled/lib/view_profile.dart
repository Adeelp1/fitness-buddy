import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile.dart';
import 'edit_user_profile_photo.dart';

class view_profile extends StatelessWidget {
  const view_profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: view_profile_sub(),);
  }
}

class view_profile_sub extends StatefulWidget {
  const view_profile_sub({Key? key}) : super(key: key);

  @override
  State<view_profile_sub> createState() => _view_profile_subState();
}

class _view_profile_subState extends State<view_profile_sub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("uid").toString();
    // String foodimage = "";
    var data = await http.post(
        Uri.parse(prefs.getString("ip").toString()+"/view_profile"),
        body: {"uid":prefs.getString("uid").toString()}
    );

    var jsonData = json.decode(data.body);
//    print(jsonData);
    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      Joke newJoke = Joke(
         id:       joke["id"].toString(),
        // login:    joke["login"].toString(),
          name:     joke["name"].toString(),
          email:    joke["email"].toString(),
          photo:    prefs.getString("ip").toString()+joke["photo"].toString(),
          phone:    joke["phone"].toString(),
          gender:    joke["gender"].toString(),
          level:     joke["level"].toString(),
          dob:      joke["dob"].toString(),
          bio:      joke["bio"].toString()
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view profile"),
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
                            _buildRow("id:", i.id.toString()),

                            _buildRow("Name:", i.name.toString()),
                            _buildRow("Email:", i.email.toString()),
                            _buildRow("Phone:", i.phone.toString()),
                            Image.network(i.photo,height: 200,width: 200,),
                            _buildRow("Gender:", i.gender.toString()),
                            _buildRow("Dob:", i.dob.toString()),
                            _buildRow("Level:", i.level.toString()),
                            _buildRow("Bio:", i.bio.toString()),
                            ElevatedButton(onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => edit_user_profile_photosub(
                                    id: i.id,
                                    name: i.name,
                                    email: i.email,
                                    phone: i.phone,
                                    photo:i.photo,
                                    gender: i.gender,
                                    dob: i.dob,
                                    bio: i.bio,
                                    level: i.level,
                                  ),
                                ),
                              );
                            }, child: Text("Edit"))
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
  final String id;
  // final String login;
  final String name;
  final String email;
  final String photo;
  final String phone;
  final String gender;
  final String dob;
  final String level;
  final String bio;

  Joke({
    required this.id,
    // required this.login,
    required this.name,
    required this.email,
    required this.photo,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.level,
    required this.bio
  });
}

