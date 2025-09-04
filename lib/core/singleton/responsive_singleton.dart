import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveSingleton {
  factory ResponsiveSingleton() {
    _instance ??= ResponsiveSingleton._();
    return _instance!;
  }

  ResponsiveSingleton._();

  static ResponsiveSingleton? _instance;

  static late BuildContext context;

  static void init({required BuildContext context}) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ip = math.sqrt(math.pow(width, 2) + math.pow(height, 2));
  }

  static late double width;
  static late double height;
  static late double ip;
  static double heightDefault = 1200;

  static double heightCustom(double value) {

    final height = MediaQuery.of(context).size.height;

    return height * value;
  }

  static double widthCustom(double value) {
    final width = MediaQuery.of(context).size.width;
    return width * value;
  }

  static double proportionalFont(double fontSize) {
    
    var fontSizeProportional = fontSize;
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;
    final sizeWidth = MediaQuery.of(context).size.width;

    if( isPortrait && sizeWidth < 500){
      fontSizeProportional = fontSizeProportional - 3;
    }

    return (sizeWidth * fontSizeProportional) / sizeWidth;
  }

  static double proportionalWidth({
    required double portrait,
    required double landscape,
  }) {

    final size = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    final value = (orientation ==  Orientation.portrait) ? size * portrait : size * landscape;

    return value;
  }

  static double propotionalHeight({
    required double portrait,
    required double landscape,
  }) {

    final size = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    final value = (orientation ==  Orientation.portrait) ? size * portrait : size * landscape;

    return value;
  }

  static double textScaleFactor(BuildContext contextNow, {double maxTextScaleFactor = 2}) {

    final orientation = MediaQuery.of(contextNow).orientation;
    final isPortrait = orientation == Orientation.portrait;

    final size = isPortrait ?  MediaQuery.of(contextNow).size.height : MediaQuery.of(contextNow).size.width ;
    final val = (size / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }

  static double heightResponsive( double value ){

    final height = MediaQuery.of(context).size.height;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if( isPortrait ){
      return height * value;
    }else {
      return heightDefault * value;

    }


  }
}
