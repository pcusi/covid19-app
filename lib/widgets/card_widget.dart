import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Color colors;
  final Widget one;
  final Widget two;
  final Widget three;
  final Widget four;
  final Widget five;

  CardWidget({
    Key key,
    this.colors,
    this.one,
    this.two,
    this.three,
    this.four,
    this.five,
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffDA071E),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //ago - date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[widget.one, widget.two],
              ),
              SizedBox(
                height: 24.0,
              ),
              //title
              widget.three,
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 12.0,
              ),
              widget.four,
              SizedBox(
                height: 12.0,
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 12.0,
              ),
              widget.five
            ],
          ),
        ),
      ),
    );
  }
}
