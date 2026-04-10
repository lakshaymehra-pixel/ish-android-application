import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CustomPinView extends StatelessWidget {
  Function(String)? onChanged;
  Function(String)? onCompleted;
  Function(bool)? onFocusChange;
  var countdown_controller;
  var height;
  Function()? onPressed;
  Function()? onResendPressed;
  Function()? onResendFinished;
  var isEnabled;
  var isResend;
  var isEnabledResend;
  var numberOfFields;

  CustomPinView(
      {Key? key,
      this.onChanged,
      this.onCompleted,
      this.onFocusChange,
      this.countdown_controller,
      this.onResendPressed,
      this.isResend = false,
      this.isEnabledResend = false,
      this.onResendFinished,
      required this.isEnabled,
      this.numberOfFields = 6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StreamController<ErrorAnimationType> errorController =
        StreamController<ErrorAnimationType>();
    return SizedBox(
      height: Get.height * 0.29,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 12.sp),
                child: FittedBox(
                  child: Text(
                    "Please enter the OTP",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.sp),
                  ),
                ),
              ),
              const Text(
                "*",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          Center(
            child: Card(
              color: const Color(ColorConstants.primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20.sp, right: 23.sp, top: 15.sp),
                child: Focus(
                  onFocusChange: onFocusChange,
                  child: PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    enableActiveFill: true,

                    boxShadows: const [
                      BoxShadow(
                        color: Colors.white,
                      ),
                      BoxShadow(
                        color: Colors.white,
                      ),
                      BoxShadow(
                        color: Colors.white,
                      ),
                      BoxShadow(
                        color: Colors.white,
                      ),
                      BoxShadow(
                        color: Colors.white,
                      ),
                    ],

                    // backgroundColor: Color(ColorConstants.primaryColor),
                    pinTheme: PinTheme(
                      fieldHeight: 30.sp,
                      fieldWidth: 30.sp,
                      shape: PinCodeFieldShape.circle,
                      errorBorderColor: Colors.white,
                      inactiveColor: const Color(ColorConstants.primaryColor),
                      activeColor: const Color(ColorConstants.primaryColor),
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeFillColor: Colors.white,
                      inActiveBoxShadow: [
                        const BoxShadow(color: Colors.white),
                        const BoxShadow(color: Colors.white),
                        const BoxShadow(color: Colors.white),
                        const BoxShadow(color: Colors.white),
                      ],
                      activeBoxShadow: [
                        const BoxShadow(color: Colors.white),
                        const BoxShadow(color: Colors.white),
                        const BoxShadow(color: Colors.white),
                        const BoxShadow(color: Colors.white),
                      ],
                    ),
                    animationDuration: const Duration(milliseconds: 100),
                    errorAnimationController: errorController,
                    onChanged: onChanged,
                    appContext: context,
                    onSubmitted: onCompleted,
                  ),
                  // OtpTextField(
                  //   styles: numberOfFields == 4
                  //       ? [
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //         ]
                  //       : [
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //           TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16.sp),
                  //         ],
                  //   numberOfFields: numberOfFields,
                  //   fieldWidth: 8.5.w,
                  //   enabledBorderColor: Colors.black54,
                  //   focusedBorderColor: Colors.blue,
                  //   enabled: isEnabled ? true : false,
                  //   showFieldAsBox: false,
                  //   borderWidth: 3.0,
                  //   //runs when a code is typed in
                  //   onCodeChanged: onChanged,
                  //   //runs when every textfield is filled
                  //   onSubmit: onCompleted,
                  // ),
                ),
              ),
            ),
          ),
          if (isEnabledResend)
            Padding(
              padding: EdgeInsets.only(left: 10.sp, top: 15.sp),
              child: Countdown(
                controller: countdown_controller,
                seconds: 60,
                build: (BuildContext context, double time) => SizedBox(
                    height: 40.sp,
                    width: 40.sp,
                    child: SizedBox(
                      height: 200.0.sp,
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 200.sp,
                              height: 200.sp,
                              child: CircularProgressIndicator(
                                strokeWidth: 11.sp,
                                valueColor: const AlwaysStoppedAnimation(
                                  Colors.green,
                                ),
                                backgroundColor: Colors.grey,
                                strokeCap: StrokeCap.round,
                                value: (time * 1.6667) / 100,
                              ),
                            ),
                          ),
                          Center(
                              child: Container(
                            width: 35.sp,
                            alignment: Alignment.center,
                            child: isResend == false
                                ? Text(
                                    textAlign: TextAlign.center,
                                    'Resend in ${(time).toInt()}',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: isResend
                                            ? Colors.blue
                                            : Colors.black))
                                : InkWell(
                                    onTap: onResendPressed,
                                    child: Text(
                                      "RESEND",
                                      style: TextStyle(
                                          color: const Color(
                                              ColorConstants.primaryColor),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          )),
                        ],
                      ),
                    )),
                interval: const Duration(milliseconds: 100),
                onFinished: onResendFinished,
              ),
            )
                      ],
                    ),
        ],
      ),
    );
  }
}
