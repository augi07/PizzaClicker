import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_settings.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = AppSettings();
  await settings.loadSettings();

  runApp(MyApp(settings));
}

class MyApp extends StatelessWidget {
  final AppSettings settings;

  const MyApp(this.settings, {super.key});

  @override
  Widget build(BuildContext context) {

    final customDarkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color.fromARGB(255, 48, 48, 48), // your custom dark background
    );


    return ChangeNotifierProvider.value(
      value: settings,
      child: Consumer<AppSettings>(
        builder: (context, settings, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: customDarkTheme,
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            builder: (context, child) {
              return settings.animationsEnabled
                  ? child!
                  : MediaQuery(
                      data: MediaQuery.of(context).copyWith(disableAnimations: true),
                      child: child!,
                    );
            },
            home: const MyHomePage(title: 'Pizza Clicker'),
          );
        },
      ),
    );
  }
}