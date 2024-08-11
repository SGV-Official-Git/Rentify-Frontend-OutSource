// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/data/property_item_modal.dart';
import 'package:rentify/data/room_and_bed_item.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/providers/tenent_provider.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/utilities/helper_func.dart';
import 'package:rentify/utilities/validations.dart';
import 'package:rentify/widgets/custom_app_bar.dart';
import 'package:rentify/widgets/custom_text_field.dart';
import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/image.dart';
import 'package:rentify/widgets/image_picker_widget.dart';
import 'package:rentify/widgets/tap_widget.dart';

import '../../data/add_property_asset_modal.dart';
import '../../data/rent_frequency_modal.dart';
import '../../theme/textstyles.dart';
import '../../widgets/add_property_asset_widget.dart';
import '../../widgets/custom_button.dart';

class AddNewTenant extends StatefulWidget {
  const AddNewTenant({super.key});

  @override
  State<AddNewTenant> createState() => _AddNewTenantState();
}

class _AddNewTenantState extends State<AddNewTenant> {
  List<AddPropertyAsset> addPropertyTenant = [AddPropertyAsset("", 0)];
  String tenantName = '',
      rentAmount = '',
      mobileNumber = '',
      emContactNumber = '',
      depositeAmount = '',
      emContactName = '',
      permanentAddress = '',
      documentName = '',
      purposeOfStay = '',
      currentMeter = '',
      pricePerUnit = '';

  DateTime? billingDate;

  File? tenantImage, ducumentImage;

  PropertyItem? 
  property;
  RentFrequency? rentFrequency;
  RoomAndrBedItem? roomAndrBedItem;
  String? roomNumber;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<TenantProvider>().rentFrequencyListApi();

