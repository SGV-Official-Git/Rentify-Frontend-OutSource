import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/image.dart';

class PropertyAssetTile extends StatelessWidget {
  const PropertyAssetTile({
    super.key,
    this.assetName,
    this.showCheck = true,
    this.icon,
    required this.selectedPropertyAsset,
  });

  final bool? selectedPropertyAsset, showCheck;
  final String? assetName, icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffF0F0F0))),
      child: Row(
        children: [
          ImageWidget(
            url: icon ?? "",
          ),
          SizedBox(
            width: dimensions.width * 0.02,
          ),
          Expanded(
            child: Text(
              assetName ?? "",
              style: textStyle(fontSize: dimensions.width * 0.035),
            ),
          ),
          SizedBox(
            width: dimensions.width * 0.02,
          ),
          if (showCheck == true)
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xffEBEBEB))),
              child: Visibility(
                visible: selectedPropertyAsset ?? false,
                child: ImageWidget(
                  url: Assets.icons.checkCircleSelected,
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover,
                ),
              ),
            )
        ],
      ),
    );
  }
}
