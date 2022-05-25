import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lbc/data/food_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/animations/loadingBanana.riv').then(
      (data) async {
        final file = RiveFile();
        if (file.import(data)) {
          setState(() {
            _riveArtboard = file.mainArtboard;
            _controller = SimpleAnimation('idle');
            _riveArtboard.addController(_controller);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(builder: (context, foodProvider, child) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: BoxConstraints(maxHeight: 350),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Analyzing Ingredient...", style: TextStyle(color: Colors.green, fontSize: 20))],
              ),
              Container(
                height: 200,
                width: 200,
                child: _riveArtboard == null ? const SizedBox() : Rive(artboard: _riveArtboard),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  foodProvider.getFoodJoke,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
