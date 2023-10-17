import 'package:http/http.dart' as http;
import 'dart:convert'; // jsonDcode 사용 가능

class Network{
  late final String url;
  // 생성자 : 앞 loading 코드에서 보낸 주소를 받습니다.
  Network(this.url);
  Future<dynamic> getData() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } else{
      print('예외상황');
      print('예외상황');
      print('예외상황');
    }
  } // ...getJsonData()

  Future<dynamic> getXml() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var xmlData = response.bodyBytes;
      var parsingData2 = utf8.decode(xmlData);
      return parsingData2;
    } else{
      // 예외상황 처리
    }
  } // ...ge

}