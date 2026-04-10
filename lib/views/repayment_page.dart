import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/shared_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/homeController.dart';
import '../controller/internet_connectivity_controller.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../utils/color_constants.dart';

class RepaymentPage extends StatelessWidget {
  RepaymentPage({super.key});

  HomeController homeController = Get.put(HomeController());
  DashbroadController dashbroadController = Get.put(DashbroadController());

  ConnectionManagerController connectionManagerController = Get.put(
    ConnectionManagerController(),
  );
  var paymentType = [1, 2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context, title: "Repayment Details"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.sp),
            Text(
              '   Repayment Details',
              style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Get.height * .4,
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailRow("Loan Number", prefs.getString(SharedConstants.LOAN_NO) ?? "NO DATA",
                        Color(ColorConstants.primaryColor), context),
                    buildDetailRow("Disbursed Amount", prefs.getString(SharedConstants.DIS_AMT) ?? "NO DATA",
                        Color(ColorConstants.primaryColor), context),
                    buildDetailRow("Repayment Amount", prefs.getString(SharedConstants.REPAYMENT_AMT) ?? "NO DATA",
                        Color(ColorConstants.primaryColor), context),
                    buildDetailRow("Disbursed Date", prefs.getString(SharedConstants.DIS_DATE) ?? "NO DATA",
                        Color(ColorConstants.primaryColor), context),
                    buildDetailRow("Repayment Date", prefs.getString(SharedConstants.REPAYMENT_DATE) ?? "NO DATA",
                        Color(ColorConstants.primaryColor), context),
                    buildDetailRow("Loan Status", prefs.getString(SharedConstants.LOAN_STATUS) ?? "NO DATA",
                        Color(ColorConstants.primaryColor), context),
                    Divider(
                      thickness: 5.sp,
                      color: Theme.of(context).textTheme.titleLarge!.color,
                    ),
                    buildDetailRow("Total Due", prefs.getString(SharedConstants.OUT_AMT) ?? "NO DATA",
                        Color(ColorConstants.primaryColor), context),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            Obx(() {
              return CustomButton(
                height: Get.height * 0.06,
                onPressed: () {
                  if (connectionManagerController.connectivityResult == ConnectivityResult.none) {
                    ShortMessage.toast(title: "Check your internet connection");
                  } else {
                    if ((prefs.getString(SharedConstants.OUT_AMT) ?? "0.0") == "0.0") {
                      ShortMessage.toast(title: "No outstanding amount to repay");
                    } else {
                      if (homeController.loadingOnRepay.value == false) {
                        launchUrl(Uri.parse("https://salarytopup.com/repay-loan"),mode: LaunchMode.inAppWebView);

                        // Get.defaultDialog(
                        //   title: "Select Payment Method",
                        //   middleText:
                        //       "Please select payment method to continue",
                        //   actions: [
                        //     if (paymentType.contains(1))
                        //       SizedBox(
                        //         width: Get.width * 0.25,
                        //         height: 28.sp,
                        //         child: ElevatedButton(
                        //             style: ElevatedButton.styleFrom(
                        //               backgroundColor: Color(
                        //                   ColorConstants.secondaryColor),
                        //               minimumSize:
                        //                   Size(double.infinity, 50),
                        //             ),
                        //             onPressed: () {
                        //               Get.back();
                        //               homeController.generateHashValue(
                        //                   prefs.getString(
                        //                       SharedConstants.LOAN_LEAD_ID),
                        //                   prefs.getString(
                        //                       SharedConstants.OUT_AMT));
                        //             },
                        //             child: Text("PayU")),
                        //       ),
                        //     if (paymentType.contains(2))
                        //       SizedBox(
                        //         width: Get.width * 0.25,
                        //         height: 28.sp,
                        //         child: ElevatedButton(
                        //             style: ElevatedButton.styleFrom(
                        //               backgroundColor: Color(
                        //                   ColorConstants.secondaryColor),
                        //               minimumSize:
                        //                   Size(double.infinity, 50),
                        //             ),
                        //             onPressed: () {
                        //               // Get.back();
                        //               homeController.generateOrderId(
                        //                   prefs.getString(
                        //                       SharedConstants.LOAN_LEAD_ID),
                        //                   prefs.getString(
                        //                       SharedConstants.OUT_AMT));
                        //             },
                        //             child: Text("RazorPay")),
                        //       ),
                        //   ],
                        // );
                        // homeController.generateOrderId(
                        //     prefs.getString(SharedConstants.LOAN_LEAD_ID), prefs.getString(SharedConstants.OUT_AMT));
                      } else {
                        ShortMessage.toast(title: "Getting Order Id");
                      }
                    }
                  }
                },
                isLoading: homeController.loadingOnRepay.value,
                text: "REPAY NOW",
              );
            })
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value, Color color, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 15.sp, color: Theme.of(context).textTheme.titleMedium!.color, fontWeight: FontWeight.bold
                  // fontStyle: FontStyle
                  ),
            ),
          ),
          Expanded(
            // width: Get.width * 0.4,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: color,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
