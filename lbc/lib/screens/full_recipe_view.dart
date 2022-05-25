import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbc/data/recipe.dart';

class FullRecipeView extends StatelessWidget {
  const FullRecipeView({Key key, this.recipe}) : super(key: key);

  final Recipe recipe;

  String ingredientsString(List ingredientList) {
    String listAsString = "- ";
    for (int i = 0; i < ingredientList.length; i++) {
      listAsString =
          listAsString + ingredientList[i].toString()[0].toUpperCase() + ingredientList[i].toString().substring(1, ingredientList[i].toString().length);
      if (ingredientList.length - i > 1) {
        listAsString += "\n" + "- ";
      }
    }
    return listAsString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              leading: Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30,
                  color: Color(0xf7f8fbff),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              expandedHeight: 300,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(26))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            recipe.title,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: TextStyle(color: Color(0xf7f8fbff)),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ],
                ),
                background: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: recipe.image.image, fit: BoxFit.cover), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.clear, size: 30, color: Colors.red),
                      SizedBox(width: 5),
                      Text(recipe.missedIngredientCount.toString(), style: TextStyle(fontSize: 24, color: Color(0xf7f8fbff))),
                      SizedBox(width: 5),
                      Icon(Icons.add, size: 30, color: Colors.green),
                      SizedBox(width: 5),
                      Text(recipe.usedIngredientCount.toString(), style: TextStyle(fontSize: 24, color: Color(0xf7f8fbff))),
                      SizedBox(width: 5),
                      Icon(Icons.whatshot, size: 26, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(recipe.likes.toString(), style: TextStyle(fontSize: 24, color: Color(0xf7f8fbff)))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Ingredients:",
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: List.generate(recipe.ingredients.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.adjust,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      recipe.ingredients[index],
                                      style: TextStyle(fontSize: 18, color: Color(0xf7f8fbff)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            )
          ],
        )

        /*SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/background-image/background-image_edited.jpg"),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  recipe.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(360), border: Border.all(width: 10.0, color: Colors.green)),
                width: 300,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: recipe.image,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30),
                width: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                    child: Image.asset("assets/icons/like.png", width: 40),
                  ),
                  WidgetSpan(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Text("  " + recipe.likes.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ))))
                ])),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Ingredients",
                          style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Text(
                          ingredientsString(recipe.ingredients),
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 0, 5),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 2,
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                            "Number of missed ingredients: ",
                            style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                          WidgetSpan(
                              child: Text(
                            recipe.missedIngredientCount.toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ))
                        ]))),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                            "Number of used ingredients: ",
                            style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                          WidgetSpan(
                              child: Text(
                            recipe.usedIngredientCount.toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ))
                        ])))
                  ],
                ),
              )
            ],
          ),
        ))*/
        );
  }
}
