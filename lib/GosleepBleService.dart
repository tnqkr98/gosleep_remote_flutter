import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter_blue/flutter_blue.dart';

class GosleepBleService {     // Android의 서비스인 척. TODO - SingleTone

  FlutterBlue flutterBlue = FlutterBlue.instance;

  bool _isScanning = false;
  List<ScanResult> scanResultList = [];

  // State
  String targetDeviceName = 'gosleep';
  var gosleepDevice = null;
  int connectionState = 0;      // 0 : 연결안됨, 1: 연결중, 2: 연결완료

  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;   // 디바이스 연결 상태
  StreamSubscription<BluetoothDeviceState>? _stateListener;   // 디바이스와 연결 상태 구독하는 리스너 (화면 종료시 리스너 해제)

  void initBle(){
    flutterBlue.isScanning.listen((isScanning) {
      _isScanning = isScanning;
    });
  }

  startScan() async {
    if(!_isScanning){
      scanResultList.clear();

      flutterBlue.startScan(timeout: const Duration(seconds: 4));   // 4초간 스캔 ON
      flutterBlue.scanResults.listen((results) {
        // 스캔 결과 콜백
        for (var element in results) {
          if(element.device.name == targetDeviceName){
            if(scanResultList.indexWhere((e)=> e.device.id == element.device.id) < 0){  // 등록안된 gosleep 발견시 리스트추가
              scanResultList.add(element);

              developer.log('gosleep log',name: '고슬립 탐색 성공 : ' + element.device.id.toString());
              gosleepDevice = element.device;
              connectionState = 1;
              connectGosleep();
              break;
            }
          }
        }

      });
    }
  }

  stopScan(){
    if(_isScanning) {
      flutterBlue.stopScan();
    }
  }

  connectGosleep(){
    if(gosleepDevice != null) {
      _stateListener = gosleepDevice.state.listen((event) {
        if (deviceState == event) {
          return; // 상태가 동일하다면 무시
        }
        setBleConnectionState(event);
      });

      connect();
    }
  }

  disconnectGosleep(){   // 화면 종료시 리스너 및 device 연결 해제
    try {
      connectionState = 0;
      gosleepDevice.disconnect();
    }
    catch(e) {}
  }

  Future<bool> connect() async {
    Future<bool>? returnValue;

    await gosleepDevice.connect(autoConnect: false)
        .timeout(const Duration(milliseconds: 10000), onTimeout: () {
      //타임아웃 발생
      returnValue = Future.value(false);
      developer.log('gosleep log',name: '고슬립 연결 실패 : timeout');

      setBleConnectionState(BluetoothDeviceState.disconnected);
    }).then((data) {
      if (returnValue == null) {
        developer.log('gosleep log',name: '고슬립 연결 성공');
        returnValue = Future.value(true);
      }
    });

    return returnValue ?? Future.value(false);
  }

  setBleConnectionState(BluetoothDeviceState event) {
    switch (event) {
      case BluetoothDeviceState.disconnected:
        connectionState = 0;
        break;
      case BluetoothDeviceState.disconnecting:
        connectionState = 1;
        break;
      case BluetoothDeviceState.connected:
        connectionState = 2;
        break;
      case BluetoothDeviceState.connecting:
        connectionState = 1;
        break;
    }
    //이전 상태 이벤트 저장
    deviceState = event;
  }
}