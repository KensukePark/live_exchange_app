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
    var li = document
        ?.querySelectorAll('li[class="csp"]');
    //li?.forEach((element) {print(element.text);});
    var li_d = document
        ?.querySelectorAll('li[class="csd"]');
    var date = document?.querySelector('span[class="update_info"]');
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
    /*
    print(date?.text);
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
    }
    for (int n=0; n<3; n++) {
      var temp = '';
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

     */

    /*
    var name = document
        ?.querySelectorAll('span[class="name"]');
    name?.forEach((element) {print(element.text);});
    var price = document
        ?.querySelectorAll('span[class="spt_con dw"]');
    price?.forEach((element) {print(element.text);});
    print(price);
    var change = document
        ?.querySelectorAll('span[class="ico"]');
    change?.forEach((element) {print(element.text);});
    print(change);

     */

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