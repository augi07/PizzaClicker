import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'StatsContent.dart';
import 'InfoContent.dart';
import 'SettingsContent.dart';
import 'app_settings.dart';
import 'sound_manager.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _totalPizzas = 0;
  int _pizzasPerClick = 1;
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
      _totalPizzas = prefs.getInt('totalPizzas') ?? 0;
      _pizzasPerClick = prefs.getInt('pizzasPerClick') ?? 1;
    });
  }

  Future<void> _saveGame() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalPizzas', _totalPizzas);
    await prefs.setInt('pizzasPerClick', _pizzasPerClick);
  }
 
  Future<void> incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      _totalPizzas += _pizzasPerClick;
      prefs.setInt('counter', _counter);
    });
    await _saveGame();
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
                onDestinationSelected: (int index) async {
                  if (index == 0) {
                    await _loadCounter();
                  }
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
                    Text(
                      'TOTAL PIZZAS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    Text(
                      '$_totalPizzas',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Hier ist der FloatingActionButton im Center
            if (currentPageIndex == 0)
              Align(
                alignment: Alignment.center,
                child: Consumer<AppSettings>(
                  builder: (context, settings, _) {
                    return GestureDetector(
                      onTapDown: (_) async {
                        if (settings.animationsEnabled) {
                          setState(() {
                            _imageSize = 295;
                          });
                        }
                        await SoundManager.playClickSound();
                      },
                      onTapUp: (_) async {
                        setState(() {
                          _imageSize = 300;
                        });
                        await incrementCounter();
                      },
                      onTapCancel: () {
                        if (settings.animationsEnabled) {
                          setState(() {
                            _imageSize = 300;
                          });
                        }
                      },
                      child: settings.animationsEnabled
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              curve: Curves.easeInOut,
                              height: _imageSize,
                              width: _imageSize,
                              child: Image.asset('assets/Pizza.png'),
                            )
                          : Container(
                              height: _imageSize,
                              width: _imageSize,
                              child: Image.asset('assets/Pizza.png'),
                            ),
                    );
                  },
                ),
              ),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '$_pizzasPerClick pizzas per click',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white60 : Colors.black54,
                      ),
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
