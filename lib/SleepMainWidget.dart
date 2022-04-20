import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gosleep_remote_project/GosleepProvider.dart';
import 'style/GosleepColorPalette.dart';
import 'style/GosleepFontStyle.dart';
import 'GosleepBleService.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SleepMainWidget extends StatefulWidget{
  const SleepMainWidget({Key? key}) : super(key: key);

  @override
  State<SleepMainWidget> createState() => _SleepMainWidget();
}

class _SleepMainWidget extends State<SleepMainWidget>{
  late GosleepBleService mBle;

  @override
  void initState() {
    mBle = GosleepBleService(context);
    mBle.initBle();
    mBle.startScan();
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
          child:Stack(
            children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  GosleepTitle(),
                  GosleepBody()
                ],
              ),
              Positioned(
                bottom: 30,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    padding: const EdgeInsets.only(right: 25,left:25),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                          return context.watch<GosleepProvider>().state == 2 ? GosleepColors.blue_40 :GosleepColors.gray_80;
                        }),
                      ),
                      child: Text(
                          context.watch<GosleepProvider>().state == 2? '수면 모드 시작' :'고슬립을 활성화 중입니다..',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "SpoqaHanSansNeo",
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.0,
                            color: GosleepColors.yellow_70
                          )),
                    ),
                  )
                )
              )
            ]
          )
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
          Stack(
            children: [
              SvgPicture.asset(
                'assets/images/ic_logo_40.svg',
                width: 40,
                height: 40,
                color: Colors.white,
              ),
              Center(
                child: CircularProgressIndicator(
                  color: context.watch<GosleepProvider>().state == 1 ? GosleepColors.blue_20 :Colors.transparent,
                ),
              )
            ],
          ),
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

  int selectedAir = 1;
  List<String> airList = ['강하게','보통','약하게'];

  int selectedSound = 2;
  List<String> soundList = ['4','3','2','1','0'];

  @override
  void initState() {
    super.initState();
    // TODO selected 값 초기화 (sharedPreference)
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
                    child:Text('바람과 빛으로 깨우기',style: GosleepFontStyles.title3Medium_KOR,)
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
                  Text('슬립 에어 세기',style: GosleepFontStyles.title3Medium_KOR,),
                ],
              ) ,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child:Row(
                  children: [for(int i=0;i<3;i++)
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: customRadio1(airList[i], i),),
                    )
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child:Row(
                children: const [
                  Text('수면 음악 볼륨',style: GosleepFontStyles.title3Medium_KOR,),
                ],
              ) ,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child:Row(
                  children: [for(int i=0;i<5;i++)
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: customRadio2(soundList[i], i),),
                    )
                  ],
                )
            )
          ],
        ),
      )
    );
  }

  Widget customRadio1(String txt, int index){
    return OutlinedButton(
      onPressed: () {
        setState((){
          selectedAir = index;
        });
      },
      child: Text(
        txt,
        style: const TextStyle(
            color: GosleepColors.blue_40,
            fontFamily: 'SpoqaHanSansNeo',
            fontSize: 16
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          return selectedAir == index ? GosleepColors.blue_10 : Colors.transparent;
        }),
        side:MaterialStateProperty.resolveWith((states) {
          return const BorderSide(color: GosleepColors.blue_40, width: 1);
        }),
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(18);
        }),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
        }),
      ),
    );
  }

  Widget customRadio2(String txt, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedSound = index;
        });
      },
      child: Text(
        txt,
        style: const TextStyle(
            color: GosleepColors.blue_40,
            fontFamily: 'SpoqaHanSansNeo',
            fontSize: 16
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          return selectedSound == index ? GosleepColors.blue_10 : Colors.transparent;
        }),
        side: MaterialStateProperty.resolveWith((states) {
          return const BorderSide(color: GosleepColors.blue_40, width: 1);
        }),
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
          return const EdgeInsets.all(18);
        }),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10));
        }),
      ),
    );
  }
}
