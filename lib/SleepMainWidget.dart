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
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [GosleepColors.blue_50,GosleepColors.blue_90],
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
                Text('   1.0.0', style: TextStyle(
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

  int selectedAir = 0;
  List<String> airList = ['강하게','보통','약하게'];
  late List<Widget> airRadioList;

  int selectedSound = 0;
  List<String> soundList = ['4','3','2','1','0'];


  @override
  void initState() {
    //for()
    // TODO - 반복문으로 라디오 버튼 위젯 초기화 리팩토링.
  }

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
            Container(
              height: MediaQuery.of(context).size.height/5,
              decoration: const BoxDecoration(
                color: Color(0x11ffffff),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0)
                )
              ),
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'SpoqaHanSansNeo'),
                  ),
                ),
                child:CupertinoDatePicker(
                  mode:CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  onDateTimeChanged: (value){}
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child:Row(
                children: const [
                  Text('슬립 에어 세기',style: GosleepTextStyles.title3Medium_KOR,),
                ],
              ) ,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child:Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: customRadio(airList[0], 0),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: customRadio(airList[1], 1),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: customRadio(airList[2], 2),
                      ),
                    ),
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child:Row(
                children: const [
                  Text('수면 음악 볼륨',style: GosleepTextStyles.title3Medium_KOR,),
                ],
              ) ,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child:Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: customRadio(airList[0], 0),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: customRadio(airList[1], 1),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: customRadio(airList[2], 2),
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      )
    );
  }

  Widget customRadio(String txt, int index){
    return OutlineButton(
      onPressed: () {
          setState((){
            selectedAir = index;
          });
        },
      padding: const EdgeInsets.all(18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(color: selectedAir == index ? Colors.cyan : Colors.grey),
      color: Colors.cyan,
      child: Text(txt,
          style: TextStyle(
              color: selectedAir == index ? Colors.cyan : Colors.grey,
              fontFamily: 'SpoqaHanSansNeo',
              fontSize: 16
          ),
        ),
      );
  }
}
