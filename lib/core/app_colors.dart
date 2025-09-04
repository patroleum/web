import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._();

  AppColors._();

  factory AppColors() => _instance;

  static const Color primaryColor = Color(0xFF111111);
  static const Color secondaryColor = Color(0xFF202020);
  static const Color accentColor = Color(0xFF79AB0E);
  static const Color backgroundColor = Color(0xFFF4F4F4);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF4E4E52);
  static const Color grey = Color(0xFFD8D8D8);
  static const Color lightGrey = Color(0xFFE6E6E6);
  static const Color lighterGrey = Color(0xFFCDCDCD);
  static const Color lightWhite = Color(0xFFF5F5F5);
  static const Color darkYellow = Color(0xFFE5B136);
  static const Color lightGrey1 = Color(0xffefefef);
  static const Color cyan = Color(0xFF00B3DA);
  static const Color backgroundGreen = Color(0xFF559B36);
  static const Color purple = Color(0xFF7036E5);
  static const Color backgroundBlue = Color(0xFF068EAB);
  static const Color backgroundYellow = Color(0xFFF3EBBE);
  static const Color primaryBlue = Color(0xFF2F80ED);
  static const Color red = Color(0xFFFF304F);
  static const Color errorColor = Color(0xFF9B1313);
  static const Color colorBrown = Color(0xFF976036);

  static const Color labelColor = Color(0xFF707070);
  static const Color activeLabelColor = Color(0xFFDCB83E);

  static const Color lightUserColor = Color(0xFFE0EBFF);
  static const Color lightTaskColor = Color(0xFFFFF8E5);
  static const Color lightGreenColor = Color(0xFFE2FFE0);
  static const Color lightRedColor = Color(0xFFFFE0E0);

  static const Color iconUserColor = Color(0xFF2974FF);
  static const Color iconTaskColor = Color(0xFFFF8929);

  static const Color labelTimeColor = Color(0xFFD66A11);

  static const Color shadowColor = Color(0x661AAACF);

  static const Color buttonColor = Color(0xFF7CBD1E);

  static const BoxShadow boxShadowPerfect = BoxShadow(
    color: Color(0x0F000000),
    offset: Offset(0, 8),
    blurRadius: 24,
  );
  static const Color inputBorderColor = Color(0xFFB3B3B3);
  static const Color btnCallColor = Color(0x2682D681);
  static const Color iconCallColor = Color(0xFF39BD68);

  static const Color btnEmailColor = Color(0x2382A8D6);
  static const Color iconEmailColor = Color(0xFF397BBD);

  static const Color thirdPurpleColor = Color(0xFF513369);

  static const Color drawerTextPurpleColor = Color(0x4D8562A0);
  static const Color lightPurpleColor = Color(0xFF8562A0);
  static const Color secondaryPurple = Color(0xff7314dc);
  static const Color videoFooter = Color(0x99000000);
  static const Color circleBlur = Color(0x27ffb646);
  static const Color bgColor = Color(0xffEBE9F2);

  static const Color switchColor = Color(0x4d666666);

  static const Color yellowColor = Color(0xffFFB646);

  static const Color shareColor = Color(0xffC6B5D6);

  static const Color purple2Color = Color(0xffC199E0);

  static const Color darkPurpleColor = Color(0xff231F20);

  static const Color tipColor = Color(0xffFFBF49);

  static const Color bgTextFieldColor = Color(0x1f737373);

  static const Color dataTextFieldColor = Color(0xffEAE5ED);

  static const Color loginAccountColor = Color(0xff513369);

  static const Color playColor = Color(0xffED8721);

  static const Color complementaryColor = Color.fromARGB(255, 118, 137, 230);
}
