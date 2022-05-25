import 'package:flutter/material.dart';
import 'package:lbc/container/empty_ingredients_view_container.dart';
import 'package:lbc/controls/control_bar.dart';
import 'package:lbc/data/food_provider.dart';
import 'package:lbc/screens/background_image.dart';
import 'package:provider/provider.dart';

import '../data/food_provider.dart';

class IngredientsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text("LBC | Scan Your Food", style: TextStyle(color: Colors.green)),
            backgroundColor: Colors.transparent,
            actions: [
              AnimatedOpacity(
                opacity: context.read<FoodProvider>().getIngredients.isNotEmpty ? 1 : 0,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 400),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  color: Color(0xf7f8fbff),
                  onPressed: () => context.read<FoodProvider>().deleteAll(),
                ),
              )
            ],
          ),
          body: context.watch<FoodProvider>().getIngredients.isEmpty ? EmptyIngredientsViewContainer() : generateIngredientsListView(context),
          floatingActionButton: ControlBar(),
        )
      ],
    );
  }

  ListView generateIngredientsListView(BuildContext context) {
    final ingredients = context.read<FoodProvider>().getIngredients;
    return ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          return Container(
              padding: EdgeInsets.all(10),
              height: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white12),
              child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Container(
                          margin: EdgeInsets.only(left: 32),
                          child: Text(
                            ingredient.name,
                            style: TextStyle(color: Color(0xf7f8fbff), fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ))),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        child: FittedBox(alignment: Alignment.topRight, fit: BoxFit.contain, child: ingredient.icon),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(left: 30),
                          child: IconButton(
                              icon: Icon(Icons.backspace),
                              color: Color(0xf7f8fbff),
                              onPressed: () {
                                context.read<FoodProvider>().deleteIngredient(index);
                              })))
                ],
              ));
        });
  }
}
