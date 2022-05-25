import 'package:flutter/material.dart';
import 'package:lbc/data/food_provider.dart';
import 'package:lbc/screens/ingredients_view.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodProvider>(
      create: (_) => FoodProvider(),
      child: MaterialApp(
        title: 'LBC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: IngredientsView(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
