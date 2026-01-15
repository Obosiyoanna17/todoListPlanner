import 'package:my_todo_app/screens/intro_screen.dart';
import 'package:my_todo_app/screens/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // database is saved in the hive_box folder
  await Hive.initFlutter("hive_box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Todo Planner App',
      theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
        primarySwatch: Colors.blue,
      ),

      initialRoute: 'intro',
      routes: {
        'intro': (content) => const IntroScreen(),
        'tasks': (content) => const TasksPage()
  },

      home: const IntroScreen(),
    );
  }
}

