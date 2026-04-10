import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/loging_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../utils/color_constants.dart';
import '../utils/image_constants.dart';

class OtpScreen extends GetView<LogingController> {
  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: Get.width * 0.15,
      height: Get.height * 0.07,
      margin: EdgeInsets.all(10.sp),
      textStyle:
          TextStyle(fontSize: 20, color: Theme.of(context).textTheme.titleMedium!.color, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 6.sp),
          borderRadius: BorderRadius.circular(17.sp),
          color: Theme.of(context).highlightColor),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).primaryColor, width: 6.sp),
      borderRadius: BorderRadius.circular(16.sp),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.transparent,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: ColorConstants.getBrightColorARD(context),
          statusBarBrightness: ColorConstants.getBrightColorIOS(context),
        ),
        toolbarHeight: 0,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.sp),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp),
                    child: SizedBox(
                      height: Get.height * 0.16,
                      width: Get.width * 0.65,
                      child: Image.asset(
                        ImageConstants.logo,
                        // colorFilter: const ColorFilter.mode(Color(ColorConstants.primaryColor), BlendMode.srcIn),
                        // semanticsLabel: '',
                      ),
                    ),
                  ),
                  SizedBox(height: 27.sp),
                  Text(
                    'OTP has been sent to ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge!.color,
                    ),
                  ),
                  Text(
                    '+91 ${controller.numberController.value.text.substring(0, 5)} ${controller.numberController.value.text.substring(5, 10)}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      controller.OTP.value = pin;
                    },
                    onTapOutside: (_) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // controller.OTP.value = pin;
                    },
                    onChanged: (pin) {
                      controller.OTP.value = pin;
                    },
                  ),
                  SizedBox(height: 30.sp),
                  Text(
                    'Didn’t receive OTP? ',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge!.color,
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  controller.isResend.value
                      ? InkWell(
                          onTap: () {
                            controller.isResend.value == false;
                            // print("Resend pressed");
                            controller.reSendOTP();
                          },
                          child: Text(
                            "RESEND",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700, fontSize: 17.sp),
                          ),
                        )
                      : Countdown(
                          controller: controller.countdown_controller.value,
                          seconds: 60,
                          build: (BuildContext context, double time) => Text('Resend Otp in ${time.toInt()}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700, fontSize: 17.sp)),
                          interval: const Duration(milliseconds: 100),
                          onFinished: () {
                            if (kDebugMode) {
                              print("DONE");
                            }
                            controller.isResend.value = true;
                            // controller.isResend.refresh();
                          },
                        ),
                  SizedBox(height: 30.sp),
                  CustomButton(
                      height: Get.height * 0.07,
                      onPressed: () {
                        controller.register();
                      },
                      isLoading: controller.isLoadingOnRegister.value,
                      text: "Verify & Proceed"),
                  SizedBox(height: 30.sp),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesName.LoginScreen);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 15.sp),
                        Text(
                          'Change Phone Number',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        );
      }),
    );
  }
}
