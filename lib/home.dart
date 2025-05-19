import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StatsContent.dart';
import 'InfoContent.dart';
import 'SettingsContent.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int currentPageIndex = 0;
  double _imageSize = 300;

  final List<Widget> widgetOptions = [
    StatsContent(),
    InfoContent(),
    SettingsContent(onReset: () {  },),
  ];

  @override
  void initState() {
    super.initState();
    _loadCounter();
  } 
 
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }
 
  Future<void> incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: WidgetStateProperty.all(
                  TextStyle(color: Colors.white),
                ),
              ),
              child: NavigationBar(
                indicatorColor: Colors.transparent,
                backgroundColor: Color.fromARGB(255, 48, 48, 48),
                height: 60,
                selectedIndex: currentPageIndex,
                onDestinationSelected: (int index) {
                  setState(() { 
                    currentPageIndex = index;
                  });
                },
                destinations: const <NavigationDestination>[
                  NavigationDestination(
                    icon: Icon(Icons.home, color: Colors.white,),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.bar_chart, color: Colors.white,),
                    label: 'stats',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.info, color: Colors.white,),
                    label: 'Info',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings, color: Colors.white,),
                    label: 'Settins',
                  ),
                ],
              ),
            ),
        ),
      ),
      body: <Widget>[
        // Home page
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'TOTAL PIZZAS',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white70 ),
                    ),
                    Text(
                      '$_counter',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, ),
                    ),
                  ],
                ),
              ),
            ),

            // Hier ist der FloatingActionButton im Center
            if (currentPageIndex == 0)
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      _imageSize = 295;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      _imageSize = 300;
                      incrementCounter();
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      _imageSize = 300;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: _imageSize,
                    width: _imageSize,
                    child: Image.asset('assets/Pizza.png'),
                  ),
                ),
              ),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      '1 pizzas per click',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white60 ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Stats Page
        StatsContent(
        ),

        // Info Page
        InfoContent(
        ),

        // Settings Page
        SettingsContent(
          onReset: _loadCounter,
        ),

      ][currentPageIndex],

      // FloatingActionButtonLocation entfernt, da er jetzt im Stack ist
    );
  }
}
