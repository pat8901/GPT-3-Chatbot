// Class was not used
// The idea was to have a settings page on startup
// This page would only show on the first time to start the app

import 'package:flutter/material.dart';

class StartUp extends StatefulWidget {
  const StartUp({Key? key}) : super(key: key);

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Settings"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                TextButton(
                  child: Text("Confirm"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                ),
                TextButton(
                  child: Text("Skip"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
