import 'package:flutter/material.dart';

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
