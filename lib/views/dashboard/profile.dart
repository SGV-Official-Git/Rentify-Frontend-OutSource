import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/data/user_modal.dart';
import 'package:rentify/main.dart';
import 'package:rentify/providers/profile_provider.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/keys.dart';
import 'package:rentify/utilities/sp.dart';
import 'package:rentify/views/dialogs/logout_dialog.dart';
import 'package:rentify/widgets/custom_app_bar.dart';
import 'package:rentify/widgets/custom_button.dart';
import 'package:rentify/widgets/custom_text_field.dart';
import 'package:rentify/widgets/image_picker_widget.dart';

import '../../widgets/profile_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? profileImage;
  bool isEditable = true;

  UserData? userData;

  final name = TextEditingController(),
      email = TextEditingController(),
      phone = TextEditingController(),
      address = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final userData = SP.i.getString(key: SPKeys.userData);
      setState(() {
        this.userData = UserData.fromJson(jsonDecode(userData ?? ""));
        name.text = this.userData?.fullName ?? "";
        email.text = this.userData?.email ?? "";
        phone.text = this.userData?.phone ?? "";
        address.text = this.userData?.address ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        automaticallyImplyLeading: false,
        actions: [
          Visibility(
            visible: isEditable,
            child: IconButton(
                onPressed: () => setState(() {
                      isEditable = !isEditable;
                      // FocusScope.of(context).nextFocus();
                    }),
                icon: const Icon(Icons.edit)),
          ),
          IconButton(
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const LogOutDialog(),
                  ),
              icon: const Icon(Icons.logout_outlined)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Center(
            child: ProfileImage(
              isEdit: isEditable,
              profileUrl: userData?.profileImage,
              onTap: () async {
                final image = await ImagePickerWidget.pickImage();
                if (image != null) {
                  setState(() {
                    profileImage = image;
                  });
                }
              },
              profileImage: profileImage,
            ),
          ),
          SizedBox(height: dimensions.width * 0.03),
          if (!isEditable)
            Center(
              child: Text(
                "Change Profile",
                style: textStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                    fontSize: dimensions.width * 0.035),
              ),
            ),
          SizedBox(height: dimensions.width * 0.03),
          CustomTextField(
            label: "Full Name",
            readOnly: isEditable,
            controller: name,
            textInputType: TextInputType.name,
            hintText: "Enter Full Name",
          ),
          SizedBox(height: dimensions.width * 0.03),
          CustomTextField(
            readOnly: true,
            label: "Email",
            controller: email,
            textInputType: TextInputType.emailAddress,
            hintText: "Enter Email",
          ),
          SizedBox(height: dimensions.width * 0.03),
          CustomTextField(
            readOnly: isEditable,
            label: "Phone Number",
            controller: phone,
            textInputType: TextInputType.phone,
            hintText: "Enter Phone Number",
          ),
          SizedBox(height: dimensions.width * 0.03),
          CustomTextField(
            readOnly: isEditable,
            label: "Address",
            controller: address,
            textInputType: TextInputType.streetAddress,
            hintText: "Enter Address",
          ),
          if (!isEditable) SizedBox(height: dimensions.width * 0.04),
          if (!isEditable)
            CustomButton(
              title: "Update",
              onPressed: () async {
                await context.read<ProfileProvider>().updateProfile(
                    address: address.text.trim(),
                    email: email.text.trim(),
                    image: profileImage,
                    name: name.text.trim(),
                    phone: phone.text.trim());
                setState(() {
                  isEditable = !isEditable;
                });
              },
            )
        ],
      ),
    );
  }
}
