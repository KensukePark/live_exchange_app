/*
TestPage 는 웹 크롤링 기능을 테스트 하기 위한 페이지.
실제 앱 구동과 연관이 없음.
 */

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  void test() async {
    http.Response response = await http.get(Uri.parse(
        'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%ED%99%98%EC%9C%A8'),
    headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    var document = parse(response.body);
    print(document.getElementsByClassName('list_item')[1].text);
    for (int i=0; i<5; i++) {
      print(response.body.substring(1000*i,1000*(i+1)));
    }
    print('***');
    var ul = document
        ?.querySelectorAll('section[class="sc_new cs_nexchangerate"]');
    print(ul);

    print('***');
    var ul2 = document
        ?.querySelectorAll('ul[class="list_item"]');
    print(ul2?[0].text);
    print(ul2?[1].text);

    print('***');
    var li = document
        ?.querySelectorAll('li[class="csp"]');
    var li_d = document
        ?.querySelectorAll('li[class="csd"]');

    //환율 차트 사진의 url을 불러오는 코드
    var img = document?.querySelectorAll('span[class="img_bx"]');
    List<String> img_src = [];
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
    var date = document?.querySelector('span[class="update_info"]');
    print(date?.text);
    print(date!.text.split(' ')[0].toString().substring(0,date!.text.split(' ')[0].toString().length-1) + ' ' + date!.text.split(' ')[1].toString());
    //업데이트 날자 end

    //환율 정보를 불러오는 코드
    List<String> result = [];
    for (int n=0; n<3; n++) {
      var temp = '';
      for (int i=0; i<li![n].text.length; i++) {
        if (li[n].text[i] == ' ') {
          if (temp != '') {
            result.add(temp);
            temp = '';
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
            result.add(temp);
            temp = '';
          }
        }
        else {
          temp = temp + li_d[n].text[i].toString();
        }
      }
    }
    print(result);
    //환율 정보 end

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
