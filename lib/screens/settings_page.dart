// Many settings where not implemented due to time
// Many of these settings will need the provider package in order to change the states all across the app

import 'package:flutter/material.dart';
import 'package:openai/models/theme_manager.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int? _appColorValue = 0;
  int? _nameValue = 0;
  int? _pictureValue = 0;
  int? _textSizeValue = 0;
  int? _aiValue = 0;

  // void dropdownAppBarColor(int? selectedValue) {
  //   if (selectedValue is int) {
  //     setState(() {
  //       _appColorValue = selectedValue;
  //     });
  //   }
  // }

  // void dropdownName(int? selectedValue) {
  //   if (selectedValue is int) {
  //     setState(() {
  //       _nameValue = selectedValue;
  //     });
  //   }
  // }

  // void dropdownPicture(int? selectedValue) {
  //   if (selectedValue is int) {
  //     setState(() {
  //       _pictureValue = selectedValue;
  //     });
  //   }
  // }

  void dropdownTextSize(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        _textSizeValue = selectedValue;
      });
    }
  }

  // Changes the Ai's demeanor
  void dropdownAiType(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        _aiValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/spacemoon_backround.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // backgroundColor: Colors.green.shade500,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Card(
              child: ListTile(
                title: Text('Theme'),
                trailing: Consumer<ThemeProvider>(
                    builder: (context, provider, child) {
                  return DropdownButton<String>(
                    value: provider.currentTheme,
                    //dropdownColor: Colors.white,
                    items: const [
                      DropdownMenuItem<String>(
                          value: 'light',
                          child: Text(
                            'Light mode',
                            //style: Theme.of(context).textTheme.headline6,
                          )),
                      DropdownMenuItem<String>(
                          value: 'dark',
                          child: Text(
                            'Dark mode',
                            //style: Theme.of(context).textTheme.headline6,
                          )),
                    ],
                    onChanged: (String? value) {
                      provider.changeTheme(value ?? "dark");
                    },
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Card(
            //   child: ListTile(
            //     onTap: () {},
            //     title: Text('App Bar Color'),
            //     trailing: DropdownButton(
            //       //dropdownColor: Colors.white,
            //       value: _appColorValue,
            //       items: const [
            //         DropdownMenuItem(value: 0, child: Text('Blue')),
            //         DropdownMenuItem(value: 1, child: Text('Red')),
            //         DropdownMenuItem(value: 2, child: Text('Green')),
            //         DropdownMenuItem(value: 3, child: Text('Purple')),
            //         DropdownMenuItem(value: 4, child: Text('Pink')),
            //       ],
            //       onChanged: dropdownAppBarColor,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Card(
            //   child: ListTile(
            //     title: Text('Name'),
            //     trailing: DropdownButton(
            //       //dropdownColor: Colors.white,
            //       value: _nameValue,
            //       items: const [
            //         DropdownMenuItem(value: 0, child: Text('Joe')),
            //         DropdownMenuItem(value: 1, child: Text('Kate')),
            //         DropdownMenuItem(value: 2, child: Text('Jim')),
            //       ],
            //       onChanged: dropdownName,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Card(
            //   child: ListTile(
            //     title: Text('Profile Picture'),
            //     trailing: DropdownButton(
            //       //dropdownColor: Colors.white,
            //       value: _pictureValue,
            //       items: const [
            //         DropdownMenuItem(value: 0, child: Text("Abra")),
            //         DropdownMenuItem(value: 1, child: Text('Kate')),
            //         DropdownMenuItem(value: 2, child: Text('Jim')),
            //       ],
            //       onChanged: dropdownPicture,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Card(
              child: ListTile(
                title: const Text('Text Size'),
                trailing: DropdownButton(
                  //dropdownColor: Colors.white,
                  value: _textSizeValue,
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Small')),
                    DropdownMenuItem(value: 1, child: Text('Medium')),
                    DropdownMenuItem(value: 2, child: Text('Large')),
                  ],
                  onChanged: dropdownTextSize,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                title: const Text('AI Type'),
                trailing: DropdownButton(
                  //dropdownColor: Colors.white,
                  value: _aiValue,
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Nice')),
                    DropdownMenuItem(value: 1, child: Text('Mean')),
                    DropdownMenuItem(value: 2, child: Text('Mysterious')),
                  ],
                  onChanged: dropdownAiType,
                ),
              ),
            ),
          ],
        ));
  }
}
