import 'package:flutter/material.dart';


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

  

  void incrementCounter() {
      setState(() {
        _counter++;
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
          child: NavigationBar(
            indicatorColor: Colors.transparent,
            height: 60,
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.bar_chart),
                label: 'stats',
              ),
              NavigationDestination(
                icon: Icon(Icons.info),
                label: 'Info',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settins',
              ),
            ],
          ),
        ),
      ),
      body: <Widget>[
        // Home page
        Stack(
          children: [
            /// Hier wird es oben zentriert!
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
                      _counter++;
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
                    child: Image.asset('Images/Pizza.png'),
                  ),
                ),
              ),
          ],
        ),

        /// Stats Page (NEU HINZUGEFÜGT!)
        const Center(
          child: Text(
            'Stats Page',
            style: TextStyle(fontSize: 24),
          ),
        ),

                // Info Page
        const Center(
          child: Text(
            'Info Page',
            style: TextStyle(fontSize: 24),
          ),
        ),

        
        // Settings Page
        const Center(
          child: Text(
            'Settings Page',
            style: TextStyle(fontSize: 24),
          ),
        ),

      ][currentPageIndex],

      // FloatingActionButtonLocation entfernt, da er jetzt im Stack ist
    );
  }
}
