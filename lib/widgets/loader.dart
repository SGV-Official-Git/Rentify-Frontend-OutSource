import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../theme/colors.dart';
import '../utilities/navigator.dart';
import 'error_dialog.dart';

class Loader {
  static OverlayEntry? _currentLoader;

  static Future<void> show() async {
    _currentLoader = OverlayEntry(
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: Container(
            color: Colors.black.withOpacity(0.4),
          )),
          Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.primary.withOpacity(0.5),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            // child: Container(
            //   height: 100,
            //   width: 100,
            //   clipBehavior: Clip.hardEdge,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   // child: const CircularProgressIndicator.adaptive(),
            //   child: WebViewWidget(controller: _webController!),
            // ),
          ),
        ],
      ),
    );
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final overlayState =
            AppNavigator.shared.navigatorKey.currentState?.overlay;
        if (overlayState != null && _currentLoader != null) {
          overlayState.insert(_currentLoader!);
        }
      });
    } catch (e) {
      log("$e");
      alert(type: AlertType.error, message: "$e");
    }
  }

  static void hide() {
    if (_currentLoader != null) {
      try {
        _currentLoader?.remove();
      } catch (e) {
        alert(type: AlertType.error, message: "$e");
      } finally {
        _currentLoader = null;
      }
    }
  }

  static WebViewController? _webController;

  static void init(String loaderfile) {
    _webController = WebViewController();
    _webController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    _webController?.enableZoom(false);
    _webController?.loadFlutterAsset(loaderfile);
  }
}
