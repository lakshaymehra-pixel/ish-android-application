import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/loging_controller.dart';
import 'package:tejas_loan/services/api_constant/api_constants.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/image_constants.dart';
import 'package:tejas_loan/utils/shared_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';

class LogingPage extends GetView<LogingController> {
  const LogingPage({super.key});

  @override
  Widget build(BuildContext context) {

    if (!APIConstants.isModeDevelopment()) checkVersion(context);
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor,
            statusBarIconBrightness: ColorConstants.getBrightColorARD(context),
            statusBarBrightness: ColorConstants.getBrightColorIOS(context), // For iOS (dark icons)
          ),
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.sp),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: SizedBox(
                        height: Get.height * 0.16,
                        width: Get.width * 0.6,
                        child: Image.asset(
                          ImageConstants.logo,
                          // colorFilter: const ColorFilter.mode(Color(ColorConstants.primaryColor), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  Text('Welcome ', style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text('Enter your phone number to proceed', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 20),
                  Container(
                    height: Get.height * 0.075,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: (prefs.getBool(SharedConstants.THEME) ?? false)
                          ? const Color(ColorConstants.contrainerColorDark)
                          : Colors.grey.shade100.withOpacity(0.5),
                      border: Border.all(
                        color: !controller.isFoused.value ? Colors.grey.shade400 : Theme.of(context).primaryColor,
                        width: 6.sp,
                      ),
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: Get.height * 0.8,
                            width: 30.sp,
                            child: Text(
                              "+91 |",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: !controller.isFoused.value ? Colors.grey : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 65.sp,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            // focusNode: controller.focusNode.value,
                            controller: controller.numberController.value,
                            keyboardType: TextInputType.number,
                            onTap: () {
                              controller.isFoused.value = true;
                            },
                            maxLength: 10,
                            style: TextStyle(
                              letterSpacing: 10.sp,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.titleMedium?.color,
                            ),

                            maxLines: 1,
                            decoration: InputDecoration(
                              counter: const SizedBox(),
                              hintText: 'Phone Number',
                              hintStyle: Theme.of(context).textTheme.titleLarge,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.zero,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 1.sp, vertical: 1.sp),
                            ),
                            onTapOutside: (pointer) {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              controller.isFoused.value = false;
                            },
                            onFieldSubmitted: (value) {
                              controller.isFoused.value = false;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        side: BorderSide(color: Theme.of(context).shadowColor, width: 3.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.sp),
                        ),
                        value: controller.checkedValue.value,
                        onChanged: (bool? value) {
                          if (controller.checkedValue.value) {
                            controller.checkedValue.value = false;
                          } else {
                            controller.checkedValue.value = true;
                          }
                        },
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(right: 14.sp),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "To proceed with your loan application, kindly confirm your acceptance of our ",
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.titleMedium!.color,
                                      )),
                                  TextSpan(
                                      text: 'Terms and Conditions',
                                      style: TextStyle(color: Colors.blue, fontSize: 15.sp),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          // Get.to(
                                          //     TermsAndConditionsScreen());
                                          //
                                          await launchUrl(Uri.parse(SharedConstants.Terms_Condition_Url),
                                              mode: LaunchMode.inAppWebView);
                                        }),
                                  TextSpan(
                                      text: " , ",
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.titleMedium!.color,
                                      )),
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(color: Colors.blue, fontSize: 15.sp),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          // Get.to(PrivacyPolicyScreen());
                                          await launchUrl(Uri.parse(SharedConstants.Privacy_Policy_Url),
                                              mode: LaunchMode.inAppWebView);
                                        }),
                                  TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.titleMedium!.color,
                                      )),
                                  if (!controller.isReadMore.value)
                                    TextSpan(
                                        text: 'Read More ',
                                        style: TextStyle(color: Colors.blue, fontSize: 15.sp),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            controller.isReadMore.value = true;
                                          }),
                                  if (controller.isReadMore.value)
                                    TextSpan(
                                        text: "your consent to fetch your CIBIL score and "
                                            "I hereby authorize to send notifications on SMS, Calls, RCS.",
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.titleMedium!.color,
                                        )),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    height: Get.height * 0.06,
                    onPressed: () async {
                      if (controller.isLoadingOnRegister.value == false) {
                        if (controller.numberController.value.text.isEmpty) {
                          ShortMessage.toast(title: "Field Can't be empty");
                          return null;
                        }
                        if (controller.numberController.value.text == "9999999999") {
                          controller.sendOTP(controller.numberController.value.text);

                          return;
                        }
                        if (controller.checkedValue.isFalse) {
                          ShortMessage.toast(title: "Please accept terms and conditions");
                          return null;
                        } else if (["0", "1", "2", "3", "4", "5"]
                                .contains(controller.numberController.value.text.split("")[0].toString()) ||
                            controller.numberController.value.text.length < 10) {
                          ShortMessage.toast(title: "Please enter valid mobile number");
                          return null;
                        } else {
                          controller.sendOTP(controller.numberController.value.text);
                        }
                      } else {
                        ShortMessage.toast(title: "Please wait...");
                      }
                    },
                    text: 'Continue',
                    isLoading: controller.isLoadingOnRegister.value,
                  ),
                  SizedBox(height: 20.sp),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: 10.sp),
                  const InfoCard(
                    icon: Icons.timer,
                    title: '10 Minute Approval',
                    subtitle: 'Quick verification & instant decision',
                  ),
                  const InfoCard(
                    icon: Icons.currency_rupee,
                    title: 'Loan up to ₹1 Lakh',
                    subtitle: 'Flexible amount as per your need',
                  ),
                  const InfoCard(
                    icon: Icons.security,
                    title: 'Bank-grade Security',
                    subtitle: 'Bank-grade security for your data',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: (prefs.getBool(SharedConstants.THEME) ?? false)
              ? const Color(ColorConstants.contrainerColorDark)
              : const Color(0xFFEFF5FF),
          borderRadius: BorderRadius.circular(10.sp)),
      height: Get.height * 0.085,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 2.sp),
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15.sp),
          Icon(
            size: 25.sp,
            icon,
            color: Colors.blue,
          ),
          SizedBox(width: 15.sp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleMedium!.color),
              ),
              SizedBox(height: 2.sp),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 15.sp, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge!.color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
