import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('hi'),
              Text('hi'),
              Text('hd'),
              Text('hi'),
              SvgPicture.asset(
                'assets/images/ic_logo_40.svg',
                width: 40,
                height: 40
              ),
            ],
          ),
        ),
      ),
    );
  }
}