// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class OTPTextField extends StatelessWidget {
  int length;
  List<String> otp = List.filled(4, '');
  void Function(List<String>?)? onChange;
  OTPTextField({super.key, required this.otp, this.length = 4, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
            length,
            (index) => Flexible(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (value.length == 1) {
                              if (index < length - 1) {
                                FocusScope.of(context).nextFocus();
                              }
                              otp.insert(index, value);
                            } else {
                              otp.removeAt(index);
                              FocusScope.of(context).previousFocus();
                            }
                          } else {
                            if (index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                            otp.removeAt(index);
                          }

                          if (onChange != null) {
                            onChange!(otp);
                          }
                        },
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            counterText: "", border: InputBorder.none),
                      )),
                ))));
  }
}
