// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utilities/navigator.dart';

enum ImageType { gallery, camera }

class ImagePickerWidget extends StatelessWidget {
  ImagePickerWidget({super.key});

  static Future<File?> pickImage() async {
    final image = await showModalBottomSheet(
      showDragHandle: true,
      context: AppNavigator.shared.getContext(),
      builder: (context) => ImagePickerWidget(),
    );
    if (image != null) {
      return image;
    }
    return null;
  }

  List<ImageType> imageType = [ImageType.camera, ImageType.gallery];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          imageType.length,
          (index) => ListTile(
                onTap: () async {
                  if (imageType[index] == ImageType.camera) {
                    final picker = await ImagePicker.platform
                        .getImageFromSource(source: ImageSource.camera);
                    Navigator.of(context).pop(File(picker?.path ?? ""));
                  } else {
                    final picker = await ImagePicker.platform
                        .getImageFromSource(source: ImageSource.gallery);
                    Navigator.of(context).pop(File(picker?.path ?? ""));
                  }
                },
                title: Text(
                    "${imageType[index].name[0].toUpperCase()}${imageType[index].name.substring(1)}"),
              )),
    );
  }
}
