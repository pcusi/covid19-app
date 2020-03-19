import 'package:covid19pe_app/pages/news_page.dart';
import 'package:covid19pe_app/widgets/text_customize.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color(0xffDA071E),
            centerTitle: true,
            title: TextCustomize(
              text: 'COVID19.pe',
              size: 24,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(child: NewsPage()),
        ));
  }
}
