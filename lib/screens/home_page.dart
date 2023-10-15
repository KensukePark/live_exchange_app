import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:intl/intl.dart';
import 'package:live_currency_rate_app/screens/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.cur_name, required this.cur_rate, required this.date, required this.check}) : super(key: key);
  final List<String> cur_name;
  final List<num> cur_rate;
  final String date;
  final bool check;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
  String scaned_cur = '?';
  String scaned_price = '';
  String symbol = '';
  num price = 0;
  List<String> cur_list = ['KRW', 'USD', 'CNY', 'JPY'];
  List<String> sym_list = ['원', '달러', '위안' , '엔'];
  var now = new DateTime.now().subtract(Duration(days:1));
  String TargetDate = '';
  NumberFormat f = NumberFormat('#,###');
  late bool check_type;
  Map<String, Color> color_list = {
    'KRW': Color(0xffffdddd),
    'USD': Color(0xffffffdd),
    'CNY': Color(0xffddffdd),
    'JPY': Color(0xffddddff),
  };
  final StreamController<String> controller_stream = StreamController<String>.broadcast();

  void setText(value) {
    controller_stream.add(value);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TargetDate = widget.date.substring(0,4) + '년 ' + widget.date.substring(4,6) + '월 ' + widget.date.substring(6) + '일 환율 기준';
    check_type = widget.check;
    print(check_type);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffFEFAF8),
        title: Center(
          child: Text(
            '실시간 환율 조회',
            style: TextStyle(
              color: Colors.black
            ),
          )
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.autorenew_rounded,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.currency_exchange,
                    size: 32,
                  ),
                  title: Text(
                    '현재 환율',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  minLeadingWidth : 10,
                ),
                ListTile(
                  leading: Icon(
                      Icons.cloud_off,
                      size: 32
                  ),
                  title: Text(
                    '오프라인 모드',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  trailing: Switch(
                    value: check_type,
                    activeColor: CupertinoColors.activeBlue,
                    onChanged: (bool value) async {
                      setState(() {
                        check_type = value;
                      });
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool('bool', value);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                        return Loading();
                      }), (route) => false);
                    },
                  ),
                  minLeadingWidth : 10,
                )
              ],
            ),
            Expanded(
                child: child)
          ]
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xffFEFAF8),
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.sort_by_alpha,
                  color: Colors.black,
                ),
                onPressed: () {
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          null;
        },
        backgroundColor: Color(0xffFEFAF8),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
          child: Container(
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
            child: Stack(
              children: <Widget>[
                ScalableOCR(
                  paintboxCustom: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4.0
                    ..color = const Color.fromARGB(153, 255, 160, 160),
                  boxLeftOff: 5,
                  boxRightOff: 5,
                  boxBottomOff: 6,
                  boxTopOff: 6,
                  boxHeight: MediaQuery.of(context).size.height / 5,
                  getRawData: (value) {
                    inspect(value);
                  },
                  getScannedText: (value) {
                    setText(value);
                  }
                ),
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5 + 45,),
                    StreamBuilder<String>(
                      stream: controller_stream.stream,
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        bool _check = false;
                        //인식 결과가 있다면 체크 시작.
                        //List remove 방식의 처리에서 버그 발견, 방식을 변경하였음
                        //2023.10.10
                        if (snapshot.data != null) {
                          String temp = '';
                          //달러 기호 감지
                          if (snapshot.data!.contains(r'$')) {
                            scaned_cur = 'USD';
                            symbol = '달러';
                            //cur_list.remove('USD');
                            //sym_list.remove('달러');
                            cur_list = ['KRW', 'CNY', 'JPY'];
                            sym_list = ['원', '위안' , '엔'];
                          }
                          //엔 한자, 엔 기호 감지
                          else if (snapshot.data!.contains('円') || snapshot.data!.contains('¥')) {
                            scaned_cur = 'JPY';
                            symbol = '엔';
                            //cur_list.remove('JPY');
                            //sym_list.remove('엔');
                            cur_list = ['KRW', 'USD', 'CNY'];
                            sym_list = ['원', '달러', '위안'];
                          }
                          //위안 한자, 위안 기호 감지
                          else if (snapshot.data!.contains('元') || snapshot.data!.contains('¥')) {
                            scaned_cur = 'CNY';
                            symbol = '위안';
                            //cur_list.remove('CNY');
                            //sym_list.remove('위안');
                            cur_list = ['KRW', 'USD', 'JPY'];
                            sym_list = ['원', '달러', '엔'];
                          }
                          //원, 원기호 감지
                          else if (snapshot.data!.contains('원') || snapshot.data!.contains('w')  || snapshot.data!.contains('￦') || snapshot.data!.contains('₩')) {
                            scaned_cur = 'KRW';
                            symbol = '원';
                            //cur_list.remove('KRW');
                            //sym_list.remove('원');
                            cur_list = ['USD', 'CNY', 'JPY'];
                            sym_list = ['달러', '위안' , '엔'];
                          }

                          //통화 감지를 못했을 경우 일단 unknown 처리
                          else {
                            scaned_cur = 'Unknown';
                            symbol = '';
                            cur_list = ['KRW', 'USD', 'CNY', 'JPY'];
                            sym_list = ['원', '달러', '위안' , '엔'];
                          }

                          //숫자 감지 시작
                          for (int i=0; i<snapshot.data!.length; i++) {
                            if (int.tryParse(snapshot.data![i]) != null || snapshot.data![i] == '.' && temp.length != 0) temp = temp+snapshot.data![i];
                            else if (snapshot.data![i] == ',') continue;
                            if (int.tryParse(snapshot.data![i]) == null && temp.length != 0) break;
                          }

                          //숫자 감지 실패
                          if (temp.isEmpty) {
                            scaned_price = '';
                            scaned_cur = '?';
                            symbol = '';
                            cur_list = ['KRW', 'USD', 'CNY', 'JPY'];
                            sym_list = ['원', '달러', '위안' , '엔'];
                            _check = false;
                          }
                          //숫자 감지 했다면 값 전달
                          else {
                            price = num.parse(temp);
                            NumberFormat f = NumberFormat('#,###');
                            scaned_price = f.format(price) + ' ' + symbol;
                            _check = true;
                          }
                        }
                        //인식 결과가 없을 때
                        else {
                          scaned_price = '';
                          scaned_cur = '?';
                          symbol = '';
                          cur_list = ['KRW', 'USD', 'CNY', 'JPY'];
                          sym_list = ['원', '달러', '위안' , '엔'];
                          _check = false;
                        }
                        return Result(text: snapshot.data != null ? snapshot.data! : '', cur: scaned_cur, price: scaned_price, check: _check);
                      },
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 60,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 45),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0,
                                  offset: const Offset(0,7),
                                )
                              ]
                          ),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      StreamBuilder<String>(
                                        stream: controller_stream.stream,
                                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                          return Cur_price(color_list: color_list, cur_rate: widget.cur_rate, cur_name: widget.cur_name, cur_list: cur_list, scaned_cur: scaned_cur, sym_list: sym_list, price: price);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(TargetDate),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({Key? key,required this.text, required this.cur, required this.price, required this.check}) : super(key: key);
  final String text;
  final String cur;
  final String price;
  final bool check;

  @override
  Widget build(BuildContext context) {

    NumberFormat f = NumberFormat('#,###');
    return Column(
      children: [
        //스캔 결과 박스
        Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0,7),
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '인식 결과',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    check == true ?
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffddf6ff),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          cur,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
                check == true?
                Text(
                  price,
                  style: TextStyle(
                      fontSize: 16
                  ),
                ) : Container(),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}

class Cur_price extends StatelessWidget {
  const Cur_price({Key? key,required this.cur_rate, required this.cur_name, required this.cur_list, required this.scaned_cur, required this.price, required this.color_list, required this.sym_list}) : super(key: key);
  final List<num> cur_rate;
  final List<String> cur_name;
  final List<String> cur_list;
  final String scaned_cur;
  final num price;
  final Map<String, Color> color_list;
  final List<String> sym_list;
  @override
  Widget build(BuildContext context) {
    NumberFormat f = NumberFormat('#,###');
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cur_list.length,
      itemBuilder: (BuildContext context, int index) {
        String temp_price = '';
        if (scaned_cur == 'KRW') {
          num temp_cal = price / cur_rate[cur_name.indexOf(cur_list[index])];
          if (sym_list[index] == '달러') {
            temp_price = f.format(int.parse(temp_cal.toStringAsFixed(0))) + temp_cal.toStringAsFixed(2).substring(temp_cal.toStringAsFixed(2).length-3);
          }
          else temp_price = f.format(int.parse(temp_cal.toStringAsFixed(0)));
        }
        else if (scaned_cur == 'JPY' || scaned_cur == 'USD' || scaned_cur == 'CNY') {
          num temp_cal = cur_rate[cur_name.indexOf(scaned_cur)] * price / cur_rate[cur_name.indexOf(cur_list[index])];
          if (sym_list[index] == '달러') {
            temp_price = f.format(int.parse(temp_cal.toStringAsFixed(0))) + temp_cal.toStringAsFixed(2).substring(temp_cal.toStringAsFixed(2).length-3);
          }
          else temp_price = f.format(int.parse(temp_cal.toStringAsFixed(0)));
        }
        return Container(
          padding: EdgeInsets.fromLTRB(3,7, 3,7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color_list[cur_list[index]],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width/6.5,
                  padding: EdgeInsets.fromLTRB(10, 17, 10, 17),
                  child: Center(
                    child: Text(
                      cur_list[index],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                temp_price + ' ' + sym_list[index],
              )
            ],
          ),
        );
      },
    );
  }
}
