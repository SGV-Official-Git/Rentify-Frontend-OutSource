// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/helper_func.dart';
import 'package:rentify/utilities/validations.dart';
import 'package:rentify/widgets/custom_button.dart';
import 'package:rentify/widgets/custom_text_field.dart';

import '../../data/property_item_modal.dart';

class VacateTenant extends StatefulWidget {
  PropertyItem? property;
  VacateTenant({super.key, this.property});

  @override
  State<VacateTenant> createState() => _VacateTenantState();
}

class _VacateTenantState extends State<VacateTenant> {
  String expenseName = '', amount = '';
  DateTime? expenseDate;
  File? expenseImage;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      //   autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15.0),
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Vacate Tenant",
              style: textStyle(
                  fontSize: dimensions.width * 0.04,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: dimensions.width * 0.04,
          ),
          CustomTextField(
            validator: (p0) => Validation.instance.emptyField(p0),
            icon: Assets.icons.billingDate,
            label: "DATE OF VACATE*",
            readOnly: true,
            controller: TextEditingController(
                text: HelperMethods.instance.dateFormatMonth(expenseDate)),
            hintText: "DD/MM/YYYY",
            onPressed: () async {
              final date = await showDatePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                context: context,
              );
              if (date != null) {
                expenseDate = date;
                setState(() {});
              }
            },
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          CustomButton(
            title: "VACATE",
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
