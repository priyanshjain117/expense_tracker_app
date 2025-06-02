import 'package:flutter/material.dart';
import 'package:expense_tracker_app/widgets/expenses_app.dart';
// import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFFEC674),
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFFBAB57), //same seed
  brightness: Brightness.dark,
).copyWith(
  secondary: const Color(0xFFFEC674), //dark background
  surface: const Color(0xFF222222),
  onSurface: const Color(0xFFFFF3E2), //light text for dark surfaces
);

void main() {
  // //making sure binding all the widgets like orientaion is fixed before rendering...
  // WidgetsFlutterBinding.ensureInitialized();
  // //lock orientaion in app
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp]
  // ).then((fn){
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.primary,
            foregroundColor: kDarkColorScheme.onSecondary,
          ),
          scaffoldBackgroundColor: const Color(0xFF222222),
          cardTheme: CardTheme().copyWith(
            // ignore: deprecated_member_use
            color: kDarkColorScheme.primary,
            margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
          ),
          snackBarTheme: SnackBarThemeData().copyWith(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10,
            ),
            backgroundColor: const Color.fromARGB(255, 244, 181, 93),
            actionTextColor: const Color.fromARGB(255, 249, 17, 0),
            disabledActionTextColor: const Color.fromARGB(208, 69, 67, 67),
            contentTextStyle: TextStyle(
              color: const Color.fromARGB(208, 69, 67, 67),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          textTheme: TextTheme().copyWith(
            // appbar
            titleLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            // dropdown
            titleMedium: TextStyle(
              color: kDarkColorScheme.inverseSurface,
            ),
            titleSmall: TextStyle(
              color: Colors.red,
            ),
            // body text
            bodyMedium: TextStyle(
              color: kDarkColorScheme.onSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: IconThemeData().copyWith(
            color: kDarkColorScheme.onSecondary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.elliptical(8, 7),
                ),
              ),
            ),
          )),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.inversePrimary,
          foregroundColor: const Color.fromARGB(167, 0, 0, 0),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF3E2),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.inversePrimary,
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
        ),
        snackBarTheme: SnackBarThemeData().copyWith(
          insetPadding: EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 10,
          ),
          backgroundColor: const Color.fromARGB(255, 247, 209, 156),
          actionTextColor: const Color.fromARGB(224, 235, 41, 41),
          disabledActionTextColor: const Color.fromARGB(208, 69, 67, 67),
          contentTextStyle: TextStyle(
            color: const Color.fromARGB(208, 69, 67, 67),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(8, 7),
              ),
            ),
          ),
        ),
        // text theme
        textTheme: TextTheme().copyWith(
          // appbar
          titleLarge: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          // dropdown
          titleMedium: TextStyle(
            color: kColorScheme.inverseSurface,
          ),
          titleSmall: TextStyle(
            color: Colors.red,
          ),
          // body text
          bodyMedium: TextStyle(
            // color: kColorScheme.inverseSurface,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData().copyWith(
          color: kColorScheme.onSecondary,
        ),
      ),
      home: ExpensesApp(),
      debugShowCheckedModeBanner: true,
    ),
  );
  // );
}
