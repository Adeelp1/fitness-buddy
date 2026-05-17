// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled/update_health_details.dart';
//
// class view_health_details extends StatelessWidget {
//   const view_health_details({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// class view_health_details_sub extends StatefulWidget {
//   const view_health_details_sub({Key? key}) : super(key: key);
//
//   @override
//   State<view_health_details_sub> createState() => _view_health_details_subState();
// }
//
// class _view_health_details_subState extends State<view_health_details_sub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("uid").toString();
//     // String foodimage = "";
//     var data = await http.post(
//         Uri.parse(prefs.getString("ip").toString()+"/view_health_details"),
//         body: {"uid":b}
//     );
//
//     var jsonData = json.decode(data.body);
// //    print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       print(joke);
//       Joke newJoke = Joke(
//           id:   joke["id"].toString(),
//           title:     joke["title"].toString(),
//           details:    joke["details"].toString(),
//           date:    joke["date"].toString()
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("view health details "),
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
//                             _buildRow("Id", i.id.toString()),
//                             _buildRow("Title:", i.title.toString()),
//                             _buildRow("Details:", i.details.toString()),
//                             _buildRow("Date:", i.date.toString()),
//
//                             Row(children: [
//                               ElevatedButton(onPressed: () async {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>(
//
//
//                                 )));
//                               }, child: Text("Update")),
//                             ],)
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
//
// class Joke {
//   final String id;
//   final String title;
//   final String details;
//   final String date;
//
//   Joke({
//     required this.id,
//     required this.title,
//     required this.details,
//     required this.date,
//   });
// }

/////////////////////////////////////////////////////////////////////////////////////

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled/update_health_details.dart';

// class view_health_details extends StatelessWidget {
//   const view_health_details({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class view_health_details_sub extends StatefulWidget {
//   const view_health_details_sub({Key? key}) : super(key: key);

//   @override
//   State<view_health_details_sub> createState() =>
//       _view_health_details_subState();
// }

// class _view_health_details_subState
//     extends State<view_health_details_sub> {

//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("uid").toString();

//     var data = await http.post(
//       Uri.parse(prefs.getString("ip").toString() + "/view_health_details"),
//       body: {"uid": b},
//     );

//     var jsonData = json.decode(data.body);

//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       Joke newJoke = Joke(
//         id: joke["id"].toString(),
//         title: joke["title"].toString(),
//         details: joke["details"].toString(),
//         date: joke["date"].toString(),
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("view health details "),
//       ),
//       body: Container(
//         child: FutureBuilder(
//           future: _getJokes(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {

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
//                             _buildRow("Id", i.id.toString()),
//                             _buildRow("Title:", i.title.toString()),
//                             _buildRow("Details:", i.details.toString()),
//                             _buildRow("Date:", i.date.toString()),

//                             Row(
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () async {

//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             update_health_details_sub(
//                                               id: i.id,
//                                               title: i.title,
//                                               details: i.details,
//                                             ),
//                                       ),
//                                     );

//                                   },
//                                   child: Text("Update"),

//                                 ),
//                                 ElevatedButton(onPressed: ()async{
//                                   SharedPreferences sh = await SharedPreferences.getInstance();
//                                   sh.setString("id",i.id);
//                                   var data = await http.post(Uri.parse("${sh.getString('ip')}/delete_health_details"),
//                                       body: {

//                                         'id':sh.getString('id').toString()
//                                       });

//                                 }, child: Text("delete"))
//                               ],
//                             ),
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
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(width: 5),
//           Flexible(
//             child: Text(
//               value,
//               style: TextStyle(color: Colors.grey.shade800),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Joke {
//   final String id;
//   final String title;
//   final String details;
//   final String date;

//   Joke({
//     required this.id,
//     required this.title,
//     required this.details,
//     required this.date,
//   });
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/update_health_details.dart';

class view_health_details extends StatelessWidget {
  const view_health_details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const view_health_details_sub();
  }
}

class view_health_details_sub extends StatefulWidget {
  const view_health_details_sub({Key? key}) : super(key: key);

  @override
  State<view_health_details_sub> createState() =>
      _view_health_details_subState();
}

class _view_health_details_subState
    extends State<view_health_details_sub> {

  // 🎨 THEME COLORS
  final Color bgColor = const Color(0xFF0B0F14);
  final Color cardColor = const Color(0xFF12181F);
  final Color accent = const Color(0xFFB6FF3B);
  final Color textSecondary = const Color(0xFF9CA3AF);

  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("uid").toString();

    var data = await http.post(
      Uri.parse(prefs.getString("ip").toString() + "/view_health_details"),
      body: {"uid": b},
    );

    var jsonData = json.decode(data.body);

    List<Joke> jokes = [];
    for (var joke in jsonData["message"]) {
      Joke newJoke = Joke(
        id: joke["id"].toString(),
        title: joke["title"].toString(),
        details: joke["details"].toString(),
        date: joke["date"].toString(),
      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Health Details"),
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getJokes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(color: accent),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {

                var i = snapshot.data![index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accent.withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // 🔥 TITLE
                        Text(
                          i.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: accent,
                          ),
                        ),

                        const SizedBox(height: 12),

                        _buildRow("ID", i.id),
                        _buildRow("Details", i.details),
                        _buildRow("Date", i.date),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            // ✏️ UPDATE
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: BorderSide(color: accent),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        update_health_details_sub(
                                          id: i.id,
                                          title: i.title,
                                          details: i.details,
                                        ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit, color: accent),
                              label: Text(
                                "Update",
                                style: TextStyle(color: accent),
                              ),
                            ),

                            // 🗑 DELETE
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                SharedPreferences sh =
                                    await SharedPreferences.getInstance();
                                sh.setString("id", i.id);

                                await http.post(
                                  Uri.parse(
                                      "${sh.getString('ip')}/delete_health_details"),
                                  body: {
                                    'id': sh.getString('id').toString()
                                  },
                                );

                                setState(() {});
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text("Delete"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "$label: ",
            style: TextStyle(
              color: textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class Joke {
  final String id;
  final String title;
  final String details;
  final String date;

  Joke({
    required this.id,
    required this.title,
    required this.details,
    required this.date,
  });
}