import 'dart:convert';
import 'package:flutter/material.dart';
import '/model/drink_entry.dart';
import 'package:http/http.dart' as http;

class DrinkProvider with ChangeNotifier{
  List<DrinkEntry> _items = [];
  final url = 'http://10.0.2.2:5000/todo';

  List<DrinkEntry> get items {
    return [..._items];
  }

  Future<void> addDrink(String drink, double amt) async {
    if(drink.isEmpty){
      return;
    }
    Map<String, dynamic> request = {"name": drink, "amt": amt};
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(url), headers: headers, body: json.encode(request));
    Map<String, dynamic> responsePayload = json.decode(response.body);
    final drinke = DrinkEntry(
        id: responsePayload["id"],
        drinkName: responsePayload["drink"],
        drinkAmount: responsePayload["amt"]
    );
    _items.add(drinke);
    notifyListeners();
  }

  Future<void> get getDrinks async {
    var response;
    try{
      response = await http.get(Uri.parse(url));
      List<dynamic> body = json.decode(response.body);
      _items = body.map((e) => DrinkEntry(
          id: e['id'],
          drinkName: e['drink'],
          drinkAmount: e['amt']
      )
      ).toList();
    }catch(e){
      print(e);
    }
    notifyListeners();
  }

  Future<void> deleteDrink(int drinkId) async {
    var response;
    try{
      response = await http.delete(Uri.parse("$url/$drinkId"));
      final body = json.decode(response.body);
      _items.removeWhere((element) => element.id == body["id"]);
    }catch(e){
      print(e);
    }
    notifyListeners();
  }

  Future<void> incrementDrink(int drinkId) async {
    try{
        final response = await http.patch(Uri.parse("$url/$drinkId"));
        Map<String, dynamic> responsePayload = json.decode(response.body);
        _items.forEach((element) => {
        if(element.id == responsePayload["id"]){
            element.drinkAmount += 1
            // responsePayload["is_executed"]
        }
        });
    }catch(e){
      print(e);
    }
    notifyListeners();
  }
}