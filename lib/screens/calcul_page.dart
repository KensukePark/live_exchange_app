import 'package:flutter/material.dart';
import 'package:math_parser/math_parser.dart';

class CalPage extends StatefulWidget {
  const CalPage({Key? key}) : super(key: key);

  @override
  State<CalPage> createState() => _CalPageState();
}

class _CalPageState extends State<CalPage> {
  String display = '';
  String money_one = '';
  String answer = '';
  String money_two = '';
  String answer_two = '';
  String from_cur = 'KRW';
  String to_cur = 'USD';
  final exp = MathNodeExpression.fromString('3 + 2');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(exp.calc(MathVariableValues.x(0)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '환율계산기',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffFEFAF8),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.grey, width: 1),
                                )
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'KRW',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    Text(
                                      '원',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: EdgeInsets.all(15),
                              child: answer != '' ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    money_one,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    answer,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ) : Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  money_one,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  border: Border(
                                    right: BorderSide(color: Colors.grey, width: 1),
                                  )
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'USD',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    Text(
                                      '미국달러',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  answer_two,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  Flexible(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    border: Border(
                                      right: BorderSide(color: Colors.grey, width: 1),
                                    )
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.swap_vert,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(width: 1),
                                        Text(
                                          '전환',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Container(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                  ),

                ],
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height) * 0.12,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: Row(
                children: [
                  Flexible( //CE버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = '';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            'CE',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //C버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = '';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            'C',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //한칸지우기버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          if (money_one.length > 0) {
                            setState(() {
                              money_one = money_one.substring(0,money_one.length-1);
                            });
                          }
                          if (answer != '') {
                            setState(() {
                              answer = '';
                              money_one = '';
                              answer_two = '';
                            });
                          }
                        },
                        child: Center(
                          child: Icon(
                            Icons.keyboard_backspace,
                            color: Colors.white,
                            size: 44,
                          )
                        ),
                      ),
                    ),
                  ),
                  Flexible( // /버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          if (int.tryParse(money_one[money_one.length-1]) != null) {
                            setState(() {
                              money_one = money_one + '/';
                            });
                          }
                          else if (money_one[money_one.length-1] == '/'
                              || money_one[money_one.length-1] == '*'
                              || money_one[money_one.length-1] == '-'
                              || money_one[money_one.length-1] == '+'
                              || money_one[money_one.length-1] == '.') {
                            setState(() {
                              money_one = money_one.substring(0,money_one.length-1) + '/';
                            });
                          }
                          setState(() {
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '÷',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height) * 0.12,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: Row(
                children: [
                  Flexible( //7버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '7';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '7',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //8버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '8';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '8',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //9버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '9';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '9',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //*버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          if (int.tryParse(money_one[money_one.length-1]) != null) {
                            setState(() {
                              money_one = money_one + '*';
                            });
                          }
                          else if (money_one[money_one.length-1] == '/'
                              || money_one[money_one.length-1] == '*'
                              || money_one[money_one.length-1] == '-'
                              || money_one[money_one.length-1] == '+'
                              || money_one[money_one.length-1] == '.') {
                            setState(() {
                              money_one = money_one.substring(0,money_one.length-1) + '*';
                            });
                          }
                          setState(() {
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '×',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height) * 0.12,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: Row(
                children: [
                  Flexible( //4버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '4';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '4',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //5버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '5';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '5',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //6버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '6';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '6',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //-버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          if (int.tryParse(money_one[money_one.length-1]) != null) {
                            setState(() {
                              money_one = money_one + '-';
                            });
                          }
                          else if (money_one[money_one.length-1] == '/'
                              || money_one[money_one.length-1] == '*'
                              || money_one[money_one.length-1] == '-'
                              || money_one[money_one.length-1] == '+'
                              || money_one[money_one.length-1] == '.') {
                            setState(() {
                              money_one = money_one.substring(0,money_one.length-1) + '-';
                            });
                          }
                          setState(() {
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '－',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height) * 0.12,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: Row(
                children: [
                  Flexible( //1버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '1';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //2버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '2';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //3버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '3';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //+버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          if (int.tryParse(money_one[money_one.length-1]) != null) {
                            setState(() {
                              money_one = money_one + '+';
                            });
                          }
                          else if (money_one[money_one.length-1] == '/'
                              || money_one[money_one.length-1] == '*'
                              || money_one[money_one.length-1] == '-'
                              || money_one[money_one.length-1] == '+'
                              || money_one[money_one.length-1] == '.') {
                            setState(() {
                              money_one = money_one.substring(0,money_one.length-1) + '+';
                            });
                          }
                          setState(() {
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '＋',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container( //00버튼
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height) * 0.12,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          if (money_one != '') {
                            setState(() {
                              money_one = money_one + '00';
                              answer = '';
                              answer_two = '';
                            });
                          }
                        },
                        child: Center(
                          child: Text(
                            '00',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //0버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            money_one = money_one + '0';
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '0',
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( //.버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          if (money_one == '') {
                            setState(() {
                              money_one = '0.';
                            });
                          }
                          else if (money_one[money_one.length-1] == '/'
                              || money_one[money_one.length-1] == '*'
                              || money_one[money_one.length-1] == '-'
                              || money_one[money_one.length-1] == '+') {
                            setState(() {
                              money_one = money_one + '0.';
                            });
                          }
                          else if (money_one[money_one.length-1] == '.') {
                            null;
                          }
                          else {
                            setState(() {
                              money_one = money_one + '.';
                            });
                          }
                          setState(() {
                            answer = '';
                            answer_two = '';
                          });
                        },
                        child: Center(
                          child: Text(
                            '.',
                            style: TextStyle(
                              fontSize: 42,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible( // =버튼
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1),
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          if (int.tryParse(money_one[money_one.length-1]) == null) {
                            setState(() {
                              answer = 'Error';
                            });
                          }
                          else {
                            final express = MathNodeExpression.fromString(money_one);
                            print(express.calc(MathVariableValues.x(0)));
                            setState(() {
                              answer = express.calc(MathVariableValues.x(0)).toString();
                              answer_two = (express.calc(MathVariableValues.x(0)) / 1100).toStringAsFixed(2);
                            });
                          }

                        },
                        child: Center(
                          child: Text(
                            '＝',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
