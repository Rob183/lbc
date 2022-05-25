import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final image = AssetImage("assets/background-image/background-image_edited.jpg");

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: image, fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black54, BlendMode.softLight))),
      ),
    );
  }
}
