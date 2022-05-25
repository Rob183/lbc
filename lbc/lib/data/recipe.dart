import 'package:flutter/material.dart';

class Recipe {
  final String title;
  final Image image;
  final List<String> ingredients;
  final int missedIngredientCount, usedIngredientCount, likes;

  const Recipe({this.title, this.image, this.likes, this.missedIngredientCount, this.usedIngredientCount, this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> loadIngredients(List used, List missed) {
      final List<String> ingredients = [];
      used.forEach((element) => ingredients.add(element['original'] as String));
      missed.forEach((element) => ingredients.add(element['original'] as String));
      return ingredients;
    }

    /*
    String cutTitle(String title) {
      if (title.length <= 32) {
        return title;
      } else {
        title = title.replaceAll(",", "");
        final List<String> sliced = title.split(" ");
        String slicedString = "";
        sliced.forEach((element) {
          if ((slicedString + " " + element).length <= 32) slicedString += element;
        });
        slicedString += "...";
        return slicedString;
      }
    }
    */

    return Recipe(
        title: json['title'] as String, //cutTitle(json['title'] as String),
        image: Image.network(json['image'] as String, fit: BoxFit.cover),
        likes: json['likes'] as int,
        missedIngredientCount: json['missedIngredientCount'] as int,
        usedIngredientCount: json['usedIngredientCount'] as int,
        ingredients: loadIngredients(json['usedIngredients'] as List, json['missedIngredients'] as List));
  }
}
