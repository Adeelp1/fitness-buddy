// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'RazorpayScreen.dart';

// class PaymentPage extends StatefulWidget {
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   String selectedPlan = "Monthly";
//   String fee = "499";

//   Widget buildPlanCard(String title, String price, String duration) {
//     bool isSelected = selectedPlan == title;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedPlan = title;
//           fee = price.replaceAll("₹", "");
//         });
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         margin: EdgeInsets.symmetric(vertical: 10),
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.red.shade700 : Colors.black,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(
//             color: isSelected ? Colors.red : Colors.grey,
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black54,
//               blurRadius: 10,
//               offset: Offset(0, 5),
//             )
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   duration,
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//             Text(
//               price,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text("Select Plan"),
//         backgroundColor: Colors.red,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             buildPlanCard("Monthly", "₹499", "Billed every month"),
//             buildPlanCard("Quarterly", "₹1299", "Every 3 months"),
//             buildPlanCard("Yearly", "₹4599", "Best value"),

//             SizedBox(height: 30),

//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               onPressed: () async {
//                 print("Selected Plan: $selectedPlan");
//                 print("Selected Plan price: $fee");
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 sh.setString("gym_fee", fee);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => RazorpayScreen()),
//                 );
//               },
//               child: Text(
//                 "Continue",
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RazorpayScreen.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPlan = "Monthly";
  String fee = "499";

  // Theme Colors
  final Color bgColor = const Color(0xFF0B0F14);
  final Color cardColor = const Color(0xFF12181F);
  final Color neonGreen = const Color(0xFFB6FF3B);
  final Color textSecondary = const Color(0xFF9CA3AF);

  Widget buildPlanCard(String title, String price, String duration) {
    bool isSelected = selectedPlan == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = title;
          fee = price.replaceAll("₹", "");
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? neonGreen : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: neonGreen.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            const BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // LEFT TEXT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? neonGreen : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  duration,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            // RIGHT PRICE
            Text(
              price,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Select Plan"),
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: neonGreen),
        titleTextStyle: TextStyle(
          color: neonGreen,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            buildPlanCard("Monthly", "₹499", "Billed every month"),
            buildPlanCard("Quarterly", "₹1299", "Every 3 months"),
            buildPlanCard("Yearly", "₹4599", "Best value"),

            const SizedBox(height: 40),

            // CONTINUE BUTTON
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: neonGreen.withOpacity(0.6),
                    blurRadius: 20,
                  )
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonGreen,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  print("Selected Plan: $selectedPlan");
                  print("Selected Plan price: $fee");
                  SharedPreferences sh =
                      await SharedPreferences.getInstance();
                  sh.setString("gym_fee", fee);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RazorpayScreen()),
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}