import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsContent extends StatelessWidget {

  final VoidCallback onReset;

  SettingsContent({required this.onReset});


  void resetProgress() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('counter', 0);
  await prefs.setInt('totalPizzas', 0);
  await prefs.setInt('pizzasPerClick', 1);
  await prefs.setInt('upgradesPurchased', 0);
  onReset();
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20),
              width: 320, height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 8.0,),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Appearance\n',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black, ),
                  ),
                  Text(
                    'Dark Mode\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black, ),
                  ),
                  Text(
                    'Animations\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black, ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20),
              width: 320, height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 8.0,),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sound\n',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black, ),
                  ),
                  Text(
                    'Sound Effects\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black, ),
                  ),
                  Text(
                    'Volume',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black, ),
                  ),
                  Text(
                    '50%',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black, ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20),
              width: 320, height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 10.0, top: 8.0,),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Game\n',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black, ),
                  ),
                  SizedBox(
                    width: 270,
                    height: 40,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(209, 202, 110, 110)),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Set your desired radius here
                          ),
                        ),
                      ),
                      onPressed: () {
                        resetProgress();
                      },
                      child: Text('Reset Progress'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Auto Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
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
