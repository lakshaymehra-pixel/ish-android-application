import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/repayment_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/views/preview_detail_page.dart';

class RepaymentHistoryPage extends GetView<RepaymentHistoryController> {
  const RepaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(context: context, isEnableLogout: false, title: "Repayment History"),
        body: Obx(
          () => controller.loading.value == true
              ? const Center(child: CircularProgressIndicator())
              : controller.collection.isNotEmpty
                  ? Container(
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: ListView.builder(
                            itemCount: controller.collection.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                  margin: EdgeInsets.all(10.sp),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).highlightColor,
                                    borderRadius: BorderRadius.circular(14.sp),
                                    border: Border.all(color: Colors.grey.shade400.withOpacity(0.3)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 1.sp,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                    Padding(
                                      padding: EdgeInsets.all(15.sp),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          buildDetailRow("Loan Number",
                                              controller.collection[index].loanNo ?? "NO DATA", context),
                                          buildDetailRow("Received Amount",
                                              controller.collection[index].receivedAmount ?? "NO DATA", context),
                                          buildDetailRow(
                                              "Date of repayment",
                                              controller.collection[index].dateOfRecived ?? "----/--/--",
                                              context),
                                          buildDetailRow("Loan Status",
                                              controller.collection[index].status_name ?? "NO DATA", context),
                                          buildDetailRow("Discount",
                                              controller.collection[index].discount ?? "NO DATA", context),
                                          buildDetailRow(
                                              "Verification Status",
                                              (controller.collection[index].paymentVerification ?? "NO DATA"),
                                              context),
                                        ],
                                      ),
                                    ),
                                    // ElevatedButton(
                                    //     onPressed: () {},
                                    //     child: Container(
                                    //         width: Get.width * 0.5,
                                    //         child: Center(child: Text("Repayment"))))
                                  ]));
                            }),
                      ),
                    )
                  : const Center(child: Text("No Data Found")),
        ));
  }
}
