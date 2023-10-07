import 'package:flutter/material.dart';
import 'package:live_currency_rate_app/screens/loading.dart';
import 'screens/home_page.dart';
//import 'views/text_detector_view.dart';

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
      home: Loading(),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.cyan),
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.red),
      ),
      themeMode: ThemeMode.light,
    );
  }
}