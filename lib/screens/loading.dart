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
  var now = new DateTime.now().subtract(Duration(days:1));
  String formatDate = '';

  @override
  void initState() {
    super.initState();
    formatDate = DateFormat('yyyyMMdd').format(now);
    loadAsset(file_loc).then((value) {
      setState(() {
        api_keys = value;
      });
      getprice();
    });
  }
  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  void getprice() async {
    Network network = Network('https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=' + api_keys + '&searchdate=' + formatDate + '&data=AP01');
    var Data = await network.getData();
    //final prefs = await SharedPreferences.getInstance();
    //prefs.clear(); //초기화시 사용
    //key_temp = prefs.getKeys().toList();
    //key_temp.sort();
    //print(Data);
    //print(Data[0]);
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
      return HomePage(cur_name: cur_list, cur_rate: cur_rate,);
    }), (route) => false);
  } // ...getprice()

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