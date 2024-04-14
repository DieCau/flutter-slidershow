import 'package:flutter/material.dart';
import 'package:slideshow_app/src/pages/slideshow_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SlideShowPage()
    );
  }
}
