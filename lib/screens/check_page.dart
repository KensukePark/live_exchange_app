/*
CheckPage 는 웹 크롤링 기능을 테스트 하기 위한 페이지.
실제 앱 구동과 연관이 없음.
 */
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:live_currency_rate_app/screens/rate_page.dart';
import 'error_page_2.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  void check() async {
    bool check_connect = await InternetConnectionChecker().hasConnection;
    if (check_connect == false) {
      print('인터넷 연결 없음');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ErrorPageTwo();
          },
        ),
      );
    }
    else {
      print('hello');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return RatePage();
          },
        ),
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
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
