// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class view_events extends StatelessWidget {
//   const view_events({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: view_events_sub(),);
//   }
// }

// class view_events_sub extends StatefulWidget {
//   const view_events_sub({Key? key}) : super(key: key);

//   @override
//   State<view_events_sub> createState() => _view_events_subState();
// }

// class _view_events_subState extends State<view_events_sub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("lid").toString();
//     // String foodimage = "";
//     var data = await http.post(
//         Uri.parse(prefs.getString("ip").toString()+"/view_events"),
//         body: {"uid":b}
//     );

//     var jsonData = json.decode(data.body);
// //    print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       print(joke);
//       Joke newJoke = Joke(
//           title:     joke["title"].toString(),
//           description:    joke["description"].toString(),
//           venue:    joke["venue"].toString(),
//           date:    joke["date"].toString(),
//           time:    joke["time"].toString()
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("view events"),
//       ),
//       body:
//       Container(
//         child:
//         FutureBuilder(
//           future: _getJokes(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
// //              print("snapshot"+snapshot.toString());
//             if (snapshot.data == null) {
//               return Container(
//                 child: Center(
//                   child: Text("Loading..."),
//                 ),
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var i = snapshot.data![index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         side: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 10),
//                             _buildRow("Title:", i.title.toString()),
//                             _buildRow("Description:", i.description.toString()),
//                             _buildRow("Venue:", i.venue.toString()),
//                             _buildRow("Date:", i.date.toString()),
//                             _buildRow("Time:", i.time.toString()),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(width: 5),
//           Flexible(
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: Colors.grey.shade800,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Joke {
//   final String title;
//   final String description;
//   final String venue;
//   final String date;
//   final String time;

//   Joke({
//     required this.title,
//     required this.description,
//     required this.venue,
//     required this.date,
//     required this.time,
//   });
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class view_events extends StatelessWidget {
  const view_events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: view_events_sub(),
    );
  }
}

class view_events_sub extends StatefulWidget {
  const view_events_sub({Key? key}) : super(key: key);

  @override
  State<view_events_sub> createState() => _view_events_subState();
}

class _view_events_subState extends State<view_events_sub> {

  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("lid").toString();

    var data = await http.post(
        Uri.parse(prefs.getString("ip").toString()+"/view_events"),
        body: {"uid":b}
    );

    var jsonData = json.decode(data.body);

    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      Joke newJoke = Joke(
          title: joke["title"].toString(),
          description: joke["description"].toString(),
          venue: joke["venue"].toString(),
          date: joke["date"].toString(),
          time: joke["time"].toString()
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0F14),

      appBar: AppBar(
        backgroundColor: Color(0xFF0B0F14),
        elevation: 0,
        title: Text(
          "Events",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // iconTheme: IconThemeData(color: Color(0xFFB6FF3B)),
      ),

      body: FutureBuilder(
        future: _getJokes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFB6FF3B),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {

              var i = snapshot.data![index];

              return Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF12181F),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFB6FF3B).withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Title
                      Text(
                        i.title.toString(),
                        style: TextStyle(
                          color: Color(0xFFB6FF3B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      _buildRow("Description", i.description),
                      _buildRow("Venue", i.venue),
                      _buildRow("Date", i.date),
                      _buildRow("Time", i.time),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "$label: ",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF9CA3AF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Joke {
  final String title;
  final String description;
  final String venue;
  final String date;
  final String time;

  Joke({
    required this.title,
    required this.description,
    required this.venue,
    required this.date,
    required this.time,
  });
}