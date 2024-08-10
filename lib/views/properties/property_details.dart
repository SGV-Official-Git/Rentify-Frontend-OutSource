import 'package:flutter/material.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/property_item_modal.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/widgets/image.dart';
import 'package:rentify/widgets/property_asset_tile.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/property_detail_widget.dart';
import '../../widgets/total_deposite_widget.dart';
import 'property_detail_data.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({super.key});

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  List<PropertyDetailData> propertyDetailData = [
    PropertyDetailData(
        Assets.icons.commercialFillter, "Property Type", "Villa"),
    PropertyDetailData(Assets.icons.roomNumber, "Total Room", "4"),
    PropertyDetailData(Assets.icons.totalBeds, "Total Beds", "2"),
    PropertyDetailData(Assets.icons.rentUser, "Manager", "James"),
    PropertyDetailData(Assets.icons.telIcon2x, "Contact", "+1 22177200"),
  ];

  PropertyItem? propertyItem;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final args = ModalRoute.of(context)?.settings.arguments as PropertyItem?;
      if (args != null) {
        propertyItem = args;
        propertyDetailData[0].value =
            propertyItem?.propertyTypeDetails?.first.name ?? "N/A";
        propertyDetailData[1].value = "${propertyItem?.totalRooms ?? "0"}";
        propertyDetailData[2].value = "${propertyItem?.totalBeds ?? "0"}";
        propertyDetailData[3].value = propertyItem?.propertyMangerName ?? "0";
        propertyDetailData[4].value = propertyItem?.propertyMangerCont ?? "0";
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Property",
        actions: [
          IconButton(
              onPressed: () {},
              icon: ImageWidget(
                url: Assets.icons.deletIcon,
              ))
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 7.8,
            child: ImageWidget(
              url: "${Endpoints.imageUrl}${propertyItem?.propertyImage}",
              width: dimensions.width,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  propertyItem?.propertyName ?? "",
                  style: textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: dimensions.width * 0.045),
                ),
                SizedBox(
                  height: dimensions.width * 0.02,
                ),
                Row(
                  children: [
                    ImageWidget(
                      url: Assets.icons.lcoationIcon,
                      height: dimensions.width * 0.05,
                      width: dimensions.width * 0.05,
                    ),
                    SizedBox(width: dimensions.width * 0.02),
                    Text(
                      propertyItem?.propertyAddress ?? "",
                      style: textStyle(
                          color: AppColors.gray,
                          fontWeight: FontWeight.w400,
                          fontSize: dimensions.width * 0.035),
                    ),
                  ],
                ),
                SizedBox(
                  height: dimensions.width * 0.01,
                ),
                Row(
                  children: [
                    ImageWidget(
                      url: Assets.icons.totalLiveTenants,
                      height: dimensions.width * 0.05,
                      width: dimensions.width * 0.05,
                    ),
                    SizedBox(width: dimensions.width * 0.02),
                    Text(
                      "${propertyItem?.tenantIds?.length} Total live tenants",
                      style: textStyle(
                          color: AppColors.gray,
                          fontWeight: FontWeight.w400,
                          fontSize: dimensions.width * 0.035),
                    ),
                  ],
                ),
                SizedBox(
                  height: dimensions.width * 0.03,
                ),
                TotalDepositeWidget(
                  icon: Assets.icons.navCollection,
                  amount: "${propertyItem?.totalDepositAmount ?? 0}",
                ),
                SizedBox(
                  height: dimensions.width * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.bottomNav)),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => PropertyDetailWidget(
                            icon: propertyDetailData[index].icon,
                            assetName: propertyDetailData[index].title,
                            value: propertyDetailData[index].value,
                          ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: propertyDetailData.length),
                ),
                SizedBox(height: dimensions.width * 0.03),
                const Divider(
                  thickness: 4,
                  color: Color(0xffF7F7F7),
                ),
                SizedBox(height: dimensions.width * 0.03),
                Text(
                  "Amenities",
                  style: textStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: dimensions.width * 0.038),
                ),
                SizedBox(height: dimensions.width * 0.03),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 50,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  children: List.generate(
                      propertyItem?.amenitiesDetails?.length ?? 0,
                      (index) => PropertyAssetTile(
                            showCheck: false,
                            selectedPropertyAsset: false,
                            icon:
                                "${Endpoints.imageUrl}${propertyItem?.amenitiesDetails?[index].image ?? ""}",
                            assetName:
                                propertyItem?.amenitiesDetails?[index].name ??
                                    "",
                          )),
                ),
                SizedBox(height: dimensions.width * 0.03),
                const Divider(
                  thickness: 4,
                  color: Color(0xffF7F7F7),
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomButton(
                  icon: Assets.icons.download,
                  backgroundColor: AppColors.lightButton,
                  textColor: AppColors.primary,
                  title: "Download Expense Report",
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomButton(
                  onPressed: () => Navigator.of(context).pop(),
                  title: "Download Consultation Report",
                  iconColor: Colors.white,
                  icon: Assets.icons.download,
                ),
                SizedBox(height: dimensions.width * 0.03),
                const Divider(
                  thickness: 4,
                  color: Color(0xffF7F7F7),
                ),
                SizedBox(height: dimensions.width * 0.05),
                CustomButton(
                  onPressed: () => AppNavigator.shared.pushNamed(
                      routeName: Routes.addNewProperty, arguments: true),
                  title: "Edit",
                ),
                SizedBox(height: dimensions.width * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