      property = ModalRoute.of(context)?.settings.arguments as PropertyItem;
      setState(() {});
      await context
          .read<TenantProvider>()
          .getRoomAndBed(propertyId: property?.id ?? "");
    });
  }

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
            key: formKey,
            //  autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                CustomTextField(
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Name *",
                  textInputType: TextInputType.name,
                  hintText: "Enter Name",
                  onChanged: (p0) => setState(() {
                    tenantName = p0;
                  }),
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  textInputType: TextInputType.number,
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Rent Amount *",
                  onChanged: (p0) => setState(() {
                    rentAmount = p0;
                  }),
                  hintText: "\$ 0.00",
                  icon: Assets.icons.navCollectionActive,
                ),
                  SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Deposite Amount *",
                  hintText: "Enter Deposite Amount",
                  textInputType: TextInputType.number,
                  icon: Assets.icons.navCollectionActive,
                  onChanged: (p0) => setState(() {
                    depositeAmount = p0;
                  }),
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  label: "Mobile Number *",
                  validator: (p0) =>
                      Validation.instance.phoneNumberValidation(p0),
                  textInputType: TextInputType.number,
                  hintText: "Enter Mobile Number",
                  onChanged: (p0) => setState(() {
                    mobileNumber = p0;
                  }),
                  icon: Assets.icons.call,
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  validator: (p0) =>
                      Validation.instance.phoneNumberValidation(p0),
                  label: "Emergency Contact Number *",
                  hintText: "Enter Emergency Contact",
                  textInputType: TextInputType.number,
                  icon: Assets.icons.call,
                  onChanged: (p0) => setState(() {
                    emContactNumber = p0;
                  }),
                ),
            
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  onChanged: (p0) => setState(() {
                    emContactName = p0;
                  }),
                  textInputType: TextInputType.name,
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Emergency Contact Name *",
                  hintText: "Enter Emergency Contact Name",
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  onChanged: (p0) => setState(() {
                    permanentAddress = p0;
                  }),
                  label: "Permanent Address *",
                  validator: (p0) => Validation.instance.emptyField(p0),
                  textInputType: TextInputType.streetAddress,
                  hintText: "Enter Permanent Address",
                ),
                SizedBox(height: dimensions.width * 0.03),
                InkWellWidget(
                  onTap: () async {
                    final image = await ImagePickerWidget.pickImage();
                    if (image != null) {
                      tenantImage = image;
                      setState(() {});
                    }
                  },
                  child:
                      tenantImage == null || tenantImage?.path.isEmpty == true
                          ? ImageWidget(
                              url: Assets.icons.addTenantImage,
                              width: dimensions.width,
                            )
                          : ImageWidget<File>(
                              imageFile: tenantImage,
                              width: dimensions.width,
                              height: dimensions.width * 0.5,
                            ),
                ),
                SizedBox(height: dimensions.width * 0.03),
                InkWellWidget(
                  onTap: () async {
                    final image = await ImagePickerWidget.pickImage();
                    if (image != null) {
                      ducumentImage = image;
                      setState(() {});
                    }
                  },
                  child: ducumentImage == null ||
                          ducumentImage?.path.isEmpty == true
                      ? ImageWidget(
                          url: Assets.icons.addDocuments,
                          width: dimensions.width,
                        )
                      : ImageWidget<File>(
                          imageFile: ducumentImage,
                          width: dimensions.width,
                          height: dimensions.width * 0.3,
                        ),
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  onChanged: (p0) => setState(() {
                    documentName = p0;
                  }),
                  textInputType: TextInputType.name,
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Document  Number *",
                  hintText: "Aadhar/PAN/Driving License No",
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  onChanged: (p0) => setState(() {
                    purposeOfStay = p0;
                  }),
                  textInputType: TextInputType.multiline,
                  label: "Purpose of Stay *",
                  hintText: "Purpose of Stay",
                  validator: (p0) => Validation.instance.emptyField(p0),
                ),
                SizedBox(height: dimensions.width * 0.03),
                Consumer<TenantProvider>(
                  builder: (context, value, child) =>
                      CustomTextField<RentFrequency>(
                    trailingIcon: Assets.icons.arrowDown,
                    onChanged: (p0) {
                      rentFrequency = (p0 as RentFrequency);
                      setState(() {});
                    },
                    label: "Rent Frequency *",
                    isDropdown: true,
                    items: value.rentFrequency,
                    hintText: "Rent Frequency",
                  ),
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  icon: Assets.icons.billingDate,
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Billing Date *",
                  controller: TextEditingController(
                      text:
                          HelperMethods.instance.dateFormatMonth(billingDate)),
                  readOnly: true,
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)));
                    if (date != null) {
                      billingDate = date;
                      setState(() {});
                    }
                  },
                  hintText: "Billing Date",
                ),
                SizedBox(height: dimensions.width * 0.03),
                const Divider(
                  thickness: 4,
                  color: Color(0xffF7F7F7),
                ),
                SizedBox(height: dimensions.width * 0.04),
                Consumer<TenantProvider>(
                  builder: (context, value, child) => Row(
                    children: [
                      Expanded(
                        child: CustomTextField<RoomAndrBedItem>(
                          trailingIcon: Assets.icons.arrowDown,
                          onChanged: (p0) {
                            roomAndrBedItem = (p0 as RoomAndrBedItem);
                            roomNumber = "";
                            setState(() {});
                          },
                          label: "Room allocated *",
                          isDropdown: true,
                          items: value.roomANDbeds,
                          hintText: "Room allocated",
                        ),
                      ),
                      SizedBox(width: dimensions.width * 0.03),
                      Expanded(
                        child: CustomTextField<String>(
                          selectedItem: roomNumber ?? "",
                          trailingIcon: Assets.icons.arrowDown,
                          onChanged: (p0) {
                            roomNumber = (p0 as String);
                            setState(() {});
                          },
                          label: "Bed allocated *",
                          isDropdown: true,
                          items: List.generate(
                              int.parse(roomAndrBedItem?.roomBeds ?? "0"),
                              (index) => (index + 1).toString()),
                          hintText: "Bed allocated",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: dimensions.width * 0.04),
                Center(
                  child: Text(
                    "Property Assets",
                    style: textStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: dimensions.width * 0.04),
                  ),
                ),
                SizedBox(height: dimensions.width * 0.04),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => AddPropertyAssetWidget(
                          count: addPropertyTenant[index].quantity,
                          increase: () => setState(() {
                            addPropertyTenant[index].quantity++;
                          }),
                          decrease: () => setState(() {
                            if (addPropertyTenant[index].quantity > 0) {
                              addPropertyTenant[index].quantity--;
                            }
                          }),
                          onChanged: (p0) => setState(() {
                            addPropertyTenant[index].name = p0 ?? "";
                          }),
                        ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: addPropertyTenant.length),
                SizedBox(height: dimensions.width * 0.04),
                CustomButton(
                  onPressed: () => setState(() {
                    addPropertyTenant.add(AddPropertyAsset("", 0));
                  }),
                  backgroundColor: AppColors.lightButton,
                  textColor: AppColors.primary,
                  title: "Add More",
                ),
                SizedBox(height: dimensions.width * 0.03),
                const Divider(
                  thickness: 4,
                  color: Color(0xffF7F7F7),
                ),
                SizedBox(height: dimensions.width * 0.04),
                Text(
                  "Electricity",
                  style: textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: dimensions.width * 0.04),
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  validator: (p0) => Validation.instance.emptyField(p0),
                  onChanged: (p0) => setState(() {
                    currentMeter = p0;
                  }),
                  label: "Current Meter *",
                  hintText: "Enter Current Meter",
                ),
                SizedBox(height: dimensions.width * 0.03),
                CustomTextField(
                  icon: Assets.icons.navCollectionActive,
                  validator: (p0) => Validation.instance.emptyField(p0),
                  label: "Price per unit *",
                  onChanged: (p0) => setState(() {
                    pricePerUnit = p0;
                  }),
                  hintText: "\$ 0.00",
                ),
                SizedBox(height: dimensions.width * 0.04),
                CustomButton(
                  onPressed: () {
                    if (property == null) {
                      alert(
                          type: AlertType.error,
                          message: "Please select a property");
                      return;
                    }
                    if (tenantImage == null ||
                        tenantImage?.path.isEmpty == true) {
                      alert(
                          type: AlertType.error,
                          message: "Please select tenant image");
                      return;
                    }
                    if (ducumentImage == null ||
                        ducumentImage?.path.isEmpty == true) {
                      alert(
                          type: AlertType.error,
                          message: "Please select document image");
                      return;
                    }
                    if (formKey.currentState?.validate() == true) {
                      context.read<TenantProvider>().addTenantApi(
                          bedAllocated: roomNumber ?? "",
                          roomAllocated: roomAndrBedItem?.id ?? "",
                          name: tenantName,
                          mobile: mobileNumber,
                          rentAmount: rentAmount,
                          nameemContactName: emContactName,
                          emContactNumber: emContactNumber,
                          tenantDocNumber: documentName,
                          meter: currentMeter,
                          rentFrequency: rentFrequency,
                          pricePerUnit: pricePerUnit,
                          depositeAmount: depositeAmount,
                          tenantPermanentAddress: permanentAddress,
                          tenantDoc: ducumentImage,
                          tPurposeofStay: purposeOfStay,
                          propertyId: property?.id ?? "",
                          billingDate: billingDate ?? DateTime.now(),
                          propAssets: addPropertyTenant,
                          tenantImage: tenantImage);
                    }
                  },
                  title: "Add Tenant",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
