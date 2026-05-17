// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class view_payment extends StatelessWidget {
//   const view_payment({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class view_payment_sub extends StatefulWidget {
//   const view_payment_sub({Key? key}) : super(key: key);

//   @override
//   State<view_payment_sub> createState() => _view_payment_subState();
// }

// class _view_payment_subState extends State<view_payment_sub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("uid").toString();
//     // String foodimage = "";
//     var data = await http.post(
//         Uri.parse(prefs.getString("ip").toString()+"/view_payments"),
//         body: {"uid":b}
//     );

//     var jsonData = json.decode(data.body);
// //    print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["data"]) {
//       print(joke);
//       Joke newJoke = Joke(
//           date:joke["date"].toString(),
//           amount:joke["amount"].toString()
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("view payment"),
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
//                             _buildRow("Date:", i.date.toString()),
//                             _buildRow("Amount:", i.amount.toString())
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
//   final String date;
//   final String amount;

//   Joke({
//     required this.date,
//     required this.amount,
//   });
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class view_payment extends StatelessWidget {
  const view_payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: view_payment_sub(),);
  }
}

class view_payment_sub extends StatefulWidget {
  const view_payment_sub({Key? key}) : super(key: key);

  @override
  State<view_payment_sub> createState() => _view_payment_subState();
}

class _view_payment_subState extends State<view_payment_sub> {

  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("uid").toString();

    var data = await http.post(
        Uri.parse(prefs.getString("ip").toString()+"/view_payments"),
        body: {"uid":b}
    );

    var jsonData = json.decode(data.body);

    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      Joke newJoke = Joke(
          date:joke["date"].toString(),
          amount:joke["amount"].toString()
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
          "Payments",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFB6FF3B)), // neon back button
      ),

      body: FutureBuilder(
        future: _getJokes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFB6FF3B),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data.length == 0) {
            return Center(
              child: Text(
                "No Payments Found",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var i = snapshot.data![index];

              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF12181F),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xFFB6FF3B).withOpacity(0.3),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Neon Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment",
                            style: TextStyle(
                              color: Color(0xFFB6FF3B),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Icon(Icons.payments, color: Color(0xFFB6FF3B))
                        ],
                      ),

                      SizedBox(height: 12),

                      _buildRow("Date", i.date.toString()),
                      _buildRow("Amount", "₹ ${i.amount.toString()}"),
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Joke {
  final String date;
  final String amount;

  Joke({
    required this.date,
    required this.amount,
  });
}