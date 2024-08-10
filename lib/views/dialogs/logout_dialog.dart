import 'package:flutter/material.dart';
import 'package:rentify/theme/colors.dart';

import '../../main.dart';
import '../../theme/textstyles.dart';
import '../../utilities/sp.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "Logout",
                style: textStyle(
                    fontSize: dimensions.width * 0.05,
                    font: Fonts.normal,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: dimensions.width * 0.01,
            ),
            Text(
              "Are you sure you want to logout?",
              style: textStyle(
                  fontSize: dimensions.width * 0.04,
                  font: Fonts.normal,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: dimensions.width * 0.01,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: AppColors.primaryDark),
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style: textStyle(
                            color: AppColors.primaryDark, font: Fonts.normal),
                      )),
                ),
                SizedBox(
                  width: dimensions.width * 0.04,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(AppColors.primary),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () => SP.i.signOut(),
                      child: Text(
                        "Logout",
                        style:
                            textStyle(color: Colors.white, font: Fonts.normal),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
