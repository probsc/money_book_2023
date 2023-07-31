import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'consts.dart';
import 'views/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Consts.appTitle,
      // プライマリカラーのみ変更
      theme: ThemeData.light().copyWith(
        primaryColor: Consts.themeColor,
        appBarTheme:
            const AppBarTheme().copyWith(backgroundColor: Consts.themeColor),
        // Google Fonts の「M PLUS 1p」を指定
        textTheme: GoogleFonts.mPlus1TextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        // Google Fonts の「M PLUS 1p」を指定
        textTheme: GoogleFonts.mPlus1TextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      // MaterialApp で日本語対応をサポート
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // ロケールは日本を設定
      supportedLocales: const [
        Locale('ja'),
      ],
      home: const HomePage(),
    );
  }
}
