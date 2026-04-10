import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/loan_calculator_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/services/api_constant/api_constants.dart';
import 'package:tejas_loan/services/api_service.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

// import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/custom_dd_heading.dart';
import '../custom_widgets/custom_dropdown.dart';
import '../custom_widgets/custom_slider.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../utils/color_constants.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';

class LoanAmountPage extends GetView<LoanCalculatorController> {
  LoanAmountPage({super.key});

  var height = Get.height;
  var width = Get.width;

  @override
  Widget build(BuildContext context) {
    // print("total value = ${controller.maxValue.value}");
    return Obx(() {
      return CustomBackground(
          isScrollable: false,
          doubleBackToCloseApp: false,
          height: (Get.arguments ?? false) ? Get.height * 0.8 : Get.height * 1,
          heightOfUpperBox: Get.height * 0.7,
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomHeadingText(
              text2: "Please fill in your loan information",
              text1: "LOAN CALCULATOR",
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            if (!(Get.arguments ?? false))
              CustomDDHeading(
                textHeading: "Loan Purpose",
                height: Get.height * 0.1,
                dropDown: CustomDropdown(
                    currentValue: controller.purposeValue.value.id,
                    list: controller.purposeList.value,
                    onChanged: (value) {
                      controller.purposeValue.value = controller.purposeList
                          .firstWhere(
                              (item) => item.id == value); // Change here

                      print("purposeValue ==> ${controller.purposeValue.value.name}");
                    }),
              ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            if (controller.purposeValue.value.name == "OTHERS")
              CustomInputField(
                height: Get.height * 0.095,
                textHeading: "Enter In Brief",
                hint: 'Enter purpose',
                isCaps: false,
                letterSpacing: 1.0,
                maxLenght: 20,
                isMandatory: true,
                keyBroadType: TextInputType.name,
                formatter: const [],
                readOnly: false,
                isButton: false,
                buttonText: "Select",
                controller: controller.purposeController.value,
              ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: Row(
                children: [
                  Text(
                    "Enter total loan amount",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.titleMedium!.color),
                  ),
                  Text(
                    "*",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: SliderWidget(
                division: controller.maxLoanAmount.value.toInt() -
                    controller.minLoanAmount.value.toInt(),
                min: controller.minLoanAmount.value.toInt(),
                max: controller.maxLoanAmount.value.toInt(),
                min_value: controller.minLoanAmount.value.toInt().toDouble(),
                max_value: controller.maxLoanAmount.value.toInt().toDouble(),
                sliderHeight: Get.height * 0.06,
                onChanged: (value) {
                  // print("LOAN AMOUNT ==>" + value.toString());
                  controller.currentLoanAmount.value = value;
                  controller.totalValue.value.value =
                      controller.currentLoanAmount.value +
                          (controller.currentLoanAmount.value / 100) *
                              controller.currentTenure.value;
                },
                currentValue: controller.currentLoanAmount.value,
                type: "K",
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: Row(
                children: [
                  Text(
                    "Enter total days",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.titleMedium!.color),
                  ),
                  Text(
                    "*",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                        fontSize: 17.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: SliderWidget(
                division:
                    controller.maxTenure.value - controller.minTenure.value,
                min: controller.minTenure.value,
                max: controller.maxTenure.value,
                min_value: controller.minTenure.value.toDouble(),
                max_value: controller.maxTenure.value.toDouble(),
                sliderHeight: Get.height * 0.06,
                onChanged: (value) {
                  controller.totalValue.value.value = 0;
                  controller.currentTenure.value = value;

                  controller.totalValue.value.value =
                      controller.currentLoanAmount.value +
                          (controller.currentLoanAmount.value / 100) *
                              controller.currentTenure.value;
                },
                currentValue: controller.currentTenure.value,
                type: "D",
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            SimpleCircularProgressBar(
              animationDuration: 0,
              size: 50.sp,
              progressStrokeWidth: 12.sp,
              backStrokeWidth: 12.sp,
              maxValue: controller.maxValue.value,
              valueNotifier: controller.totalValue.value,
              progressColors: const [Color(ColorConstants.primaryColor)],
              backColor: Colors.grey,
              mergeMode: true,
              onGetText: (double value) {
                return Text(
                  textAlign: TextAlign.center,
                  'Your Total \nPayable Amount is \n₹${((controller.totalValue.value.value * 100).round()) * 10}',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleMedium!.color),
                );
              },
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.all(15.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Principle Amount",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                      Text(
                        "Interest Per Day",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${((controller.currentLoanAmount.value) * 1000).round()}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                      Text(
                        "₹${((controller.currentLoanAmount.value) * 10).round()}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Days",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                      Text(
                        "Total Interest",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " ${(controller.currentTenure.value).toInt()} Days",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                      Text(
                        "₹${(((controller.currentLoanAmount.value) * controller.currentTenure.value) * 10).round()}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  FittedBox(
                    child: Text(
                      "10% of principle amount will be deducted as processing fee",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color:
                              Theme.of(context).textTheme.titleMedium!.color),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Get.arguments ?? false
                ? Container()
                : CustomButton(
                    isLoading: controller.loading.value,
                    onPressed: () {
                      var days = (controller.currentTenure.value).round();
                      //    print(days);
                      prefs.setString(
                          SharedConstants.LOAN_AMOUNT,
                          ((controller.currentLoanAmount.value) * 1000)
                              .round()
                              .toString());
                      prefs.setString(SharedConstants.TENURE, "$days DAYS");
                      if (controller.loading.value == false) {
                        saveLoanAmount(1);
                      } else {
                        Fluttertoast.showToast(msg: "Please wait!!");
                      }
                    },
                    height: Get.height * 0.06,
                    text: "ACCEPT",
                  ),
            SizedBox(
              height: 10.sp,
            )
          ]);
    });
  }

  showAlertDialog(BuildContext context, String title, String message) {
    return Get.defaultDialog(
      title: title,
      middleText: message,
      barrierDismissible: false,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Get.back();
              Get.defaultDialog(
                  barrierDismissible: false,
                  title: "Alert !!",
                  middleText:
                      "By clicking the 'Yes' your application will be rejected and you will not be eligible for any loan. Do you want to proceed?",
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("No")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Get.back();
                          saveLoanAmount("2");
                        },
                        child: const Text("Yes")),
                  ]);
            },
            child: const Text("No")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("Change")),
        ElevatedButton(
            onPressed: () {
              Get.back();
              saveLoanAmount("1");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text("Yes"))
      ],
    );
  }

  saveLoanAmount(var acceptedId) async {
    if (controller.purposeValue.value.name != "SELECT") {
      controller.loading.value = true;
      try {
        var result = await ApiService().postMethod(
            baseUrl: APIConstants.getBaseUrl(uri: "saveleadDetails"),
            body: {
              "profile_id":
                  prefs.getString(SharedConstants.PROFILE_ID).toString(),
              "event_name": "loan_quotation_decision",
              "purpose_id": controller.purposeValue.value.id.toString(),
              "amount": ((controller.currentLoanAmount.value) * 1000)
                  .round()
                  .toString(),
              "tenure": ((controller.currentTenure.value).round()).toString(),
              "accepted_id": acceptedId.toString()
            },
            header: APIConstants.getApiHeader(
                prefs.getString(SharedConstants.TOKEN) ?? ""));
        if (result != null) {
          // appsflyerSdk!.set
          // appsflyerSdk!.setCustomerUserId(controller.appflyer_profile_id.toString());
          //
          // appsflyerSdk!.logEvent("loan_quotation_decision", {
          //   "profile_id": prefs.getString(SharedConstants.PROFILE_ID).toString(),
          //   "accepted_id": accepted_id.toString(),
          //   "status": result['Status'].toString(),
          //   "message": result['Message'].toString(),
          // }).then((result) {
          //   // print('Event successfully logged: $result');
          // }).catchError((error) {
          //   // print('Error logging event: $error');
          // });
          if (result["Status"].toString() == "1") {
            prefs.setString(SharedConstants.PURPOSE,
                controller.purposeValue.value.name.toString());
            ShortMessage.toast(title: result['Message'].toString());
            prefs.setString(
                SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
            prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT,
                result['Data']['step_percentage'] ?? 0);
            Events.getNextEvent(result['Data']['next_step'].toString());
          } else if (result['Status'] == 3) {
            Get.offAllNamed(RoutesName.DashbroadScreen);
            ShortMessage.toast(title: result['Message'].toString());
          } else if (result['Status'] == 4) {
            Events.logout();
            ShortMessage.toast(title: result['Message'].toString());
          } else {
            ShortMessage.toast(title: result['Message'].toString());
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      controller.loading.value = false;
    } else {
      Fluttertoast.showToast(msg: "Please select Loan Purpose");
    }
  }
}
