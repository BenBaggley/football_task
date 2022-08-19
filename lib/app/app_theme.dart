part of 'app.dart';

ThemeData buildTheme(ThemeData base) {
  return base.copyWith(
    textTheme: GoogleFonts.barlowTextTheme(base.textTheme),
    colorScheme: base.colorScheme.copyWith(
      primary: kPrimaryColor,
    ),
    scaffoldBackgroundColor: base.brightness == Brightness.light
        ? base.scaffoldBackgroundColor
        : kPrimaryDarkColor,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: kPrimaryColor,
    ),
  );
}
