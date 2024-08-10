// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/widgets/image.dart';
import 'package:rentify/widgets/tap_widget.dart';

class ProfileImage extends StatelessWidget {
  File? profileImage;
  String? profileUrl;
  VoidCallback? onTap;
  bool isEdit;
  ProfileImage(
      {super.key,
      this.profileUrl,
      this.isEdit = false,
      this.onTap,
      this.profileImage});

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: !isEdit ? onTap : null,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: dimensions.width * 0.3,
        width: dimensions.width * 0.3,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: profileImage == null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  ImageWidget(
                    url: profileUrl == null
                        ? Assets.icons.rentUser
                        : "${Endpoints.imageUrl}$profileUrl",
                    height: dimensions.width * 0.3,
                    width: dimensions.width * 0.3,
                    fit: BoxFit.cover,
                  ),
                  if (!isEdit)
                    Positioned.fill(
                      child: Container(
                        height: dimensions.width * 0.3,
                        width: dimensions.width * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle),
                      ),
                    ),
                  if (!isEdit)
                    ImageWidget(
                      url: Assets.icons.profileCamera,
                      height: dimensions.width * 0.1,
                      width: dimensions.width * 0.1,
                    ),
                ],
              )
            : ImageWidget<File>(
                imageFile: profileImage,
                fit: BoxFit.cover,
                height: dimensions.width * 0.1,
                width: dimensions.width * 0.1,
              ),
      ),
    );
  }
}
