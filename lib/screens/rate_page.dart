import 'package:flutter/material.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key, required this.result, required this.img, required this.date}) : super(key: key);
  final List<String> result;
  final List<String> img;
  final String date;

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            '은행 고시환율',
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Color(0xffFEFAF8),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.img.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10,10,10,2.5),
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.result[5*idx],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          widget.result[5*idx+1],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Image.network(
                                              widget.img[idx],
                                              height: MediaQuery.of(context).size.height * 0.065,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.18,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    //widget.result[5*idx+2].contains('.') ? widget.result[5*idx+2].substring(0,widget.result[5*idx+2].length-3) :
                                                    widget.result[5*idx+2],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(5,2,5,2),
                                                    decoration: BoxDecoration(
                                                      color: widget.result[5*idx+4].contains('-') ? Colors.red : Colors.greenAccent,
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    child: Text(
                                                      widget.result[5*idx+4],
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            widget.date + ' 기준 환율',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                        ),
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}