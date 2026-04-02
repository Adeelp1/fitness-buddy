import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class view_tips extends StatelessWidget {
  const view_tips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: view_tips_sub(),);
  }
}

class view_tips_sub extends StatefulWidget {
  const view_tips_sub({Key? key}) : super(key: key);

  @override
  State<view_tips_sub> createState() => _view_tips_subState();
}

class _view_tips_subState extends State<view_tips_sub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("uid").toString();
    // String foodimage = "";
    var data = await http.post(
        Uri.parse(prefs.getString("ip").toString()+"/view_tips"),
        body: {"uid":b}
    );

    var jsonData = json.decode(data.body);
   print(jsonData);
    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      Joke newJoke = Joke(
          id: joke["id"].toString(),
          // allocateBatchUserId: joke["allocateBatchUserId"].toString(),
          title: joke["title"].toString(),
          tips: joke["tips"].toString(),
          date: joke["date"].toString()
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view tips"),
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
                            _buildRow("Title:", i.title.toString()),
                            _buildRow("Tips:", i.tips.toString()),
                            _buildRow("Date:", i.date.toString()),
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
  // final String allocateBatchUserId;
  final String title;
  final String tips;
  final String date;

  Joke({
    required this.id,
    // required this.allocateBatchUserId,
    required this.title,
    required this.tips,
    required this.date
  });
}


