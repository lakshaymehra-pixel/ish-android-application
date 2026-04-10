import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/custom_widgets/CustomBackground.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/routes/routes_names.dart';

import '../main.dart';
import '../utils/shared_constants.dart';

class EligiblityFaliedPage extends StatelessWidget {
  DashbroadController controller = Get.put(DashbroadController());

  EligiblityFaliedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.offAllNamed(RoutesName.DashbroadScreen);
          return Future.value(false);
        },
        child: CustomBackground(heightOfUpperBox: 0, children: [
          SizedBox(height: 30.sp),
          Icon(
            Icons.error_rounded,
            color: Colors.redAccent,
            size: 50.sp,
          ),
          SizedBox(
            width: Get.width,
            child: const Text(
              textAlign: TextAlign.center,
              "Oops!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ),
          SizedBox(height: 40.sp),
          // SizedBox(height: 20),
          // SizedBox(height: 10),
          Text(
            prefs.getString(SharedConstants.REJECT_REASON) ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          SizedBox(height: 40.sp),
          // Text(
          //     "Click on the button below to go to \n\n dashboard \n\n"
          //     "to get more details",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(fontSize: 17.sp, color: Colors.black54, fontWeight: FontWeight.w600)),
          // SizedBox(height: 30.sp),
          CustomButton(
            onPressed: () {
              Get.offAllNamed(RoutesName.DashbroadScreen);
            },
            text: "Go to Dashboard",
            height: Get.height * 0.06,
          ),
        ]));
  }
}

// Container(
//   height: 100.sp,
//   width: 50.sp,
//   child: Lottie.network(
//     onLoaded: (a) {
//       print(a.seconds);
//     },
//     // Success Animation
//     'https://lottie.host/07f22094-2144-4c1f-8fd7-e878afb7ac41/mg3s1WtVZR.json',
//     // Failed Animation
//     // 'https://lottie.host/ad47f861-8db9-47f9-8882-8ceb8d62ace6/mqm2KrgzXq.json',
//     repeat: false,
//   ),
// ),
