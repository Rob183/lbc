import 'package:flutter/material.dart';

class Ingredient {
  String name;
  Image icon;

  Ingredient(final String name) {
    this.name = name;
    this.icon = Image(image: AssetImage('assets/icons/'+ name.toLowerCase() +'.png'), height: 10, width: 10,);
  }
}
