import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
  String scaned_cur = '?';
  String scaned_price = '';
  String symbol = '';
  List<String> cur_list = ['KRW', 'USD', 'CNY', 'JPY'];
  final StreamController<String> controller_stream = StreamController<String>();
  void setText(value) {
    controller_stream.add(value);
  }

  @override
  void dispose() {
    controller_stream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(child: Text('실시간 환율 조회')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.autorenew_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[850],
                ),
                title: Text('Home'),
                onTap: () {
                  print('Home is clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('Setting'),
                onTap: () {
                  print('Setting is clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Colors.grey[850],
                ),
                title: Text('Q&A'),
                onTap: () {
                  print('Q&A is clicked');
                },
                trailing: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.deepPurpleAccent,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.sort_by_alpha,
                  color: Colors.white,),
                onPressed: () {
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          null;
        },
        backgroundColor: Colors.deepPurpleAccent,
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
                        if (snapshot.data != null) {
                          String temp = '';
                          if (snapshot.data!.contains(r'$')) {
                            scaned_cur = 'USD';
                            symbol = r'$';
                            cur_list.remove('USD');
                          }
                          else if (snapshot.data!.contains('円') || snapshot.data!.contains('¥')) {
                            scaned_cur = 'JPY';
                            symbol = '¥';
                            cur_list.remove('JPY');
                          }
                          else if (snapshot.data!.contains('元') || snapshot.data!.contains('¥')) {
                            scaned_cur = 'CNY';
                            symbol = '¥';
                            cur_list.remove('CNY');
                          }
                          else if (snapshot.data!.contains('원') || snapshot.data!.contains('w')) {
                            scaned_cur = 'KRW';
                            symbol = '₩';
                            cur_list.remove('KRW');
                          }
                          else {
                            scaned_cur = 'Unknown';
                            cur_list = ['KRW', 'USD', 'CNY', 'JPY'];
                          }
                          for (int i=0; i<snapshot.data!.length; i++) {
                            if (int.tryParse(snapshot.data![i]) != null || snapshot.data![i] == '.' && temp.length != 0) temp = temp+snapshot.data![i];
                            else if (snapshot.data![i] == ',') continue;
                            if (int.tryParse(snapshot.data![i]) == null && temp.length != 0) break;
                          }
                          if (temp.isEmpty) {
                            scaned_price = '';
                            scaned_cur = '?';
                          }
                          else scaned_price = symbol + ' ' + temp;
                        }
                        return Result(text: snapshot.data != null ? snapshot.data! : '', cur: scaned_cur, price: scaned_price);
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
                              children: [
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cur_list.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      child: Text(cur_list[index]),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10,),
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
  const Result({Key? key,required this.text, required this.cur, required this.price}) : super(key: key);
  final String text;
  final String cur;
  final String price;

  @override
  Widget build(BuildContext context) {
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
                    cur != '?' ?
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
                Text(
                  price,
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
