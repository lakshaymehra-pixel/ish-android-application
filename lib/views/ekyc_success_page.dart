import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../custom_widgets/slideIn_animation.dart';

class EKYCSuccessPage extends StatelessWidget {
  const EKYCSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      // Background color relevant to success
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Center(
          child: SlideTransitionAnimation(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                    backgroundLoading: true,
                    frameRate: const FrameRate(60),
                    fit: BoxFit.fitHeight,
                    height: 55.sp,
                    width: 55.sp,
                    repeat: false,
                    'https://lottie.host/07f22094-2144-4c1f-8fd7-e878afb7ac41/mg3s1WtVZR.json'),
                const SizedBox(height: 20),
                const Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your eKYC has been successfully completed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
