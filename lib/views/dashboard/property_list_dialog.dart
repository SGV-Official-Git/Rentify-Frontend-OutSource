import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rentify/providers/properties_provider.dart';
import 'package:rentify/widgets/property_dropdown.dart';
import 'package:rentify/widgets/tap_widget.dart';

class PropertyListDialog extends StatelessWidget {
  const PropertyListDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyProvider>(builder: (context, val, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListView(
          shrinkWrap: true,
          children: List.generate(
              val.properties.length,
              (index) => InkWellWidget(
                    onTap: () =>
                        Navigator.of(context).pop(val.properties[index]),
                    child: PropertyDropDown(
                      isShowArrow: false,
                      property: val.properties[index],
                    ),
                  )),
        ),
      );
    });
  }
}
