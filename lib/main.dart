import 'package:flutter/material.dart';
import 'package:openai/models/theme_manager.dart';
import 'package:openai/screens/completion.dart';
import 'package:openai/screens/read_me_page.dart';
import 'package:openai/screens/settings_page.dart';
import 'package:openai/screens/startup_settings_page.dart';
import 'package:provider/provider.dart';
import 'package:openai/screens/splash_screen.dart';

const OPENAI_KEY = '';

void main() => runApp(
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider()..initialize(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          initialRoute: 'startup',
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: provider.themeMode,
          routes: {
            'startup': (context) => Splash(), // Startup screen
            "/": (context) => MyHomePage(), // AI chat page
            "/second": (context) => Settings(), // Settings page
            "/third": (context) => ReadMe(), // Read me page
            // "/startup_settings": (context) => StartUp(),
          },
        );
      },
    );
  }
}
