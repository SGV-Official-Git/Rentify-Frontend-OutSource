import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/error_dialog.dart';

class HelperMethods {
  static final instance = HelperMethods();

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '$hours hrs $minutes mins';
  }

  Uri getUri(String baseUrl) {
    return Uri.parse(baseUrl);
  }

  dynamic handleMemotyImage(icon) {
    try {
      final imageProvider = MemoryImage(icon);
      return imageProvider;
    } catch (e) {
      alert(type: AlertType.error, message: "$e");
    }
  }

  String dateFormat(DateTime? date) {
    if (date != null) {
      return DateFormat("dd-MMM-yyyy").format(date);
    } else {
      return "N/A";
    }
  }

  String dateFormatMonth(DateTime? date) {
    if (date != null) {
      return DateFormat("dd MMMM yyyy").format(date);
    } else {
      return "N/A";
    }
  }
}
