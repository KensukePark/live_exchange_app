import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:live_currency_rate_app/screens/rate_page.dart';
import 'error_page_2.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  List<String> result = []; //환율 정보 저장용 리스트
  List<String> img_src = []; //환율 차트 url 저장용 리스트
  String date = ''; //환율 정보 업데이트 일자

  void test() async {
    http.Response response = await http.get(Uri.parse(
        'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%ED%99%98%EC%9C%A8'),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        });
    var document = parse(response.body);
    var li = document
        ?.querySelectorAll('li[class="csp"]');
    var li_d = document
        ?.querySelectorAll('li[class="csd"]');

    //환율 차트 사진의 url을 불러오는 코드
    var img = document?.querySelectorAll('span[class="img_bx"]');

    for (int k=0; k<6; k++) {
      var temp = '';
      int idx = img![k].innerHtml.indexOf('"');
      for (int l=idx+1; l<img![k].innerHtml.length; l++) {
        if (img![k].innerHtml[l] == '"') break;
        temp = temp + img![k].innerHtml[l];
      }
      img_src.add(temp);
    }
    print(img_src);
    //환율 차트 기능 end

    //환율 업데이트 날자를 불러오는 코드
    var date_i = document?.querySelector('span[class="update_info"]');
    date = date_i!.text.split(' ')[0].toString().substring(0,date_i!.text.split(' ')[0].toString().length-1) + ' ' + date_i!.text.split(' ')[1].toString();
    print(date);
    //업데이트 날자 end


    //환율 정보를 불러오는 코드
    for (int n=0; n<3; n++) {
      var temp = '';
      for (int i=0; i<li![n].text.length; i++) {
        if (li[n].text[i] == ' ') {
          if (temp != '') {
            if (temp == 'JPY') continue;
            else {
              result.add(temp);
              temp = '';
            }
          }
        }
        else {
          temp = temp + li[n].text[i].toString();
        }
      }
      temp = '';
      for (int i=0; i<li_d![n].text.length; i++) {
        if (li_d[n].text[i] == ' ') {
          if (temp != '') {
            if (temp == 'JPY') temp = temp + ' ';
            else {
              result.add(temp);
              temp = '';
            }
          }
        }
        else {
          temp = temp + li_d[n].text[i].toString();
        }
      }
    }
    /*
    for (int n=0; n<3; n++) {
      var temp = '';
      for (int i=0; i<li_d![n].text.length; i++) {
        if (li_d[n].text[i] == ' ') {
          if (temp != '') {
            if (temp == 'JPY') temp = temp + ' ';
            else {
              result.add(temp);
              temp = '';
            }
          }
        }
        else {
          temp = temp + li_d[n].text[i].toString();
        }
      }
    }

     */
    print(result);
    //환율 정보 end

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RatePage(result: result, img: img_src, date: date,);
        },
      ),
    );
  }

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
      test();
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
