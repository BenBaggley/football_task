part of 'app.dart';

/// App theme
ThemeData buildTheme(ThemeData base) {
  return base.copyWith(
    textTheme: GoogleFonts.barlowTextTheme(base.textTheme),
    colorScheme: base.colorScheme.copyWith(
      primary: kPrimaryColor,
      background:
          base.brightness == Brightness.light ? Colors.white : Colors.black,
      surface:
          base.brightness == Brightness.light ? Colors.white : Colors.black,
    ),
    scaffoldBackgroundColor: base.brightness == Brightness.light
        ? base.scaffoldBackgroundColor
        : kPrimaryDarkColor,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: kPrimaryColor,
    ),
  );
}
