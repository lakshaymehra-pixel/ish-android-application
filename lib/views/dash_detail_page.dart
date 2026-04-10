import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashDetailController.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/views/preview_detail_page.dart';

class DashDeatailPage extends GetView<DashDetailController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppbar(title: "Loan Details", context: context),
        body: Obx(
          () => controller.loading2.value == true
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: controller.leadData.value.data != null
                      ? Container(
                          height: Get.height * 0.7,
                          padding: EdgeInsets.all(15.sp),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: 20.sp),
                                //
                                // Padding(
                                //   padding: EdgeInsets.only(left: 16.sp),
                                //   child: Text(
                                //     'Loan Details :',
                                //     style: TextStyle(
                                //       fontSize: 22,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(height: 20.sp),
                                Padding(
                                  padding: EdgeInsets.all(16.sp),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildDetailRow(
                                        "Loan No",
                                        controller.leadData.value.data![0].loanNo ?? "NO DATA",
                                        context,
                                      ),
                                      buildDetailRow(
                                        "Loan Date",
                                        controller.leadData.value.data![0].disbursalDate ?? "NO DATA",
                                        context,
                                      ),
                                      buildDetailRow("Monthly Salary",
                                          controller.leadData.value.data![0].monthlySalaryAmount ?? "NO DATA", context),
                                      buildDetailRow(
                                        "Loan Amount",
                                        controller.leadData.value.data![0].loanAmount ?? "NO DATA",
                                        context,
                                      ),
                                      buildDetailRow(
                                          "Tenure", controller.leadData.value.data![0].tenure ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Purpose", controller.leadData.value.data![0].purpose ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Status", controller.leadData.value.data![0].status ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Name", controller.leadData.value.data![0].firstName ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Email", controller.leadData.value.data![0].email ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Mobile", controller.leadData.value.data![0].mobile ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Pancard", controller.leadData.value.data![0].pancard ?? "NO DATA", context),
                                      buildDetailRow("Current City",
                                          controller.leadData.value.data![0].mCityName ?? "NO DATA", context),
                                      buildDetailRow("Current State",
                                          controller.leadData.value.data![0].mStateName ?? "NO DATA", context),
                                    ],
                                  ),
                                ),
                                // ElevatedButton(
                                //     onPressed: () {},
                                //     child: Container(
                                //         width: Get.width * 0.5,
                                //         child: Center(child: Text("Repayment"))))
                              ]))
                      : Container(
                          height: Get.height * 0.7,
                          padding: EdgeInsets.all(15.sp),
                          child: Center(
                              child: Text(
                            "No Data Found",
                          )),
                        ),
                ),
        ));
  }
}
