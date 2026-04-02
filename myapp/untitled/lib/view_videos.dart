// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class view_videos extends StatelessWidget {
//   const view_videos({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: view_videos_sub(),);
//   }
// }
//
// class view_videos_sub extends StatefulWidget {
//   const view_videos_sub({Key? key}) : super(key: key);
//
//   @override
//   State<view_videos_sub> createState() => _view_videos_subState();
// }
//
// class _view_videos_subState extends State<view_videos_sub> {
//   Future<List<Joke>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String b = prefs.getString("uid").toString();
//     // String foodimage = "";
//     var data = await http.post(
//         Uri.parse(prefs.getString("ip").toString()+"/view_workout_video"),
//         body: {"uid":b}
//     );
//
//     var jsonData = json.decode(data.body);
//    // print(jsonData);
//     List<Joke> jokes = [];
//     for (var joke in jsonData["message"]) {
//       print(joke);
//       Joke newJoke = Joke(
//           // id: joke["id"].toString(),
//           // allocateBatchUserId: joke["allocateBatchUserId"].toString(),
//           video:prefs.getString("ip").toString()+joke["video"].toString(),
//           title: joke["title"].toString(),
//           date: joke["date"].toString()
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
//         title: Text("view videos"),
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
//                             Image.network(i.video,width: 300,height: 300,),
//                             _buildRow("Title:", i.title.toString()),
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
//
// class Joke {
//   // final String id;
//   // final String allocateBatchUserId;
//   final String video;
//   final String title;
//   final String date;
//
//   Joke({
//     // required this.id,
//     // required this.allocateBatchUserId,
//     required this.video,
//     required this.title,
//     required this.date
//   });
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure this is in pubspec.yaml

class ViewVideos extends StatelessWidget {
  const ViewVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ViewVideosSub());
  }
}

class ViewVideosSub extends StatefulWidget {
  const ViewVideosSub({Key? key}) : super(key: key);

  @override
  State<ViewVideosSub> createState() => _ViewVideosSubState();
}

class _ViewVideosSubState extends State<ViewVideosSub> {
  Future<List<VideoItem>> _getVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid") ?? "";
    String baseIp = prefs.getString("ip") ?? "";

    final response = await http.post(
      Uri.parse("$baseIp/view_workout_video"),
      body: {"uid": uid},
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<VideoItem> videos = [];
      for (var item in jsonData["message"]) {
        String videoUrl = _buildFullUrl(baseIp, item["video"].toString());
        videos.add(VideoItem(
          video: videoUrl,
          title: item["title"].toString(),
          date: item["date"].toString(),
        ));
      }
      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }

  // Helper to construct a proper URL (handles missing slashes)
  String _buildFullUrl(String baseIp, String path) {
    final uri = Uri.parse(baseIp);
    return uri.resolve(path).toString();
  }

  // Universal launcher that works with both new and old url_launcher versions
  Future<void> _launchVideo(String url) async {
    print("Launching video URL: $url"); // Debugging

    final Uri uri = Uri.parse(url);

    // Try modern method (url_launcher >=6.0.0)
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (e) {
      print("Modern launch failed: $e");
    }

    // Fallback to older method (for url_launcher <6.0.0)
    try {
      if (await canLaunch(url)) {
        await launch(url);
        return;
      }
    } catch (e) {
      print("Fallback launch failed: $e");
    }

    // If both fail, show error
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open video: $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Workout Videos")),
      body: FutureBuilder<List<VideoItem>>(
        future: _getVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No videos found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final video = snapshot.data![index];
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
                        GestureDetector(
                          onTap: () => _launchVideo(video.video),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[200],
                            child: Image.network(
                              video.video,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.play_circle_fill,
                                          size: 80, color: Colors.blue),
                                      Text("Tap to play video",
                                          style: TextStyle(color: Colors.blue)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildInfoRow("Title:", video.title),
                        _buildInfoRow("Date:", video.date),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class VideoItem {
  final String video;
  final String title;
  final String date;

  VideoItem({required this.video, required this.title, required this.date});
}