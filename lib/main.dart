import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Map<String, Food> _foods = {
    'apple': Food(
      name: 'Apple',
      description: 'Red fruit thing',
      image: 'https://i.imgur.com/HPGcdN8.png',
      nutritionFacts: 'Calories: 95\nFat: 0.3g\nProtein: 0.5g\nCarbs: 25g', key: 'apple',
    ),
    'banana': Food(
      name: 'Banana',
      description:
      'Long fruit thing',
      image: 'https://i.imgur.com/fbBaztj.png',
      nutritionFacts: 'Calories: 105\nFat: 0.4g\nProtein: 1.3g\nCarbs: 27g', key: 'banana',
    ),
    'carrot': Food(
      name: 'Carrot',
      description:
      'Long vegetable thing',
      image: 'https://i.imgur.com/TYmoZAT.png',
      nutritionFacts: 'Calories: 41\nFat: 0.2g\nProtein: 0.9g\nCarbs: 10g', key: 'carrot',
    ),
  };

  String _searchText = '';

  void _onSearchTextChanged(String value) {
    setState(() {
      _searchText = value;
    });
  }

  void _onFoodTapped(String key) {
    setState(() {
      _foods[key]!.expanded = !_foods[key]!.expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Food> filteredFoods = _foods.values
        .where((food) =>
        food.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          onChanged: _onSearchTextChanged,
        ),
      ),
      body: ListView.builder(
        itemCount: filteredFoods.length,
        itemBuilder: (context, index) {
          final food = filteredFoods[index];
          return Column(
            children: [
              ListTile(
                onTap: () => _onFoodTapped(food.key),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(food.image),
                ),
                title: Text(food.name),
                subtitle: Text(food.description),
              ),
              if (food.expanded)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nutrition Facts',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => _onFoodTapped(food.key),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(food.nutritionFacts),
                    ],
                  ),
                ),
              Divider(height: 1.0),
            ],
          );
        },
      ),
    );
  }
}

class Food {
  final String key;
  final String name;
  final String description;
  final String image;
  final String nutritionFacts;
  bool expanded;

  Food({
    required this.key,
    required this.name,
    required this.description,
    required this.image,
    required this.nutritionFacts,
    this.expanded = false,
  });
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
enum BACStatus {
  sober,
  mildImpairment,
  increasedImpairment,
  severeImpairment,
  lifeThreatening,
}

class _HomePageState extends State<HomePage> {
  double _bac = 0.0;
  BACStatus _bacStatus = BACStatus.sober;

  void _updateBAC(double newBAC) {
    setState(() {
      _bac = newBAC;
      if (_bac <= 0.0) {
        _bacStatus = BACStatus.sober;
      } else if (_bac > 0.0 && _bac <= 0.05) {
        _bacStatus = BACStatus.mildImpairment;
      } else if (_bac > 0.06 && _bac <= 0.15) {
        _bacStatus = BACStatus.increasedImpairment;
      } else if (_bac > 0.15 && _bac <= 0.3) {
        _bacStatus = BACStatus.severeImpairment;
      } else {
        _bacStatus = BACStatus.lifeThreatening;
      }
    });
  }

  void _incrementBAC() {
    setState(() {
      if (_bac < 1.0) {
        _bac += 0.01;
        _updateBAC(_bac);
      }
    });
  }

  void _decrementBAC() {
    setState(() {
      if (_bac > 0.0) {
        _bac -= 0.01;
        _updateBAC(_bac);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color statusBoxColor;
    String bacStatusString;
    String bacInfoString;
    switch (_bacStatus) {
      case BACStatus.sober:
        statusBoxColor = Colors.lightGreen;
        bacStatusString = "Sober";
        bacInfoString = "You're sober with no alcohol in your system";
        break;
      case BACStatus.mildImpairment:
        statusBoxColor = Colors.yellow;
        bacStatusString = "Mild Impairment";
        bacInfoString = "You may feel relaxed, slightly lightheaded, and have a slower reaction time. This level of impairment can affect the ability to drive safely and make good decisions.";
        break;
      case BACStatus.increasedImpairment:
        statusBoxColor = Colors.orange;
        bacStatusString = "Increased Impairment";
        bacInfoString = "Legally intoxicated. A person may experience slurred speech, impaired balance, and a loss of coordination. They may also experience impaired judgment and a decreased ability to make good decisions.";
        break;
      case BACStatus.severeImpairment:
        statusBoxColor = Colors.orangeAccent;
        bacStatusString = "Severe Impairment";
        bacInfoString = "You may have difficulty walking, blurred vision, and may vomit. At this level, a person may have difficulty controlling their movements and may have a significantly impaired ability to make decisions. It is important to note that at this level, there is a high risk of blackouts and memory loss.";
        break;
      case BACStatus.lifeThreatening:
        statusBoxColor = Colors.red;
        bacStatusString = "Life-Threatening";
        bacInfoString = "At this level, a person may experience respiratory depression, which can lead to coma or death. They may also experience a loss of consciousness, and the ability to remain awake. It is important to note that a BAC of 0.40% or higher can be lethal for many people.";
        break;
    }
    Color statusTextColor = Colors.black;

    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Blood Alcohol Level (BAC)',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200.0,
                height: 200.0,
                child: CircularProgressIndicator(
                  value: _bac / 0.3,
                  strokeWidth: 10.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.lerp(
                      Colors.green,
                      Colors.red,
                      _bac < 0.3 ? _bac*(1/0.3) : 1.0
                    ) ?? Colors.grey,
                  )
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _bac.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    bacStatusString,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _decrementBAC,
                child: Text('-0.01'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: _incrementBAC,
                child: Text('+0.01'),
              ),
            ],
          ),
         Padding(
           padding: EdgeInsets.all(8),
             child: Container(
           decoration: BoxDecoration(
             color: Colors.amberAccent,
             borderRadius: BorderRadius.circular(10)
           ),
           padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
           child: Text(
             bacInfoString,
             style: TextStyle(
               fontSize: 16,
               color: Colors.black,
             )
           ),
         )),
          ElevatedButton(onPressed: null, child: Text('Drinking Schedule')),
          ElevatedButton(onPressed: null, child: Text('Record Sensor Reading')),
          ElevatedButton(onPressed: null, child: Text('Sensor Battery')),
        ],
      ),
    );
  }
}

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