import 'package:flutter/material.dart';

class TextCustomize extends StatefulWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration underline;

  TextCustomize({
    Key key,
    this.text,
    this.size,
    this.color,
    this.fontWeight,
    this.underline
  }) : super(key: key);

  @override
  _TextCustomizeState createState() => _TextCustomizeState();
}

class _TextCustomizeState extends State<TextCustomize> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        widget.text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: 'RobotoSlab',
          color: widget.color,
          fontSize: widget.size,
          fontWeight: widget.fontWeight,
          decoration: widget.underline,
        ),
      ),
    );
  }
}
