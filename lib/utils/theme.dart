import 'package:flutter/material.dart';

Color _tertiaryColor = Color(0xFF3E363F);
Color _highlightColor = Colors.white;
Color _primaryColor = Color(0xFF821616);
Color _secondaryColor = Color(0xFF1a871a);


/// Theme of the app
/// Defined as a function in order to use the BuildContext. Used to ignore the text scale factor chosen by the user (avoids UI problems short-term)
ThemeData theme(BuildContext context){
  return ThemeData(
    highlightColor: _highlightColor,
    textTheme: _textTheme(context),
    colorScheme: _colorScheme
  );
}

TextTheme _textTheme(BuildContext context){
  return TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16 * (1/MediaQuery.textScaleFactorOf(context))
    )
  );
}

ColorScheme _colorScheme = ColorScheme(
  primary: _primaryColor,
  secondary: _secondaryColor,
  tertiary: _tertiaryColor, 
  background: _highlightColor, 
  brightness: Brightness.light, 
  error: Colors.red, 
  onBackground: Colors.black, 
  onError: _highlightColor, 
  onPrimary: Colors.black, 
  onSecondary: _highlightColor, 
  onTertiary: _highlightColor,
  onSurface: Colors.black, 
  surface: _primaryColor,
);