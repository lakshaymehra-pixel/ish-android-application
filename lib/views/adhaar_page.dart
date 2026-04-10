import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/aadhaar_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/HeadingText.dart';
import '../main.dart';
import '../utils/shared_constants.dart';

class AdhaarPage extends GetView<AadhaarController> {
  AdhaarPage({super.key}) ;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Obx(() {
      return CustomBackground(
        height: Get.height * 0.8,
        heightOfUpperBox: Get.height * 0.6,
        children: [
          SizedBox(
            height: 20.sp,
          ),
          CustomHeadingText(text2: 'Please fill in your work information', text1: "Verify Aadhaar Details "),
          SizedBox(
            height: 20.sp,
          ),
          CustomInputField(
            isEdit: controller.isEnabled.value,
            onEditPressed: () {
              controller.isEnabled.value = false;
              ShortMessage.toast(title: "Edit your number");
            },
            height: Get.height * 0.13,
            readOnly: controller.isEnabled.value,
            keyBroadType: TextInputType.number,
            textHeading: 'Enter your Aadhaar No.',
            hint: 'Enter your Aadhaar No.',
            isButton: false,
            maxLenght: 12,
            formatter: [FilteringTextInputFormatter.digitsOnly],
            controller: controller.aadhaarController.value,
            isLoading: controller.isLoadingOnSendOTP.value,
            onPressed: () {
              controller.sendAadhaarOTP(controller.aadhaarController.value.text);
            },
          ),
          // Pinput(
          //   defaultPinTheme: defaultPinTheme,
          //   focusedPinTheme: focusedPinTheme,
          //   submittedPinTheme: submittedPinTheme,
          //   validator: (s) {
          //     return s == '2222' ? null : 'Pin is incorrect';
          //   },
          //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          //   showCursor: true,
          //   onCompleted: (pin) => print(pin),
          // ),
          SizedBox(
            height: 30.sp,
          ),
          CustomButton(
            onPressed: () {
              var mobile = prefs.getString(SharedConstants.MOBILE);
              if (mobile.toString() != "9999999999") {
                if (controller.isLoadingProceed.value == false) {
                  controller.verifyOTP();
                } else {
                  ShortMessage.toast(title: "Please wait while we proceed");
                }
              } else {
                Get.toNamed(RoutesName.BankScreen);
              }
            },
            text: 'Proceed',
            height: Get.height * 0.06,
          ),
        ],
      );
    });
  }
}
