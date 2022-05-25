import 'package:flutter/material.dart';

class EmptyIngredientsViewContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Pretty empty in here, isn't it?\n",
                  style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                        text: "Click on the menu below and choose your camera, your gallery or our item list to add an ingredient.",
                        style: TextStyle(color: Colors.white, fontSize: 18))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
