import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
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

  @override
  void check_bool() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('bool') == false) {
      prefs.setBool('bool', false);
    }
    if (prefs.getBool('bool') == false) {
      getprice();
      check = false;
    }
    else {
      getprice_offline();
      check = true;
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

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  /*
  오프라인에서 환율 테스트용 함수
   */
  void getprice_offline() {
    cur_list.add('KRW');
    cur_rate.add(1);
    cur_list.add('CNY');
    cur_rate.add(184);
    cur_list.add('USD');
    cur_rate.add(1170);
    cur_list.add('JPY');
    cur_rate.add(9.5);
    print('***오프라인***');
    print(cur_list);
    print(cur_rate);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
      return HomePage(cur_name: cur_list, cur_rate: cur_rate, date: formatDate, check: check,);
    }), (route) => false);
  }

  void getprice() async {
    int cnt = 0;
    Network network = Network('https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=' + api_keys + '&searchdate=' + formatDate + '&data=AP01');
    var Data = await network.getData();
    //if (Data.length == 0) print('data is null');
    while (Data.length == 0) {
      now = now.subtract(Duration(days:1));
      formatDate = DateFormat('yyyyMMdd').format(now);
      network = Network('https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=' + api_keys + '&searchdate=' + formatDate + '&data=AP01');
      Data = await network.getData();
      print(Data);
      cnt++;
      if (cnt == 10) break;
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
      return HomePage(cur_name: cur_list, cur_rate: cur_rate, date: formatDate, check: check,);
    }), (route) => false);
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