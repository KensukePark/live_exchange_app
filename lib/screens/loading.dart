import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:live_currency_rate_app/screens/error_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network.dart';
import '../screens/home_page.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String file_loc = 'assets/keys.txt';
  String api_keys = '';
  late List<String> cur_list = [];
  late List<num> cur_rate = [];
  var now = DateTime.now();
  String formatDate = '';
  late bool check;
  late bool check_custom;
  late List<String> temp_list;
  @override

  /*
  check_bool 함수:
  로컬 스토리지에 저장된 bool값들을 체크하는 함수
  */
  void check_bool() async {
    var prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    if (prefs.containsKey('bool') == false) {
      prefs.setBool('bool', false);
    }
    if (prefs.containsKey('custom_mode') == false) {
      prefs.setBool('custom_mode', false);
    }
    if (prefs.containsKey('user_rate') == false) {
      prefs.setStringList('user_rate', ['1', '200', '1200', '10']);
    }
    check_custom = prefs.getBool('custom_mode')!;
    temp_list = prefs.getStringList('user_rate')!;
    if (prefs.getBool('bool') == false) {
      getprice();
      check = false;
    }
    else {
      getprice_offline();
      check = true;
    }
  }

  /*
  네이버 환율 정보를 크롤링 하는 함수
   */

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  /*
  getprice_offline 함수:
  오프라인 모드로 환율 데이터를 갖고오는 함수
   */
  void getprice_offline() {
    //개발자가 설정한 환율 데이터값읗 환율 데이터로 사용
    if (check_custom == false) {
      cur_rate.add(1);
      cur_rate.add(180);
      cur_rate.add(1200);
      cur_rate.add(9.5);

    }
    //사용자 지정 환율 데이터값을 사용
    else {
      for (int i=0; i<4; i++) {
        cur_rate.add(num.parse(temp_list![i]));
      }
    }
    cur_list.add('KRW');
    cur_list.add('CNY');
    cur_list.add('USD');
    cur_list.add('JPY');
    print('***오프라인***');
    print(cur_list);
    print(cur_rate);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
      return HomePage(cur_name: cur_list, cur_rate: cur_rate, date: formatDate, check: check, mode_check: check_custom);
    }), (route) => false);
  }

  /*
  getprice 함수:
  실시간으로 최신 환율 데이터값을 받아와 사용
   */
  void getprice() async {
    bool check_connect = await InternetConnectionChecker().hasConnection;
    if (check_connect == true) {
      int cnt = 0;
      Network network = Network('https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=' + api_keys + '&searchdate=' + formatDate + '&data=AP01');
      var Data = await network.getData();
      print('getData 이후 확인');
      //if (Data.length == 0) print('data is null');
      while (Data.length == 0) {
        print('while 문 확인');
        now = now.subtract(Duration(days:1));
        formatDate = DateFormat('yyyyMMdd').format(now);
        network = Network('https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=' + api_keys + '&searchdate=' + formatDate + '&data=AP01');
        Data = await network.getData();
        print(Data);
        cnt++;
        if (cnt == 10) break;
      }
      if (Data.length == 0) {
        print('인터넷 연결 오류');
        print('인터넷 연결 오류');
        print('인터넷 연결 오류');
      }
      for (int i=0; i<Data.length; i++) {
        if (Data[i]['cur_unit'] == 'CNH') {
          cur_list.add('CNY');
          cur_rate.add(num.parse(Data[i]['deal_bas_r']));
        }
        else if (Data[i]['cur_unit'] == 'JPY(100)') {
          cur_list.add('JPY');
          String temp = Data[i]['deal_bas_r'];
          cur_rate.add(num.parse(temp.replaceAll(',', ''))/100);
        }
        else if (Data[i]['cur_unit'] == 'KRW') {
          cur_list.add('KRW');
          cur_rate.add(1);
        }
        else if (Data[i]['cur_unit'] == 'USD') {
          cur_list.add('USD');
          String temp = Data[i]['deal_bas_r'];
          cur_rate.add(num.parse(temp.replaceAll(',', '')));
        }
      }
      print(cur_list);
      print(cur_rate);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return HomePage(cur_name: cur_list, cur_rate: cur_rate, date: formatDate, check: check, mode_check: check_custom);
      }), (route) => false);
    }
    else {
      print('인터넷 연결 없음');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return ErrorPage();
      }), (route) => false);
    }
  }

  void initState() {
    super.initState();
    if (DateFormat('EEEE').format(now) == 'Saturday') {
      now = now.subtract(Duration(days:1));
    }
    else if (DateFormat('EEEE').format(now) == 'Sunday') {
      now = now.subtract(Duration(days:2));
    }
    formatDate = DateFormat('yyyyMMdd').format(now);
    loadAsset(file_loc).then((value) {
      setState(() {
        api_keys = value;
      });
      check_bool();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/chunsik_bg_3.jpg'), // 배경 이미지
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.dstATop
              ),
            ),
          ),
          child: Center(
              child: SpinKitRing(
                color: Colors.white,
                duration: const Duration(milliseconds:2000),
              )
          ),
        )
    );
  }
}