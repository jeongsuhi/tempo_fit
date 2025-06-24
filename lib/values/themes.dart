import 'package:flutter/material.dart';

enum Themes {
  darkRedWhite,
  lightBlueWhite,
  yellowAccentDarkGrey,
}

extension ThemesExtension on Themes {

  /// NOTE: 絶対に変更しないこと
  String get id {
    switch (this) {
      case Themes.darkRedWhite:
        return "darkRedWhite";
      case Themes.lightBlueWhite:
        return "lightBlueWhite";
      case Themes.yellowAccentDarkGrey:
        return "yellowAccentDarkGrey";
    }
  }

  String get title {
    switch (this) {
      case Themes.darkRedWhite:
        return "darkRedWhite";
      case Themes.lightBlueWhite:
        return "lightBlueWhite";
      case Themes.yellowAccentDarkGrey:
        return "yellowAccentDarkGrey";
    }
  }

  Color get primaryColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.red.shade900;
      case Themes.lightBlueWhite:
        return Colors.lightBlue.shade600;
      case Themes.yellowAccentDarkGrey:
        return Colors.yellowAccent;
    }
  }
  Color get onPrimaryColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.white;
      case Themes.lightBlueWhite:
        return Colors.white;
      case Themes.yellowAccentDarkGrey:
        return Colors.grey.shade900;
    }
  }
  Color get primaryBaseColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.red.shade50;
      case Themes.lightBlueWhite:
        return Colors.lightBlue.shade50;
      case Themes.yellowAccentDarkGrey:
        return const Color(0xFF2b2911);
    }
  }
  Color get primaryAccentBaseColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.red.shade100;
      case Themes.lightBlueWhite:
        return Colors.lightBlue.shade100;
      case Themes.yellowAccentDarkGrey:
        return Colors.lime.shade700;
    }
  }
  Color get primaryOverlayColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.black26;
      case Themes.lightBlueWhite:
        return Colors.black26;
      case Themes.yellowAccentDarkGrey:
        return Colors.white30;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.white;
      case Themes.lightBlueWhite:
        return Colors.white;
      case Themes.yellowAccentDarkGrey:
        return const Color(0xFF151515);
    }
  }
  Color get backgroundOverlayColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.black12;
      case Themes.lightBlueWhite:
        return Colors.black12;
      case Themes.yellowAccentDarkGrey:
        return Colors.white10;
    }
  }
  Color get onBackgroundColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.black87;
      case Themes.lightBlueWhite:
        return Colors.black87;
      case Themes.yellowAccentDarkGrey:
        return Colors.grey.shade100;
    }
  }

  Color get baseColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.grey.shade200;
      case Themes.lightBlueWhite:
        return Colors.grey.shade200;
      case Themes.yellowAccentDarkGrey:
        return Colors.grey.shade900;
    }
  }
  Color get onBaseColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.black87;
      case Themes.lightBlueWhite:
        return Colors.black87;
      case Themes.yellowAccentDarkGrey:
        return Colors.white70;
    }
  }

  Color get restActiveColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.blue;
      case Themes.lightBlueWhite:
        return Colors.greenAccent.shade400;
      case Themes.yellowAccentDarkGrey:
        return Colors.blueAccent;
    }
  }
  Color get restColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.blue.shade900;
      case Themes.lightBlueWhite:
        return Colors.green.shade800;
      case Themes.yellowAccentDarkGrey:
        return Colors.lightBlue.shade100;
    }
  }

  Color get activeColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.redAccent;
      case Themes.lightBlueWhite:
        return Colors.lightBlueAccent;
      case Themes.yellowAccentDarkGrey:
        return Colors.limeAccent;
    }
  }

  Color get inactiveColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.grey.shade300;
      case Themes.lightBlueWhite:
        return Colors.grey.shade300;
      case Themes.yellowAccentDarkGrey:
        return Colors.grey.shade600;
    }
  }
  Color get inactiveOverlayColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.black12;
      case Themes.lightBlueWhite:
        return Colors.black12;
      case Themes.yellowAccentDarkGrey:
        return Colors.white10;
    }
  }
  Color get onInactiveColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.grey;
      case Themes.lightBlueWhite:
        return Colors.grey;
      case Themes.yellowAccentDarkGrey:
        return Colors.black87;
    }
  }

  Color get unrecommendedColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.grey.shade500;
      case Themes.lightBlueWhite:
        return Colors.grey.shade500;
      case Themes.yellowAccentDarkGrey:
        return Colors.grey.shade300;
    }
  }
  Color get unrecommendedOverlayColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.black12;
      case Themes.lightBlueWhite:
        return Colors.black12;
      case Themes.yellowAccentDarkGrey:
        return Colors.white10;
    }
  }
  Color get onUnrecommendedColor {
    switch (this) {
      case Themes.darkRedWhite:
        return Colors.white;
      case Themes.lightBlueWhite:
        return Colors.white;
      case Themes.yellowAccentDarkGrey:
        return Colors.black;
    }
  }
}