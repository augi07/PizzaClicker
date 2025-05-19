import 'package:flutter/material.dart';

class StatsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            width: 400, height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: Text(
              'Stats page',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black ),
              
            ),
          ),
        ],
      ),
    );
  }
}