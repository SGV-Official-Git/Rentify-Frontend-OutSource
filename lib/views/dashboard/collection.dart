import 'package:flutter/material.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/textstyles.dart';

class Collection extends StatefulWidget {
  const Collection({super.key});

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Coming Soon...",
          style: textStyle(fontSize: dimensions.width * 0.05),
        ),
      ),
    );
  }
}
