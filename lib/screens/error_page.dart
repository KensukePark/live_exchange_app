import 'package:flutter/material.dart';
import 'package:live_currency_rate_app/screens/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
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
                  Icons.portable_wifi_off_sharp,
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
                  '네트워크 상태를 다시 확인하거나',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '오프라인 모드를 이용해 보세요.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  style: ButtonStyle(
                  ),
                  onPressed: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool('bool', true);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                      return Loading();
                    }), (route) => false);
                  },
                  child: Text('오프라인 모드 사용'),
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
          ),
        ),
      ),
    );
  }
}
