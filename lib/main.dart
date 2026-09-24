import 'package:flutter/material.dart';

import './model/meal.dart';

import 'package:my_app/view/favorites_page.dart';
import 'package:my_app/view/home_page.dart';
import 'package:my_app/view/meal_page.dart';
import 'package:my_app/view/custom_meal_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/favorites': (context) => const FavoritesPage(),
        '/custom-meals': (context) => const CustomMealPage()
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/meal') {
          final meal = settings.arguments as Meal;

          return MaterialPageRoute(builder: (context) => MealPage(meal: meal));
        }

        return null;
      },
    );
  }
}
