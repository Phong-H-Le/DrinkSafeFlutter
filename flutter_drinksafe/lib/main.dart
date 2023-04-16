import 'package:flutter/material.dart';
import 'home_page.dart';
import 'info_page.dart';
import 'settings_page.dart';
import 'drinks.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    InfoPage(),
    HomePage(), 
    SettingsPage(),
    DrinksWidget()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.info),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.ac_unit_sharp),
              label: 'Drink',
            ),
          ],
        ),
      ),
    );
  }
}

