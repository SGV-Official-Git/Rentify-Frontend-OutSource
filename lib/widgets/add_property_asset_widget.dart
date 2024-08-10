import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/custom_icon_button.dart';
import 'package:rentify/widgets/custom_text_field.dart';

import '../utilities/validations.dart';

class AddPropertyAssetWidget extends StatelessWidget {
  final VoidCallback? increase, decrease;
  final int count;
  final void Function(dynamic)? onChanged;
  const AddPropertyAssetWidget(
      {super.key,
      this.count = 0,
      this.decrease,
      this.increase,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          hintText: "Item Name",
          validator: (p0) => Validation.instance.emptyField(p0),
          onChanged: onChanged,
        )),
        SizedBox(width: dimensions.width * 0.03),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: AppColors.primaryGrey,
              borderRadius: BorderRadius.circular(14)),
          child: Row(
            children: [
              CustomIconButton(
                onPressed: decrease,
                icon: Assets.icons.removeIconWhite,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "$count",
                  style: textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: dimensions.width * 0.05,
                      color: AppColors.gray),
                ),
              ),
              CustomIconButton(
                onPressed: increase,
                icon: Assets.icons.addIconWhite,
              )
            ],
          ),
        )
      ],
    );
  }
}
