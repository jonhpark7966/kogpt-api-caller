import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResponsiveDecorator extends StatefulWidget{
  Widget child;
  Color color;
  Color shadeColor;
  ResponsiveDecorator({Key? key,
   required this.child, required this.color, required this.shadeColor}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ResponsiveDecoratorState createState()  => _ResponsiveDecoratorState();
}

class _ResponsiveDecoratorState extends State<ResponsiveDecorator> {
  @override
  Widget build(BuildContext context) {
    return 
      Center(child:Container(
        constraints: BoxConstraints(minWidth: 800, maxWidth: 800),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.color,
          boxShadow: [BoxShadow(color: widget.shadeColor, blurRadius: 4, offset: const Offset(4,4))],
          borderRadius: BorderRadius.circular(5)),
          child: widget.child));
  }
}