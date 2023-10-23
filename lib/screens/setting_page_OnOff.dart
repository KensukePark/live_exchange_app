import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_currency_rate_app/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loading.dart';

class OnOffPage extends StatefulWidget {
  const OnOffPage({Key? key, required this.check, required this.check_custom, required this.user_rate}) : super(key: key);
  final bool check;
  final bool check_custom;
  final List<num> user_rate;
  @override
  State<OnOffPage> createState() => _OnOffPageState();
}

class _OnOffPageState extends State<OnOffPage> {
  late bool check_type;
  late bool check_custom;
  List<num> user_rate = [];
  @override
  void initState() {
    // TODO: implement initState
    user_rate = widget.user_rate;
    check_type = widget.check;
    check_custom = widget.check_custom;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '오프라인 모드',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Color(0xffFEFAF8),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            if (widget.check != check_type || widget.check_custom != check_custom) {
              if (check_custom == true) {
                var prefs = await SharedPreferences.getInstance();
                List<String> temp_send = [];
                user_rate.forEach((element) {temp_send.add(element.toString());});
                prefs.setStringList('user_rate', temp_send);
                print('사용자 환율 수정');
                print('사용자 환율 수정');
                print('사용자 환율 수정');
              }
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                return Loading();
              }), (route) => false);
            }
            else {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (widget.check != check_type || widget.check_custom != check_custom) {
            if (check_custom == true) {
              var prefs = await SharedPreferences.getInstance();
              List<String> temp_send = [];
              user_rate.forEach((element) {temp_send.add(element.toString());});
              prefs.setStringList('user_rate', temp_send);
              print('사용자 환율 수정');
              print('사용자 환율 수정');
              print('사용자 환율 수정');
            }
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
              return Loading();
            }), (route) => false);
          }
          else {
            Navigator.pop(context);
          }
          return Future.value(true);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              InkWell(
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '오프라인 모드',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: check_type,
                        activeColor: CupertinoColors.activeBlue,
                        onChanged: (bool value) async {
                          var prefs = await SharedPreferences.getInstance();
                          setState(() {
                            check_type = value;
                            if (check_type == false) {
                              check_custom = false;
                            }
                          });
                          prefs.setBool('bool', check_type);
                          prefs.setBool('custom_mode', false);
                        },
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  var prefs = await SharedPreferences.getInstance();
                  setState(() {
                    check_type = !check_type;
                    if (check_type == false) {
                      check_custom = false;
                    }
                  });
                  prefs.setBool('bool', check_type);
                  prefs.setBool('custom_mode', false);
                },
              ),
              SizedBox(height: 5,),
              check_type == true ?
              InkWell(
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '수동 환율 설정',
                        style: TextStyle(
                            fontSize: 16,
                            color: check_type == false ? Colors.grey : Colors.black
                        ),
                      ),
                      Switch(
                        value: check_custom,
                        activeColor: CupertinoColors.activeBlue,
                        onChanged: (bool value) async {
                          setState(() {
                            check_custom = value;
                          });
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setBool('custom_mode', value);
                        },
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  setState(() {
                    check_custom = !check_custom;
                  });
                  var prefs = await SharedPreferences.getInstance();
                  prefs.setBool('custom_mode', check_custom);
                },
              ) :
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '수동 환율 설정',
                      style: TextStyle(
                          fontSize: 16,
                          color: check_type == false ? Colors.grey : Colors.black
                      ),
                    ),
                  ]
                )
              ),
              SizedBox(height: 15),
              check_custom == true ? Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    Text(
                      '사용자 지정 환율',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    //달러 환율 설정
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text('USD')
                            ),
                            Text('(1달러)')
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,                      // Added this
                              contentPadding: EdgeInsets.all(8),  // Added this
                            ),
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            initialValue: user_rate[2].toString(),
                            onChanged: (value) {
                              setState(() {
                                user_rate[2] = num.parse(value);
                              });
                              if (value == '') {
                                setState(() {
                                  user_rate[2] = 1200;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    //엔 환율 설정
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text('JPY')
                            ),
                            Text('(100엔)'),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,                      // Added this
                              contentPadding: EdgeInsets.all(8),  // Added this
                            ),
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            initialValue: (user_rate[3]*100).toStringAsFixed(0),
                            onChanged: (value) {
                              setState(() {
                                user_rate[3] = num.parse(value)/100;
                              });
                              if (value == '') {
                                user_rate[3] = 10;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    //위안 환율 설정
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text('CNY')
                            ),
                            Text('(1위안)'),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,                      // Added this
                              contentPadding: EdgeInsets.all(8),  // Added this
                            ),
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            initialValue: user_rate[1].toString(),
                            onChanged: (value) {
                              setState(() {
                                user_rate[1] = num.parse(value);
                              });
                              if (value == '') {
                                setState(() {
                                  user_rate[1] = 200;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
