import 'package:flutter/material.dart';

class InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDark ? Colors.grey[850] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20),
              width: 320,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: containerColor,
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'About Pizza Clicker\n',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Pizza Clicker is an idle game where you click on a pizza to earn more pizzas. Use your pizzas to buy upgrades and increase your pizza production!\nVersion: 1.0.0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20),
              width: 320,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: containerColor,
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'About Upgrades\n',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Text(
                    '• Double Click: Doubles the number of pizzas you get per click \n• Auto Clicker: Automatically gives you 1 pizza per second \n• Golden Pizza: Triples the number of pizzas you get per click',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20),
              width: 320,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: containerColor,
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'How to Play\n',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Text(
                    '• Tap the pizza to earn pizzas \n• Build combos by tapping quickly \n• Buy upgrades to earn more pizzas \n• Unlock achievements as you play \n• Try to get as many pizzas as possible!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 20),
              width: 320,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: containerColor,
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tips & Tricks\n',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Text(
                    '• Build combos for faster pizza earning \n• Invest in Auto Clicker early for passive income \n• Save up for Golden Pizza for maximum clicking power \n• Keep clicking even after buying upgrades',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}