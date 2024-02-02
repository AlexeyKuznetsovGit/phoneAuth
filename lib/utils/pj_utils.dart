import 'dart:io';
import 'package:permission_handler/permission_handler.dart' as perm;

class PjUtils{
  static String textError = 'Что-то пошло не так!';

}

Future<bool> getCameraPermission() async {
  if (Platform.isAndroid) {
    return true;
  }
  var status = await perm.Permission.camera.status;
  if (status.isPermanentlyDenied) {
    perm.openAppSettings();
    return false;
  }
  return true;
}

Future<bool> getGalleryPermission() async {
  if (Platform.isAndroid) {
    return true;
  }
  var status = await perm.Permission.photos.status;
  if (status.isPermanentlyDenied) {
    perm.openAppSettings();
    return false;
  }
  return true;
}