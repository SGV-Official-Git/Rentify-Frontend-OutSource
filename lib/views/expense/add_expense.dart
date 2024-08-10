// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/providers/expense_provider.dart';
import 'package:rentify/utilities/helper_func.dart';
import 'package:rentify/utilities/validations.dart';
import 'package:rentify/widgets/custom_button.dart';
import 'package:rentify/widgets/custom_text_field.dart';
import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/image.dart';

import '../../data/property_item_modal.dart';
import '../../widgets/image_picker_widget.dart';
import '../../widgets/tap_widget.dart';

class AddExpense extends StatefulWidget {
  PropertyItem? property;
  AddExpense({super.key, this.property});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
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
          // Center(
          //   child: Text(
          //     "Add New Expense",
          //     style: textStyle(
          //         fontSize: dimensions.width * 0.04, fontWeight: FontWeight.w600),
          //   ),
          // ),
          // SizedBox(
          //   height: dimensions.width * 0.03,
          // ),
          // CustomTextField<String>(
          //   label: "Property *",
          //   isDropdown: true,
          //   items: const ["Commercial"],
          // ),
          // SizedBox(
          //   height: dimensions.width * 0.03,
          // ),
          CustomTextField(
            label: "Expense *",
            validator: (p0) => Validation.instance.emptyField(p0),
            onChanged: (p0) => setState(() {
              expenseName = p0;
            }),
            hintText: "Tanker/Electricity Bill/Sallary",
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          CustomTextField(
            validator: (p0) => Validation.instance.emptyField(p0),
            onChanged: (p0) => setState(() {
              amount = p0;
            }),
            label: "Amount *",
            hintText: "Enter Amount",
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          CustomTextField(
            validator: (p0) => Validation.instance.emptyField(p0),
            icon: Assets.icons.billingDate,
            label: "Expense Date *",
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

          InkWellWidget(
            onTap: () async {
              final image = await ImagePickerWidget.pickImage();
              if (image != null) {
                expenseImage = image;
                setState(() {});
              }
            },
            child: expenseImage == null || expenseImage?.path.isEmpty == true
                ? ImageWidget(
                    url: Assets.icons.addExpenseDocs,
                    width: dimensions.width,
                  )
                : ImageWidget<File>(
                    imageFile: expenseImage,
                    width: dimensions.width,
                    height: dimensions.width * 0.3,
                  ),
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          CustomButton(
            title: "Add Expense",
            onPressed: () {
              if (expenseDate == null) {
                alert(type: AlertType.error, message: "Select expense date");
                return;
              }
              if (expenseImage == null || expenseImage?.path.isEmpty == true) {
                alert(type: AlertType.error, message: "Select expense image");
                return;
              }
              if (formKey.currentState?.validate() == true) {
                context.read<ExpenseProvider>().addExpense(
                    title: expenseName,
                    amount: amount,
                    date: expenseDate.toString(),
                    propertyId: widget.property?.id ?? "",
                    file: expenseImage);
              }
            },
          )
        ],
      ),
    );
  }
}
