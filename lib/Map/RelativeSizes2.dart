import 'package:flutter/material.dart';

class SizeConfig {
  late MediaQueryData _mediaQuery;
  static late double height;
  static late double width;
  static Orientation? orientation;
  static late double bottom;



  void init(BuildContext context) {

    _mediaQuery = MediaQuery.of(context);
    height = _mediaQuery.size.height;
    width = _mediaQuery.size.width;
    orientation = _mediaQuery.orientation;
    bottom = _mediaQuery.viewInsets.bottom;
  }



  static bool get isKeyBoardOpen => bottom > 0;

// static double get screenHeight => orientation == Orientation.portrait ? height - bottom : height;
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.height;
  // Our designer use iPhone 11 , that's why we use 896.0
  return (inputHeight / 759.2727272727273) * screenHeight;
}
// Get the proportionate height as per screen size when orientation [portrait]
double getHeightWhenOrientationLand(double inputHeight, [double min = 0]) {
  double screenWidth = SizeConfig.height;
  double value = (inputHeight / 392.72727272727275) * screenWidth;
  return value < min ? inputHeight : value;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.width;
  // 414 is the layout width that designer use or you can say iPhone 11  width
  return (inputWidth / 392.72727272727275) * screenWidth;
}

// For add free space vertically
class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({
    Key? key,
    this.of = 25,
  }) : super(key: key);

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(of),
    );
  }
}// For add free space vertically
class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace({
    Key? key,
    this.of = 25,
  }) : super(key: key);

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(of),
    );
  }
}