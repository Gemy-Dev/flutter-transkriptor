import 'package:flutter/material.dart';

class ViewTranskript extends StatelessWidget {
  const ViewTranskript({super.key, required this.text, required this.time});
  final String text;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(time),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Text(text),
        ),
      ),
    );
  }
}
