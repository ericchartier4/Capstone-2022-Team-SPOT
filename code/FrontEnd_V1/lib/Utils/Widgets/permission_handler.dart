import 'package:demo/Utils/Widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerPermissionService {
  static Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  static Future<PermissionStatus> requestStoragePermission() async {
    return await Permission.storage.request();
  }

  static Future<bool> handleCameraPermission(BuildContext context) async {
    PermissionStatus cameraPermissionStatus = await requestCameraPermission();
    if (cameraPermissionStatus == PermissionStatus.permanentlyDenied) {
      await showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            title: 'Camera Permission',
            subtitle:
                'Camera permission should be granted to use this feature, would you like to go to app settings to give camera permission?',
            onConfirm: () {
              openAppSettings();
            },
          );
        },
      );
      return false;
    } else if (cameraPermissionStatus == PermissionStatus.denied) {
      return false;
    }
    return true;
  }

  static Future<bool> handleStoragePermission(BuildContext context) async {
    PermissionStatus storagePermissionStatus = await requestStoragePermission();
    if (storagePermissionStatus == PermissionStatus.permanentlyDenied) {
      await showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            onConfirm: () {
              Get.back();
              return openAppSettings();
            },
            title: 'Storage Permission',
            subtitle:
                'Storage permission should be granted to use this feature, would you like to go to app settings to give storage permission?',
          );
        },
      );
      return false;
    } else if (storagePermissionStatus == PermissionStatus.denied) {
      return false;
    }
    return true;
  }
}
