// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart'; // for kIsWeb
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// class FoodScannerPage extends StatefulWidget {
//   @override
//   _FoodScannerPageState createState() => _FoodScannerPageState();
// }

// class _FoodScannerPageState extends State<FoodScannerPage> {
//   Uint8List? _imageBytes;
//   String result = "No result yet";
//   bool isLoading = false;

//   final picker = ImagePicker();

//   // 🔑 Replace with your API key
//   final String apiKey = "AIzaSyCI75-qbJQkuoGnNJiID9HBLLYFkJTX_yw";

//   Future pickImage() async {
//     final pickedFile =
//     await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();

//       setState(() {
//         _imageBytes = bytes;
//       });
//     }
//   }

//   Future analyzeImage() async {
//     if (_imageBytes == null) return;

//     setState(() {
//       isLoading = true;
//     });

//     String base64Image = base64Encode(_imageBytes!);

//     final url =
//         "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent?key=$apiKey";

//     final response = await http.post(
//       Uri.parse(url),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "contents": [
//           {
//             "parts": [
//               {
//                 "text":
//                 "Identify the food in this image and provide a nutrient list including calories, protein, carbs, and fat in clean format."
//               },
//               {
//                 "inline_data": {
//                   "mime_type": "image/jpeg",
//                   "data": base64Image
//                 }
//               }
//             ]
//           }
//         ]
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final text =
//       data['candidates'][0]['content']['parts'][0]['text'];

//       setState(() {
//         result = text;
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         result = "Error: ${response.body}";
//         isLoading = false;
//       });
//     }
//   }

//   Widget buildImagePreview() {
//     if (_imageBytes == null) {
//       return Container(
//         height: 200,
//         color: Colors.grey[300],
//         child: Center(child: Text("No Image Selected")),
//       );
//     }

//     return Image.memory(_imageBytes!, height: 200);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Food Scanner"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             buildImagePreview(),
//             SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: pickImage,
//               child: Text("Pick Image"),
//             ),

//             ElevatedButton(
//               onPressed: analyzeImage,
//               child: Text("Analyze Food"),
//             ),

//             SizedBox(height: 20),

//             isLoading
//                 ? CircularProgressIndicator()
//                 : Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   result,
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),

//       ),
//     );
//   }
// }


import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class FoodScannerPage extends StatefulWidget {
  @override
  _FoodScannerPageState createState() => _FoodScannerPageState();
}

class _FoodScannerPageState extends State<FoodScannerPage> {
  Uint8List? _imageBytes;
  String result = "No result yet";
  bool isLoading = false;

  final picker = ImagePicker();

  final String apiKey = "AIzaSyDYaif0NcWqgYdNYOThBXKWjKMMnE50aHA";

  Future pickImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Future analyzeImage() async {
    if (_imageBytes == null) return;

    setState(() {
      isLoading = true;
    });

    String base64Image = base64Encode(_imageBytes!);

    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent?key=$apiKey";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text":
                    "Identify the food in this image and provide a nutrient list including calories, protein, carbs, and fat in clean format."
              },
              {
                "inline_data": {
                  "mime_type": "image/jpeg",
                  "data": base64Image
                }
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text =
          data['candidates'][0]['content']['parts'][0]['text'];

      setState(() {
        result = text;
        isLoading = false;
      });
    } else {
      setState(() {
        result = "Error: ${response.body}";
        isLoading = false;
      });
    }
  }

  Widget buildImagePreview() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Color(0xFF12181F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFB6FF3B), width: 1.5),
      ),
      child: _imageBytes == null
          ? Center(
              child: Text(
                "No Image Selected",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(_imageBytes!, fit: BoxFit.cover),
            ),
    );
  }

  Widget neonButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFB6FF3B).withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 1,
          )
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFB6FF3B),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget resultCard() {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF12181F),
          borderRadius: BorderRadius.circular(20),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFB6FF3B),
                ),
              )
            : SingleChildScrollView(
                child: Text(
                  result,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0F14),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B0F14),
        elevation: 0,
        title: Text(
          "Food Scanner",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFFB6FF3B)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildImagePreview(),
            SizedBox(height: 20),

            neonButton("Pick Image", pickImage),
            neonButton("Analyze Food", analyzeImage),

            SizedBox(height: 10),

            resultCard(),
          ],
        ),
      ),
    );
  }
}