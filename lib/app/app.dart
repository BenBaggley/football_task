// ignore_for_file:public_member_api_docs

import 'package:flutter/material.dart';
import 'package:football_mvp/app/app.config.dart';
import 'package:football_mvp/app/routes.dart';
import 'package:football_mvp/l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';

part 'app_theme.dart';
part 'colors.dart';

class FootballMVTApp extends StatefulWidget {
  const FootballMVTApp({Key? key}) : super(key: key);

  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    _initializeDependencies();

    runApp(const FootballMVTApp());
  }

  @override
  State<FootballMVTApp> createState() => _FootballMVTAppState();
}

class _FootballMVTAppState extends State<FootballMVTApp> {
  final router = GoRouter(routes: appRoutes);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      theme: buildTheme(ThemeData.light()),
      darkTheme: buildTheme(ThemeData.dark()),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}

@injectableInit
void _initializeDependencies() => $initGetIt(GetIt.I);
