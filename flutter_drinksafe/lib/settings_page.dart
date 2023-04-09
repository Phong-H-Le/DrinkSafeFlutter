import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool testOption1 = false;
  bool testOption2 = false;
  bool testOption3 = false;
  bool testOption4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Info',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Weight',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 'Male',
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'Female',
                  child: Text('Female'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 32),
            Text(
              'Advanced Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Test Option 1'),
              value: testOption1,
              onChanged: (value) {
                setState(() {
                  testOption1 = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Test Option 2'),
              value: testOption2,
              onChanged: (value) {
                setState(() {
                  testOption2 = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Test Option 3'),
              value: testOption3,
              onChanged: (value) {
                setState(() {
                  testOption3 = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Test Option 4'),
              value: testOption4,
              onChanged: (value) {
                setState(() {
                  testOption4 = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}