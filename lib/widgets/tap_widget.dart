import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InkWellWidget extends StatelessWidget {
  VoidCallback? onTap;
  Widget? child;
  InkWellWidget({super.key, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }
}
