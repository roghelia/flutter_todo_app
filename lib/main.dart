import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/pages/todo.dart';

void main() async {
  Hive.initFlutter();
  // ignore: unused_local_variable
  var box = await Hive.openBox('to-do-box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Todo(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
