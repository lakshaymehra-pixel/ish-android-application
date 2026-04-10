import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

class ShortMessage {
  static toast({required String title, int duration = 1}) {
    return Fluttertoast.showToast(
        msg: title,
        backgroundColor: Get.theme.shadowColor,
        textColor: Get.theme.scaffoldBackgroundColor,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: duration,
        fontSize: 16.0);
  }

  static snackBar({required String title, int? duration = 1}) {
    return Get.showSnackbar(GetSnackBar(
      message: title,
      duration: Duration(seconds: duration!),
    ));
  }
}

// class UrlLauncher {
//   launchUri({required String url, required LaunchMode mode}) async {
//     if (!await launchUrl(Uri.parse(url),
//         mode: LaunchMode.externalApplication)) {
//       throw Exception('Could not launch $url');
//     }
//   }
// }
