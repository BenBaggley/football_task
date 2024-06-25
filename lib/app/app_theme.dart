part of 'app.dart';

/// App theme
ThemeData buildTheme(ThemeData base) {
  return base.copyWith(
    textTheme: GoogleFonts.barlowTextTheme(base.textTheme),
    colorScheme: base.colorScheme.copyWith(
      primary: kPrimaryColor,
      surface: base.brightness == Brightness.light
          ? Colors.white
          : kSurfaceDarkColor,
    ),
    scaffoldBackgroundColor: base.brightness == Brightness.light
        ? base.scaffoldBackgroundColor
        : kPrimaryDarkColor,
    cardTheme: base.cardTheme.copyWith(
      color: base.brightness == Brightness.light
          ? Colors.white
          : kSurfaceDarkColor,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: kPrimaryColor,
    ),
  );
}
