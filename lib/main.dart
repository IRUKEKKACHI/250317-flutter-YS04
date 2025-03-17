import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterYS04());
}

class FlutterYS04 extends StatelessWidget {
  const FlutterYS04({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter YS04',
      home: Scaffold(
        body: Center(
          child: Text(
            'Flutter YS04',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
