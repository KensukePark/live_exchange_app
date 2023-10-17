import 'package:flutter/material.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key}) : super(key: key);

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
          '현재 환율',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Color(0xffFEFAF8),
        centerTitle: true,
      ),
    );
  }
}
