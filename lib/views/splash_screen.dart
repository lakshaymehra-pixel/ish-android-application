import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/image_constants.dart';

import '../controller/splash_controller.dart';
import '../utils/shared_constants.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  SplashController con = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    // SystemChannels.lifecycle.setMessageHandler((msg) {
    //   debugPrint('SystemChannels> $msg');
    //   if (msg == AppLifecycleState.resumed.toString()) {
    //     requestPermissions();
    //   }
    //   return Future.value();
    // });

    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.all(15),
        child: Image.asset(
          ImageConstants.logo,
          // colorFilter: ,
          // semanticsLabel: 'Red dash paths',
        ));
  }
}
