import 'package:daily_planner/screens/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:daily_planner/screens/intro_page.dart';


void main() async{
    await Hive.initFlutter("hive_box");
    runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
     initialRoute: 'intro',
      routes: {
        'intro': (context) => IntroPage(),
        'tasks': (context) => TasksPage(),
      }
    );
  }
}

