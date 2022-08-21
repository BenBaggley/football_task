part of 'app.dart';

/// App theme
ThemeData buildTheme(ThemeData base) {
  return base.copyWith(
    textTheme: GoogleFonts.barlowTextTheme(base.textTheme),
    colorScheme: base.colorScheme.copyWith(
      primary: kPrimaryColor,
      background: base.brightness == Brightness.light
          ? Colors.white
          : kSurfaceDarkColor,
      surface: base.brightness == Brightness.light
          ? Colors.white
          : kSurfaceDarkColor,
    ),
    scaffoldBackgroundColor: base.brightness == Brightness.light
        ? base.scaffoldBackgroundColor
        : kPrimaryDarkColor,
    cardColor: base.brightness == Brightness.light
        ? base.cardColor
        : kSurfaceDarkColor,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: kPrimaryColor,
    ),
  );
}
