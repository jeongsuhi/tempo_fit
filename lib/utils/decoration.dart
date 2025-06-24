import 'package:flutter/material.dart';
import 'package:tempo_fit/values/themes.dart';

InputDecoration decorationUnderline(Themes theme, {String? label, String? hint}) {
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: theme.onBackgroundColor,
        width: 2,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: theme.onBackgroundColor,
        width: 2,
      ),
    ),
    labelText: label,
    labelStyle: TextStyle(
        color: theme.onBackgroundColor
    ),
    hintText: hint,
    hintStyle: TextStyle(
        color: theme.onBackgroundColor
    ),
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 4,
    ),
    isDense: true,
  );
}

InputDecoration decorationOutline(Themes theme, {String? label, String? hint}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: theme.onBackgroundColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: theme.onBackgroundColor,
      ),
    ),
    labelText: label,
    labelStyle: TextStyle(
        color: theme.onBackgroundColor
    ),
    hintText: hint,
    hintStyle: TextStyle(
        color: theme.onBackgroundColor
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 4,
    ),
    isDense: true,
  );
}

InputDecoration decorationFilled(Themes theme, {String? label, String? hint}) {
  return InputDecoration(
    border: null,
    filled: true,
    fillColor: theme.baseColor,
    focusColor: theme.primaryAccentBaseColor,
    labelText: label,
    labelStyle: TextStyle(
        color: theme.onBackgroundColor
    ),
    hintText: hint,
    hintStyle: TextStyle(
        color: theme.onBackgroundColor
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 4,
    ),
    isDense: true,
  );
}