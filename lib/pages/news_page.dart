import 'package:covid19pe_app/models/Cases.dart';
import 'package:covid19pe_app/widgets/card_widget.dart';
import 'package:covid19pe_app/widgets/text_customize.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:covid19pe_app/models/News.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final page = 1;

  Future<List<News>> getNews() async {
    final url = 'http://10.0.2.2:4000/api/v1/news/$page';

    final response = await http.get(url);

    if (response != null) {
      final parsed = jsonDecode(response.body);

      final list = parsed['find'] as List;

      List<News> news = list.map((i) => News.fromJson(i)).toList();

      return news;
    }

    return null;
  }

  Future<Cases> getCases() async {
    final url = 'https://coronavirus-19-api.herokuapp.com/countries/peru';
    final response = await http.get(url);

    if (response != null) {
      return Cases.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<Cases>(
              future: getCases(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    spacing: 15.0,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: <Widget>[
                      TextCustomize(
                        text:
                            'Total de Casos: ' + snapshot.data.cases.toString(),
                        size: 18.0,
                      ),
                      TextCustomize(
                        text: 'Casos confirmados hoy: ' +
                            snapshot.data.todayCases.toString(),
                        size: 18.0,
                      ),
                      TextCustomize(
                        text: 'Recuperados: ' +
                            snapshot.data.recovered.toString(),
                        size: 18.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      TextCustomize(
                        text:
                            'Casos activos: ' + snapshot.data.active.toString(),
                        size: 18.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      TextCustomize(
                        text: 'Casos críticos:' +
                            snapshot.data.critical.toString(),
                        size: 18.0,
                        color: Color(0xffDA071E),
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextCustomize(
              text: 'Lo último',
              size: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20.0),
            FutureBuilder<List<News>>(
              future: getNews(),
              builder: (context, snapshot) {
                return Container(
                  width: double.infinity,
                  height: size.height * .8 - 125,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final news = snapshot.data[index];

                      final timestamps = int.parse(news.createdAt);

                      final newDate = DateTime.fromMillisecondsSinceEpoch(
                          timestamps * 1000);

                      final dateAgo = timeago.format(newDate, locale: 'es');

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: CardWidget(
                          one: TextCustomize(
                            text: dateAgo.toString(),
                            color: Colors.white,
                          ),
                          two: TextCustomize(
                            text: newDate.toString(),
                            color: Colors.white,
                          ),
                          three: TextCustomize(
                            text: news.title,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 18.0,
                          ),
                          four: TextCustomize(
                            text: news.description,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 15.0,
                          ),
                          five: Linkify(
                            onOpen: (link) async {
                              if (await canLaunch(link.url)) {
                                await launch(link.url);
                              } else {
                                throw 'Could not launch $link';
                              }
                            },
                            text: 'Fuente: ' + news.link,
                            style: TextStyle(color: Colors.white),
                            linkStyle: TextStyle(color: Colors.blue),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
