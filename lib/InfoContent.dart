import 'package:flutter/material.dart';

class InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Text(
        textAlign: TextAlign.center,
        'Info page',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black ),
        
      ),
    );
  }
}
