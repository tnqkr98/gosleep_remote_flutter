import 'package:flutter/material.dart';

class SleepMainWidget extends StatefulWidget{
  @override
  State<SleepMainWidget> createState() => _SleepMainWidget();
}

class _SleepMainWidget extends State<SleepMainWidget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1d2d5f),Color(0xff0a0d2c)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
      ),
    );
  }
}