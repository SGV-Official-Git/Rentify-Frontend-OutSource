// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/property_list_item.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/providers/properties_provider.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/validations.dart';
import 'package:rentify/widgets/custom_app_bar.dart';
import 'package:rentify/widgets/custom_text_field.dart';
import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/image.dart';
import 'package:rentify/widgets/image_picker_widget.dart';
import 'package:rentify/widgets/tap_widget.dart';

import '../../data/room_asset_modal.dart';
import '../../theme/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/property_asset_tile.dart';

class AddNewProperty extends StatefulWidget {
  const AddNewProperty({super.key});

  @override
  State<AddNewProperty> createState() => _AddNewPropertyState();
}

class _AddNewPropertyState extends State<AddNewProperty> {
  File? propertyImage;

  bool isEdit = false;

  PropertyTypeItem? propertyItem;

  String name = '', address = '', managerName = '', managerContact = '';

  List<String> selectedPropertyAssets = [];

  final formkey = GlobalKey<FormState>();

  List<PropertyRoomDetail> roomDetail = [PropertyRoomDetail([], "", "", "")];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<PropertyProvider>().getPropertyType();
      await context.read<PropertyProvider>().getPropertyAssets();
      setState(() {
        isEdit = ModalRoute.of(context)?.settings.arguments as bool;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: !isEdit ? "Add New Property" : "Edit Property",
      ),
      body: Form(
        //  autovalidateMode: AutovalidateMode.always,
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(height: dimensions.width * 0.03),
                InkWellWidget(
                    onTap: () async {
                      final image = await ImagePickerWidget.pickImage();
                      if (image != null && image.path.isNotEmpty) {
                        propertyImage = image;
                        setState(() {});
                      }
                    },
                    child: propertyImage == null ||
                            propertyImage?.path.isEmpty == true
                        ? ImageWidget(
                            url: Assets.icons.addImgOfProperty,
                            width: dimensions.width,
                          )
                        : AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ImageWidget<File>(
                              imageFile: propertyImage,
                              width: dimensions.width,
                            ),
                          )),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  textInputType: TextInputType.name,
                  label: "Property Name *",
                  validator: (p0) => Validation.instance.emptyField(p0),
                  onChanged: (p0) => setState(() {
                    name = p0;
                  }),
                  hintText: "Enter Property Name",
                ),
                SizedBox(height: dimensions.width * 0.03),
                Consumer<PropertyProvider>(builder: (context, val, _) {
                  if (val.propertyTypes.isNotEmpty) {
                    //  propertyItem = val.propertyTypes[0];
                    return CustomTextField<PropertyTypeItem>(
                      isDropdown: true,
                      onChanged: (p0) {
                        final propertType = p0 as PropertyTypeItem;
                        propertyItem = propertType;
                        setState(() {});
                      },
                      items: val.propertyTypes,
                      label: "Property Type *",
                      hintText: "Select Property Type",
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  textInputType: TextInputType.multiline,
                  label: "Property Address *",
                  validator: (p0) => Validation.instance.emptyField(p0),
                  onChanged: (p0) => setState(() {
                    address = p0;
                  }),
                  hintText: "Enter Property Address",
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  textInputType: TextInputType.name,
                  label: "Manager Name *",
                  validator: (p0) => Validation.instance.emptyField(p0),
                  hintText: "Enter Manager Name",
                  onChanged: (p0) => setState(() {
                    managerName = p0;
                  }),
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  textInputType: TextInputType.phone,
                  label: "Manager Contact *",
                  hintText: "Enter Manager Contact",
                  validator: (p0) =>
                      Validation.instance.phoneNumberValidation(p0),
                  onChanged: (p0) => setState(() {
                    managerContact = p0;
                  }),
                ),
                SizedBox(height: dimensions.width * 0.03),
                Text(
                  "Property Assets *",
                  style: textStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: dimensions.width * 0.035),
                ),
                SizedBox(height: dimensions.width * 0.015),
                Consumer<PropertyProvider>(builder: (context, val, _) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: val.propertyAssets.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InkWellWidget(
                      onTap: () => setState(() {
                        if (selectedPropertyAssets
                            .contains(val.propertyAssets[index].id ?? "")) {
                          selectedPropertyAssets
                              .remove(val.propertyAssets[index].id ?? "");
                        } else {
                          selectedPropertyAssets
                              .add(val.propertyAssets[index].id ?? "");
                        }
                      }),
                      child: PropertyAssetTile(
                          assetName: val.propertyAssets[index].name ?? "",
                          icon:
                              "${Endpoints.imageUrl}${val.propertyAssets[index].image}",
                          selectedPropertyAsset: selectedPropertyAssets
                              .contains(val.propertyAssets[index].id ?? "")),
                    ),
                  );
                }),
                SizedBox(height: dimensions.width * 0.03),
                const Divider(
                  thickness: 4,
                  color: Color(0xffF7F7F7),
                ),
                SizedBox(height: dimensions.width * 0.04),
                Center(
                  child: Text(
                    "Room Details",
                    style: textStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: dimensions.width * 0.04),
                  ),
                ),
                SizedBox(height: dimensions.width * 0.03),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: CustomTextField(
                                        validator: (p0) =>
                                            Validation.instance.emptyField(p0),
                                        icon: Assets.icons.roomNumber,
                                        onChanged: (p0) => setState(() {
                                              roomDetail[index].roomNumber = p0;
                                            }),
                                        hintText: "Room Number",
                                        textInputType: TextInputType.number)),
                                SizedBox(
                                  width: dimensions.width * 0.03,
                                ),
                                Expanded(
                                    child: CustomTextField(
                                  validator: (p0) =>
                                      Validation.instance.emptyField(p0),
                                  textInputType: TextInputType.number,
                                  icon: Assets.icons.totalBeds,
                                  onChanged: (p0) => setState(() {
                                    roomDetail[index].totalBeds = p0;
                                  }),
                                  hintText: "Total Beds",
                                ))
                              ],
                            ),
                            SizedBox(height: dimensions.width * 0.015),
                            Consumer<PropertyProvider>(
                                builder: (context, val, _) {
                              return ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                itemCount: val.propertyAssets.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, aIndex) => InkWellWidget(
                                  onTap: () => setState(() {
                                    if (roomDetail[index]
                                        .roomAmenities
                                        .contains(
                                            val.propertyAssets[aIndex].id ??
                                                "")) {
                                      roomDetail[index].roomAmenities.remove(
                                          val.propertyAssets[aIndex].id ?? "");
                                    } else {
                                      roomDetail[index].roomAmenities.add(
                                          val.propertyAssets[aIndex].id ?? "");
                                    }
                                  }),
                                  child: PropertyAssetTile(
                                      assetName:
                                          val.propertyAssets[aIndex].name ?? "",
                                      icon:
                                          "${Endpoints.imageUrl}${val.propertyAssets[aIndex].image}",
                                      selectedPropertyAsset: roomDetail[index]
                                          .roomAmenities
                                          .contains(
                                              val.propertyAssets[aIndex].id ??
                                                  "")),
                                ),
                              );
                            }),
                          ],
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: roomDetail.length),
                SizedBox(height: dimensions.width * 0.04),
                CustomButton(
                  icon: Assets.icons.addIconPlus,
                  backgroundColor: AppColors.lightButton,
                  textColor: AppColors.primary,
                  onPressed: () => setState(() {
                    roomDetail.add(PropertyRoomDetail([], "", "", ""));
                  }),
                  title: "Add More Rooms",
                ),
                SizedBox(height: dimensions.width * 0.05),
                CustomButton(
                  onPressed: () {
                    if (propertyImage == null ||
                        propertyImage?.path.isEmpty == true) {
                      alert(
                          type: AlertType.error,
                          message: "Property image is required*");
                      return;
                    }
                    if (selectedPropertyAssets.isEmpty) {
                      alert(
                          type: AlertType.error,
                          message: "Select property assets *");
                      return;
                    }
                    if (propertyItem == null) {
                      alert(
                          type: AlertType.error,
                          message: "Select property type");
                      return;
                    }

                    if (roomDetail
                        .any((element) => element.roomAmenities.isEmpty)) {
                      alert(
                          type: AlertType.error,
                          message: "Select room amenities *");
                      return;
                    }
                    if (formkey.currentState?.validate() == true) {
                      context.read<PropertyProvider>().addProperty(
                          address: address.trim(),
                          contact: managerContact.trim(),
                          image: propertyImage,
                          managerName: managerName.trim(),
                          name: name.trim(),
                          propertyAsset: selectedPropertyAssets,
                          propertyRoomDetails: roomDetail,
                          type: propertyItem?.id ?? "");
                    }
                  },
                  title: isEdit ? "Save" : "Add Property",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
