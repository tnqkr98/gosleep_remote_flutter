import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'style/GosleepColorPalette.dart';
import 'style/GosleepFontStyle.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SleepMainWidget extends StatefulWidget{
  const SleepMainWidget({Key? key}) : super(key: key);

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
            colors: [GosleepColors.blue_40,GosleepColors.blue_90],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              GosleepTitle(),
              GosleepBody()
            ],
          ),
        ),
      ),
    );
  }
}

class GosleepTitle extends StatefulWidget{
  const GosleepTitle({Key? key}) : super(key: key);

  @override
  State<GosleepTitle> createState() => _GosleepTitle();
}

class _GosleepTitle extends State<GosleepTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 55,left: 24,right: 24),
      child: Row(
        children: [
          //const Text('고슬립 리모컨', style: GosleepTextStyles.title1Bold_KOR,),
          const Text('gosleep Remote',
              style: TextStyle(fontFamily: 'Pacifico',fontSize: 26,color: GosleepColors.gray_20)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Divider(height: 10,color: Color(0x00000000),),
                Text('   1.0.6', style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto_Regular",
                    fontStyle:  FontStyle.normal,
                    fontSize: 16.0,
                    color: GosleepColors.gray_20
                )
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/images/ic_logo_40.svg',
            width: 40,
            height: 40,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class GosleepBody extends StatefulWidget{
  const GosleepBody({Key? key}) : super(key: key);

  @override
  State<GosleepBody> createState() => _GosleepBody();
}

class _GosleepBody extends State<GosleepBody> {
  var isAlarmOn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
      child: SingleChildScrollView(
        child:Column(
          children: [
            Row(
              children: [
                const Expanded(
                    child:Text('바람과 빛으로 깨우기',style: GosleepTextStyles.title3Medium_KOR,)
                ),
                CupertinoSwitch(
                  activeColor: GosleepColors.yellow_70,
                  trackColor: GosleepColors.gray_20,
                  value: isAlarmOn,
                  onChanged: (value) {
                    setState(() {
                      isAlarmOn = value;
                    });
                  }),
              ],
            ),
            const Divider(height: 15,color: Color(0x00000000),),
            SizedBox(
              height: MediaQuery.of(context).size.height/5,
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(color: Colors.white,fontSize: 25,fontFamily: 'SpoqaHanSansNeo'),
                  ),
                ),
                child:CupertinoDatePicker(
                  mode:CupertinoDatePickerMode.time,
                  backgroundColor: const Color(0x11ffffff),
                  use24hFormat: false,
                  onDateTimeChanged: (value){}
                ),
              )
            ),
            Row(
              children: const [
                Divider(height: 90,),
                Expanded(
                    child:Text('슬립 에어 세기',style: GosleepTextStyles.title3Medium_KOR,)
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
