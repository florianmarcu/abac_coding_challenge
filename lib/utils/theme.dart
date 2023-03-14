import 'package:flutter/material.dart';

Color _tertiaryColor = Color(0xFF3E363F);
Color _highlightColor = Colors.white;
Color _primaryColor = Color(0xFF2292A4);
Color _secondaryColor = Color(0xFFDD403A);
/// The color of the text, used in TextTheme
Color _textColor = _tertiaryColor;
// Color _textColor = Colors.black;
// Color _splashColor = Color(0xFF95b1db);
Color _splashColor = Colors.grey[300]!;
Color _canvasColor = Color(0xFFF5EFED);

ThemeData theme(BuildContext context){
  return ThemeData(
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