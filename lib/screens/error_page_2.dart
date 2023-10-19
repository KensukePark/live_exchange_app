import 'package:flutter/material.dart';
import 'package:live_currency_rate_app/screens/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ErrorPageTwo extends StatefulWidget {
  const ErrorPageTwo({Key? key}) : super(key: key);

  @override
  State<ErrorPageTwo> createState() => _ErrorPageTwoState();
}

class _ErrorPageTwoState extends State<ErrorPageTwo> {
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
                  '인터넷 연결을 확인하세요',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                  '네트워크 상태를 다시 확인하세요',
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
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                          return Loading();
                        }), (route) => false);
                      },
                      child: Container(
                        child: Text(
                          '다시 시도',
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
