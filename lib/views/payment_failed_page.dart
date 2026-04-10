import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/custom_widgets/CustomBackground.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/routes/routes_names.dart';

class PaymentFailedPage extends StatelessWidget {
  const PaymentFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(heightOfUpperBox: 0, children: [
      SizedBox(height: 40.sp),
      Lottie.network(
          backgroundLoading: true,
          frameRate: const FrameRate(60),
          fit: BoxFit.fitHeight,
          height: 45.sp,
          width: 45.sp,
          repeat: false,
          'https://lottie.host/ad47f861-8db9-47f9-8882-8ceb8d62ace6/mqm2KrgzXq.json'),
      SizedBox(height: 20.sp),
      const Text(
        "Payment Failed!",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      SizedBox(height: 20.sp),
      Text(
        "Your Payment has been failed. Please try again.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).textTheme.titleLarge!.color,
        ),
      ),
      SizedBox(height: 40.sp),
      CustomButton(
        height: Get.height * 0.06,
        onPressed: () {
          Get.offAllNamed(RoutesName.DashbroadScreen);
        },
        text: "Go to Dashboard",
      )
    ]);
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
