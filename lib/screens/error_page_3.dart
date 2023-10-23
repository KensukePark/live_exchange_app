import 'package:flutter/material.dart';
import 'package:live_currency_rate_app/screens/setting_page_OnOff.dart';

class ErrorPageThr extends StatefulWidget {
  const ErrorPageThr({Key? key, required this.check, required this.check_custom, required this.user_rate}) : super(key: key);
  final bool check;
  final bool check_custom;
  final List<num> user_rate;

  @override
  State<ErrorPageThr> createState() => _ErrorPageThrState();
}

class _ErrorPageThrState extends State<ErrorPageThr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffFEFAF8),
            /*
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/chunsik_bg_3.jpg'), // 배경 이미지
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.dstATop
              ),
            ),
             */
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                  size: 80,
                ),
                SizedBox(height: 20,),
                Text(
                  '오프라인 모드에서 이용이 불가능합니다.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                  '오프라인 모드를 해제하거나',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '사용자 환율 모드를 설정해주세요.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text(
                          '뒤로 가기',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return OnOffPage(check: widget.check, check_custom: widget.check_custom, user_rate: widget.user_rate);
                            },
                          ),
                        );
                      },
                      child: Container(
                        child: Text(
                          '설정',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
