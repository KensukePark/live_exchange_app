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
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/chunsik_bg_3.jpg'), // 배경 이미지
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ScalableOCR(
                    paintboxCustom: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4.0
                      ..color = const Color.fromARGB(153, 102, 160, 241),
                    boxLeftOff: 6,
                    boxBottomOff: 4,
                    boxRightOff: 4,
                    boxTopOff: 6,
                    boxHeight: MediaQuery.of(context).size.height / 3.5,
                    getRawData: (value) {
                      inspect(value);
                    },
                    getScannedText: (value) {
                      setText(value);
                    }
                  ),
                  StreamBuilder<String>(
                    stream: controller_stream.stream,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return Result(text: snapshot.data != null ? snapshot.data! : '');
                    },
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    print('텍스트 : ' + text);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '인식 결과 : ',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 16
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}