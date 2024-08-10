import 'package:flutter/material.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/textstyles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.actions,
      this.automaticallyImplyLeading = true});
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      title: Text(
        title,
        style: textStyle(
            fontWeight: FontWeight.w700, fontSize: dimensions.width * 0.04),
      ),
    );
  }

  @override
  Size get preferredSize => Size(dimensions.width, 56);
}
