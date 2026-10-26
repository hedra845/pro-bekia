

import 'package:flutter/material.dart';
import 'package:pro_bekia/home_page.dart';

void main() => runApp(Pro_BekiaApp());

class Pro_BekiaApp extends StatefulWidget {
  const Pro_BekiaApp({super.key});

  @override
  State<Pro_BekiaApp> createState() => _Pro_BekiaAppState();
}

class _Pro_BekiaAppState extends State<Pro_BekiaApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BekiaHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

