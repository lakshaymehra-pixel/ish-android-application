import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/occupation_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';

import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../utils/shared_constants.dart';

class OccupationPage extends GetView<OccupationController> {
  const OccupationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomBackground(
        isAppBarVisible: false,
        enableBottomNav: false,
        height: Get.height * 0.8,
        heightOfUpperBox: Get.height * 0.6,
        children: [
          SizedBox(
            height: 20.sp,
          ),
          CustomHeadingText(
            text1: "Please Confirm Your Details",
            text2: "Select Occupation Type",
          ),
          SizedBox(
            height: 40.sp,
          ),
          Container(
            height: Get.height * 0.3,
            width: Get.width,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5.sp),
                  child: Row(
                    children: [
                      Text(
                        "Select Occupation Type",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.sp,
                            color: Theme.of(context).textTheme.titleMedium!.color),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  height: Get.height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: controller.selected.value == 0 ? Colors.green : Colors.black),
                      borderRadius: BorderRadius.circular(7)),
                  child: ListTile(
                    onTap: () {
                      controller.selected.value = 0;
                    },
                    leading: controller.selected.value == 0
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20.sp,
                          )
                        : Icon(
                            Icons.circle_outlined,
                            size: 20.sp,
                          ),
                    title: Text(
                      "SALARIED",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    // subtitle: Text("Select this,if you receive monthly salary",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w500, fontSize: 15.sp)),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  height: Get.height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: controller.selected.value == 1 ? Colors.green : Colors.black),
                      borderRadius: BorderRadius.circular(7)),
                  child: ListTile(
                    onTap: () {
                      controller.selected.value = 1;
                    },
                    leading: controller.selected.value == 1
                        ? Icon(
                            size: 20.sp,
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.circle_outlined,
                            size: 20.sp,
                          ),
                    title: Text(
                      "SELF EMPLOYED",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    // subtitle: Text("Select this,if you run your on business",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w600, fontSize: 15.sp)),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                // Row(
                //   children: [
                //     Text(
                //       "Select required loan amount",
                //       style: TextStyle(
                //           fontWeight: FontWeight.w600, fontSize: 17.sp),
                //     ),
                //     Text(
                //       "*",
                //       style: TextStyle(
                //           color: Colors.red,
                //           fontWeight: FontWeight.w900,
                //           fontSize: 17.sp),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: Get.height * 0.01,
                // ),
                // SliderWidget(
                //   min: 0,
                //   max: 100,
                //   sliderHeight: Get.height * 0.06,
                //   onChanged: (value) {
                //     controller.currentLoanAmount.value = value;
                //     // totalValue.value = 0;
                //     // totalValue.value = currentLoanAmount * 100 +
                //     //     (currentLoanAmount * 1) * yearValue * 365;
                //   },
                //   currentValue: controller.currentLoanAmount.value,
                //   type: "K",
                // ),
                // SizedBox(
                //   height: Get.height * 0.01,
                // ),
                // Text(
                //   "Selected Amount : ₹" +
                //       (controller.currentLoanAmount.value * 100000)
                //           .toInt()
                //           .toString(),
                //   style:
                //       TextStyle(fontWeight: FontWeight.w900, fontSize: 17.sp),
                // )
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
              child: Column(
            children: [
              CustomButton(
                onPressed: () {
                  if (controller.selected.value == 0) {
                    // if ((controller.currentLoanAmount.value * 100000).toInt() >
                    //     5000) {
                    prefs.setString(
                        SharedConstants.LOAN_AMOUNT, (controller.currentLoanAmount.value * 100000).toInt().toString());
                    Get.toNamed(RoutesName.PanScreen);
                    // } else {
                    //   ShortMessage.toast(
                    //       title: "Amount should be greater than 5000 !!");
                    // }
                  } else {
                    ShortMessage.toast(title: "You should be Salaried only for this !!");
                  }
                },
                text: 'NEXT',
                height: Get.height * .06,
              ),
              // Container(
              //   width: Get.width * 0.7,
              //   height: Get.height * 0.05,
              //   child: TextButton(
              //       onPressed: () {
              //         prefs.setString(SharedConstants.CURRENTSCREEN,
              //             RoutesName.DashbroadScreen);
              //         Get.toNamed(RoutesName.DashbroadScreen);
              //       },
              //       child: Text(
              //         "GO TO DASHBROAD",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: Color(ColorConstants.primaryColor),
              //         ),
              //       )),
              // ),
            ],
          )),
        ],
      ),
    );
  }
}
