import 'package:get/get.dart';

import '../custom_widgets/update_dialog.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../services/app_update_service.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    _checkUpdateThenNavigate();
    super.onInit();
  }

  void _navigate() {
    if (prefs.getBool(SharedConstants.ISLOGIN).toString() == "null" ||
        (prefs.getBool(SharedConstants.ISLOGIN) == false)) {
      Get.toNamed(RoutesName.LoginScreen);
    } else {
      if (prefs.getString(SharedConstants.STEP_STAGE) == Events.PANCARD) {
        Get.offAllNamed(RoutesName.PanScreen);
      } else {
        Get.offAllNamed(RoutesName.DashbroadScreen);
      }
    }
  }

  void _checkUpdateThenNavigate() {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      final updateInfo = await AppUpdateService.checkForUpdate();
      if (updateInfo != null) {
        Get.dialog(UpdateDialog(updateInfo: updateInfo), barrierDismissible: false);
      }
      _navigate();
    });
  }
}
