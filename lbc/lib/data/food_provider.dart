import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lbc/container/network_error_container.dart';
import 'package:lbc/data/recipe.dart';
import 'package:lbc/main.dart';
import 'package:lbc/screens/loading_screen.dart';

import 'ingredient.dart';

class FoodProvider extends ChangeNotifier {
  List<Ingredient> _ingredients = [];
  List<Recipe> _recipes = [];
  String _foodJoke = "Waiting for a new joke...";

  List<Ingredient> get getIngredients => _ingredients;
  List<Recipe> get getRecipes => _recipes;
  String get getFoodJoke => _foodJoke;

  void addByDropdown(final String choice) {
    if (!isIncluded(choice)) {
      _ingredients.add(Ingredient(choice));
      notifyListeners();
    }
  }

  void deleteAll() {
    _ingredients.clear();
    _recipes.clear();
    notifyListeners();
  }

  void deleteIngredient(int index) {
    _ingredients.removeAt(index);
    notifyListeners();
  }

  Future<void> detectByImage(final ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.getImage(source: source, maxHeight: 416, maxWidth: 416);

    if (image == null) return;

    _foodJoke = await getRandomFoodJoke();

    try {
      showDialog(context: navigatorKey.currentContext, builder: (context) => LoadingScreen(), barrierDismissible: false);
      final request = http.MultipartRequest("POST", Uri.parse("https://sprimm.eu.pythonanywhere.com/detection"));
      request.headers.addAll({"content-type": "application/json"});
      request.files.add(await http.MultipartFile.fromPath("image", image.path));

      final response = await request.send();
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final responseAsByteStream = await response.stream.toBytes();
        final decodedResponse = jsonDecode(String.fromCharCodes(responseAsByteStream));
        final responseList = decodedResponse['detections'] as List;

        final ingredientsList = responseList.map((entry) => Ingredient(entry['class'] as String)).toList();
        ingredientsList.forEach((element) {
          if (!isIncluded(element.name)) {
            _ingredients.add(element);
          }
        });

        notifyListeners();
      } else {
        networkErrorHandler(statusCode);
      }

      Navigator.of(navigatorKey.currentContext).pop();
    } on SocketException {
      networkErrorHandler(7);
    }
  }

  Future<String> getRandomFoodJoke() async {
    try {
      final response = await http.get("https://sprimm.eu.pythonanywhere.com/joke");
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return decodedResponse['joke'] as String;
      } else {
        networkErrorHandler(statusCode);
        return "Waiting for a new joke...";
      }
    } on SocketException {
      networkErrorHandler(7);
      return "Waiting for a new joke...";
    }
  }

  bool isIncluded(String name) {
    bool isIncluded = false;
    _ingredients.forEach((element) {
      if (element.name == name) isIncluded = true;
    });
    return isIncluded;
  }

  void searchRecipes() async {
    _recipes.clear();
    //generate string of comma separated ingredients
    final ingredientsString = _ingredients.fold("", (previousValue, element) => previousValue + "," + element.name).toString();

    try {
      final response = await http.get("https://sprimm.eu.pythonanywhere.com/recipe/$ingredientsString");
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final recipesList = decodedResponse['recipes'] as List;
        _recipes = recipesList.map((entry) => Recipe.fromJson(entry)).toList();
        notifyListeners();
      } else {
        networkErrorHandler(statusCode);
      }
    } on SocketException {
      networkErrorHandler(7);
    }
  }

  void sortRecipeList(final int choice) {
    switch (choice) {
      case 0:
        _recipes.sort((b, a) => a.likes.compareTo(b.likes));
        break;
      case 1:
        _recipes.sort((b, a) => a.usedIngredientCount.compareTo(b.usedIngredientCount));
        break;
      case 2:
        _recipes.sort((b, a) => a.missedIngredientCount.compareTo(b.missedIngredientCount));
        break;
    }
    notifyListeners();
  }

  void networkErrorHandler(int errorNumber) {
    showDialog(context: navigatorKey.currentContext, builder: (context) => NetworkErrorContainer(errorNumber: errorNumber));
  }
}
