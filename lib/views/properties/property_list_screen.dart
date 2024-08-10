import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/providers/properties_provider.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/widgets/custom_app_bar.dart';
import 'package:rentify/widgets/property_dropdown.dart';
import 'package:rentify/widgets/tap_widget.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({super.key});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Properties",
        actions: [
          TextButton(
              onPressed: () => AppNavigator.shared
                  .pushNamed(routeName: Routes.addNewProperty),
              child: Text(
                "Add New",
                style: textStyle(color: AppColors.primary),
              ))
        ],
      ),
      body: Consumer<PropertyProvider>(
        builder: (context, value, child) => ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          padding: const EdgeInsets.all(15),
          itemBuilder: (context, index) => InkWellWidget(
            onTap: () => AppNavigator.shared.pushNamed(
                routeName: Routes.propertyDetails,
                arguments: value.properties[index]),
            child: PropertyDropDown(
              isShowArrow: false,
              property: value.properties[index],
            ),
          ),
          itemCount: value.properties.length,
        ),
      ),
    );
  }
}
