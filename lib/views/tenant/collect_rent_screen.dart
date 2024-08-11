// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/utilities/validations.dart';
import 'package:rentify/widgets/custom_app_bar.dart';
import 'package:rentify/widgets/custom_text_field.dart';

import '../../widgets/custom_button.dart';

class CollectRent extends StatefulWidget {
  const CollectRent({super.key});

  @override
  State<CollectRent> createState() => _CollectRentState();
}

class _CollectRentState extends State<CollectRent> {
  @override
  void initState() {
    super.initState();
  }

  List<String> paymentMode = ['Online', 'Cash'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Add New Tenant",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            // key: formKey,
            //  autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                CustomTextField(
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Name *",
                  textInputType: TextInputType.name,
                  hintText: "Enter Name",
                  onChanged: (p0) => setState(() {}),
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  textInputType: TextInputType.number,
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Rent Amount *",
                  onChanged: (p0) => setState(() {}),
                  hintText: "\$ 0.00",
                  icon: Assets.icons.navCollectionActive,
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField<String>(
                  trailingIcon: Assets.icons.arrowDown,
                  onChanged: (p0) {
                    setState(() {});
                  },
                  // label: "Rent Frequency *",
                  isDropdown: true,
                  items: paymentMode,
                  hintText: "Mode of payment",
                ),
                SizedBox(height: dimensions.width * 0.08),
                CustomButton(
                  onPressed: () {},
                  title: "Collect",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
