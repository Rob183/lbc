import 'package:flutter/material.dart';
import 'package:lbc/data/food_provider.dart';
import 'package:provider/provider.dart';

class SortDialogContainer extends StatelessWidget {
  const SortDialogContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 150,
        height: 200,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(20)),
        child: Consumer<FoodProvider>(
          builder: (context, foodProvider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Sort By:", style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w600)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.whatshot, color: Colors.blue, size: 26),
                    SizedBox(width: 5),
                    ButtonTheme(
                        buttonColor: Colors.black26,
                        minWidth: 180,
                        child: TextButton(
                            child: Text("Likes", style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              foodProvider.sortRecipeList(0);
                              Navigator.pop(context);
                            })),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 30, color: Colors.green),
                    SizedBox(width: 5),
                    ButtonTheme(
                        buttonColor: Colors.black26,
                        minWidth: 180,
                        child: TextButton(
                            child: Text("Used Ingredients", style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              foodProvider.sortRecipeList(1);
                              Navigator.pop(context);
                            })),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.clear, size: 30, color: Colors.red),
                    SizedBox(width: 5),
                    ButtonTheme(
                        buttonColor: Colors.black26,
                        minWidth: 180,
                        child: TextButton(
                            child: Text("Missed Ingredients", style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              foodProvider.sortRecipeList(2);
                              Navigator.pop(context);
                            })),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
