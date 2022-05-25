import 'package:flutter/material.dart';
import 'package:lbc/container/recipe_container.dart';
import 'package:lbc/container/sort_dialog_container.dart';
import 'package:lbc/data/food_provider.dart';
import 'package:lbc/screens/background_image.dart';
import 'package:provider/provider.dart';

import '../container/recipe_container.dart';
import '../data/food_provider.dart';

class RecipesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundImage(),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text("LBC | Scan Your Food", style: TextStyle(color: Colors.green)),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: () => showGeneralDialog(
                      context: context,
                      pageBuilder: (context, animationFrom, animationTo) {
                        return;
                      },
                      barrierDismissible: true,
                      barrierLabel: '',
                      transitionDuration: const Duration(milliseconds: 500),
                      transitionBuilder: (context, animationFrom, animationTo, child) {
                        final curveValue = Curves.easeInOutBack.transform(animationFrom.value) - 1.0;
                        return Transform(
                            transform: Matrix4.translationValues(0.0, curveValue * 400, 0.0),
                            child: Dialog(
                              child: SortDialogContainer(),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ));
                      }))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: context.watch<FoodProvider>().getRecipes.isEmpty ? Center(child: CircularProgressIndicator()) : generateRecipesGridView(context),
          )),
    ]);
  }

  GridView generateRecipesGridView(BuildContext context) {
    final recipes = context.watch<FoodProvider>().getRecipes;
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(recipes.length, (index) {
        return RecipeContainer(recipe: recipes[index]);
      }),
    );
  }
}
