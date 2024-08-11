// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/image.dart';
import 'package:rentify/widgets/tap_widget.dart';

import '../main.dart';

class CustomTextField<T> extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hintText, icon, trailingIcon, label;
  final List<dynamic>? items;
  final String selectedItem;
final T? value; 
  final void Function(dynamic)? onChanged;
  final VoidCallback? onPressed, onLeadingPress;
  final bool obsecure, isDropdown, readOnly;
  String? Function(String?)? validator;
  CustomTextField(
      {super.key,
      this.controller,
      this.validator,
      this.onChanged,
      this.label,
          this.value,

      this.onLeadingPress,
      this.onPressed,
      this.items,
      this.readOnly = false,
      this.selectedItem = "",
      this.isDropdown = false,
      this.obsecure = false,
      this.hintText,
      this.trailingIcon,
      this.icon,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    if (isDropdown) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            Text(
              "$label",
              style: textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: dimensions.width * 0.035),
            ),
          if (label != null)
            SizedBox(
              height: dimensions.width * 0.015,
            ),
          DropdownButtonFormField<T>(
            value:  value,
              iconEnabledColor: Colors.transparent,
              decoration: InputDecoration(
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 50, maxWidth: 50),
                  suffixIconConstraints:
                      const BoxConstraints(maxHeight: 50, maxWidth: 50),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ImageWidget(
                      url: trailingIcon ?? Assets.icons.arrowDown,
                      color: AppColors.purple,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  hintText: hintText,
                  hintStyle: textStyle(
                      color: AppColors.hint,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xffE1E1E1)))),
              items: List.generate(
                  items?.length ?? 0,
                  (index) => DropdownMenuItem(
                      value: items?[index],
                      
                      child: Row(
                        children: [
                          if (icon != null)
                            ImageWidget(
                              url: icon ?? "",
                              height: dimensions.width * 0.05,
                              width: dimensions.width * 0.05,
                            ),
                          if (icon != null)
                            SizedBox(
                              width: dimensions.width * 0.02,
                            ),
                          Text(
                            T == String ? items![index] : items![index].name,
                            style: textStyle(
                                fontSize: dimensions.width * 0.035,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ))),
              onChanged: onChanged)
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            Text(
              "$label",
              style: textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: dimensions.width * 0.035),
            ),
          if (label != null)
            SizedBox(
              height: dimensions.width * 0.015,
            ),
          TextFormField(
            readOnly: readOnly,
            onTap: onPressed,
            validator: validator,
            controller: controller,
            onChanged: onChanged,
            obscureText: obsecure,
            keyboardType: textInputType,
            maxLines: textInputType == TextInputType.multiline ? 5 : 1,
            decoration: InputDecoration(
                prefixIconConstraints:
                    const BoxConstraints(maxHeight: 50, maxWidth: 50),
                suffixIconConstraints:
                    const BoxConstraints(maxHeight: 50, maxWidth: 50),
                suffixIcon: InkWellWidget(
                  onTap: onLeadingPress,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ImageWidget(
                      url: trailingIcon ?? "",
                    ),
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ImageWidget(
                    url: icon ?? "",
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                hintText: hintText,
                hintStyle: textStyle(
                    color: AppColors.hint,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE1E1E1)))),
          ),
        ],
      );
    }
  }
}
