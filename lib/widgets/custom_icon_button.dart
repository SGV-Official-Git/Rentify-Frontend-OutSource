import 'package:flutter/material.dart';
import 'package:rentify/widgets/image.dart';
import 'package:rentify/widgets/tap_widget.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onPressed;
  const CustomIconButton({super.key, this.icon = '', this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onPressed,
      child: ImageWidget(
        url: icon,
      ),
    );
  }
}
