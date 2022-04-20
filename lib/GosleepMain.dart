import 'package:flutter/material.dart';
import 'package:gosleep_remote_project/GosleepProvider.dart';
import 'package:provider/provider.dart';
import 'SleepMainWidget.dart';

void main() {
  runApp(MultiProvider(providers:[
    ChangeNotifierProvider(create: (_)=> GosleepProvider())
  ],
  child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SleepMainWidget(),
    );
  }
}

