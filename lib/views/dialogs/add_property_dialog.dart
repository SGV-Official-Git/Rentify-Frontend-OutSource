// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/widgets/custom_button.dart';

class AddPropertyDialog extends StatelessWidget {
  const AddPropertyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add Property",
              style: textStyle(
                fontSize: dimensions.width * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: dimensions.width * 0.03,
            ),
            Text(
              "please add a property before proceed",
              style: textStyle(
                fontSize: dimensions.width * 0.035,
              ),
            ),
            SizedBox(
              height: dimensions.width * 0.03,
            ),
            CustomButton(
              title: "Add Property",
              onPressed: () async {
                final data = await AppNavigator.shared.pushNamed(
                    routeName: Routes.addNewProperty, arguments: false);
                if (data) {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
