import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'views/text_detector_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '실시간 가격 환산 앱',
      home: TextRecognizerView(),
    );
  }
}