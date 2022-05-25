import 'package:flutter/material.dart';
import 'package:lbc/data/recipe.dart';
import 'package:lbc/screens/full_recipe_view.dart';

class RecipeContainer extends StatelessWidget {
  final Recipe recipe;

  const RecipeContainer({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => FullRecipeView(recipe: recipe))),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: recipe.image.image, fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(recipe.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(fontSize: 20, color: Color(0xf7f8fbff))),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 24,
                      ),
                      SizedBox(width: 5),
                      Text(recipe.missedIngredientCount.toString(), style: TextStyle(fontSize: 16))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.green, size: 24),
                      SizedBox(width: 5),
                      Text(recipe.usedIngredientCount.toString(), style: TextStyle(fontSize: 16))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.whatshot, size: 24, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(recipe.likes.toString(), style: TextStyle(fontSize: 16))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
        /*Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white12,
            ),
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    height: 48,
                    child: Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(width: 3.0, color: Colors.green)),
                  width: 128,
                  height: 128,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: recipe.image,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Text(recipe.usedIngredientCount.toString() + " ingredients were used.", style: TextStyle(fontSize: 12, color: Colors.grey))),
                Container(
                    alignment: Alignment.center,
                    child: Text(recipe.missedIngredientCount.toString() + " ingredient is missing.", style: TextStyle(fontSize: 12, color: Colors.grey))),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 12),
                  child: RichText(
                      text: TextSpan(children: [
                    WidgetSpan(
                      child: Image.asset("assets/icons/like.png", width: 20),
                    ),
                    WidgetSpan(
                        child: Text(" " + recipe.likes.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                            )))
                  ])),
                )
              ],
            ))*/
        );
  }
}
