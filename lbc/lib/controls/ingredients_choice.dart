import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbc/data/food_provider.dart';
import 'package:provider/provider.dart';

class IngredientsChoice extends StatefulWidget {
  const IngredientsChoice({Key key}) : super(key: key);

  @override
  _IngredientsChoiceState createState() => _IngredientsChoiceState();
}

class _IngredientsChoiceState extends State<IngredientsChoice> {
  String _value;
  List<String> choices = [
    "Apple",
    "Artichoke",
    "Asparagus",
    "Avocado",
    "Banana",
    "Bellpepper",
    "Blueberry",
    "Broccoli",
    "Cabbage",
    "Carrot",
    "Cherry",
    "Cucumber",
    "Garlic",
    "Grape",
    "Grapefruit",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Peach",
    "Pear",
    "Pineapple",
    "Pomegranate",
    "Potato",
    "Pumpkin",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Watermelon",
    "Zucchini"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Choose Your Food',
                  style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: DropdownButton<String>(
                    value: _value,
                    isExpanded: true,
                    style: TextStyle(color: Color(0xf7f7fbff), fontSize: 16),
                    items: choices.map((String selected) {
                      return DropdownMenuItem<String>(
                        value: selected,
                        child: Text(selected),
                      );
                    }).toList(),
                    onChanged: (selected) {
                      setState(() {
                        _value = selected;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text('Add', style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        if (_value.isNotEmpty) {
                          foodProvider.addByDropdown(_value);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                        child: Text("Cancel", style: TextStyle(fontSize: 16)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
