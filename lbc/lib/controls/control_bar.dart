import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lbc/controls/ingredients_choice.dart';
import 'package:lbc/data/food_provider.dart';
import 'package:lbc/screens/recipes_view.dart';
import 'package:provider/provider.dart';

class ControlBar extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> _menuStateKey = GlobalKey();

  ControlBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        return Stack(
          children: [
            Align(
              child: FabCircularMenu(
                key: _menuStateKey,
                alignment: Alignment.bottomLeft,
                animationDuration: Duration(milliseconds: 200),
                animationCurve: Curves.bounceInOut,
                fabOpenIcon: Icon(Icons.menu, color: Color(0xf7f8fbff)),
                fabCloseIcon: Icon(Icons.close, color: Color(0xf7f8fbff)),
                ringColor: Colors.transparent,
                ringDiameter: 200,
                ringWidth: 20,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera),
                    color: Color(0xf7f8fbff),
                    onPressed: () {
                      foodProvider.detectByImage(ImageSource.camera);
                      _menuStateKey.currentState.close();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.image_search_outlined),
                    color: Color(0xf7f8fbff),
                    onPressed: () {
                      foodProvider.detectByImage(ImageSource.gallery);
                      _menuStateKey.currentState.close();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.list),
                    color: Color(0xf7f8fbff),
                    onPressed: () {
                      _menuStateKey.currentState.close();
                      showGeneralDialog(
                          context: context,
                          pageBuilder: (context, animationFrom, animationTo) {
                            return;
                          },
                          barrierDismissible: true,
                          barrierLabel: '',
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionBuilder: (context, animationFrom, animationTo, child) {
                            final curveValue = Curves.easeInOutBack.transform(animationFrom.value) - 1.0;
                            return Transform(transform: Matrix4.translationValues(0.0, curveValue * 400, 0.0), child: IngredientsChoice());
                          });
                    },
                  ),
                  /*
                  IconButton(
                      icon: Icon(Icons.settings),
                      color: Color(0xf7f8fbff),
                      onPressed: () {
                        _menuStateKey.currentState.close();
                        showDialog(context: context, builder: (context) => LoadingScreen());
                      }
                  )
                  */
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedOpacity(
                opacity: foodProvider.getIngredients.isNotEmpty ? 1 : 0,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 400),
                child: Container(
                  width: 64,
                  height: 64,
                  child: FittedBox(
                    child: FloatingActionButton(
                      child: Icon(
                        Icons.check,
                        color: Color(0xf7f8fbff),
                      ),
                      backgroundColor: Colors.green,
                      heroTag: null,
                      onPressed: () {
                        foodProvider.searchRecipes();
                        Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder: (context, animationFrom, animationTo) => RecipesView(),
                          transitionsBuilder: (context, animation, animationTo, child) {
                            animation = CurvedAnimation(parent: animation, curve: Curves.easeInOutBack);

                            return ScaleTransition(
                              scale: animation,
                              child: child,
                              alignment: Alignment.bottomRight,
                            );
                          },
                        ));
                        _menuStateKey.currentState.close();
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
