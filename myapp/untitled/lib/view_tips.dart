// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class view_tips extends StatelessWidget {
//   const view_tips({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: view_tips_sub(),);
//   }
// }

// class view_tips_sub extends StatefulWidget {
//   const view_tips_sub({Key? key}) : super(key: key);

//   @override
//   State<view_tips_sub> createState() => _view_tips_subState();
// }

// class _view_tips_subState extends State<view_tips_sub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("uid").toString();
//     // String foodimage = "";
//     var data = await http.post(
//         Uri.parse(prefs.getString("ip").toString()+"/view_tips"),
//         body: {"uid":b}
//     );

//     var jsonData = json.decode(data.body);
//    print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       print(joke);
//       Joke newJoke = Joke(
//           id: joke["id"].toString(),
//           // allocateBatchUserId: joke["allocateBatchUserId"].toString(),
//           title: joke["title"].toString(),
//           tips: joke["tips"].toString(),
//           date: joke["date"].toString()
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("view tips"),
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
//                             _buildRow("Tips:", i.tips.toString()),
//                             _buildRow("Date:", i.date.toString()),
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
//   final String id;
//   // final String allocateBatchUserId;
//   final String title;
//   final String tips;
//   final String date;

//   Joke({
//     required this.id,
//     // required this.allocateBatchUserId,
//     required this.title,
//     required this.tips,
//     required this.date
//   });
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class view_tips extends StatelessWidget {
  const view_tips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: view_tips_sub(),
    );
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

    var data = await http.post(
        Uri.parse(prefs.getString("ip").toString()+"/view_tips"),
        body: {"uid": b}
    );

    var jsonData = json.decode(data.body);
    List<Joke> jokes = [];

    for (var joke in jsonData["message"]) {
      Joke newJoke = Joke(
          id: joke["id"].toString(),
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
      backgroundColor: Color(0xFF0B0F14),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B0F14),
        elevation: 0,
        title: Text(
          "Fitness Tips",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFFB6FF3B)),
      ),

      body: FutureBuilder(
        future: _getJokes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (!snapshot.hasData) {
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
              var i = snapshot.data[index];

              return Container(
                margin: EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Color(0xFF12181F),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(0xFFB6FF3B).withOpacity(0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFB6FF3B).withOpacity(0.15),
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// TITLE
                      Text(
                        i.title.toString(),
                        style: TextStyle(
                          color: Color(0xFFB6FF3B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      /// TIPS
                      Text(
                        i.tips.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: 14),

                      /// DATE
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 6),
                          Text(
                            i.date.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
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
}

class Joke {
  final String id;
  final String title;
  final String tips;
  final String date;

  Joke({
    required this.id,
    required this.title,
    required this.tips,
    required this.date
  });
}