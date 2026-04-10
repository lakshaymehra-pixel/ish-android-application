import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../controller/dashbroadController.dart';
import '../custom_widgets/custom_button.dart';
import '../routes/routes_names.dart';
import '../utils/color_constants.dart';

class AllLeadsPage extends StatelessWidget {
  AllLeadsPage({super.key});

  DashbroadController controller = Get.put(DashbroadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () {
            return controller.number != "9999999999" ? controller.getLeadDetails() : null;
          },
          child: Container(
            // margin: EdgeInsets.only(bottom: 40.sp),
            child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.sp),
                        Text(
                          '    Loan Applications',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.titleMedium!.color,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        Skeletonizer(
                          enabled: controller.loadingOnDashboard.value,
                          child:  ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.allLead.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                                  child: _loanView(
                                    context: context,
                                    appNo: controller.allLead[index].application_no ?? '#0000000000',
                                    status: controller.allLead[index].status ?? '',
                                    // status: 'Rejected',
                                    amount: controller.allLead[index].loanAmount ?? '0',
                                    applyDate: controller.allLead[index].leadEntryDate ?? '0000-00-00',
                                    name: (prefs.getString(SharedConstants.NAME) ?? "User Name"),
                                    lead_id: controller.allLead[index].leadId.toString(),
                                  ),
                                );
                              }),
                        ),
                        /**Column Contains Card for Banner & Grid view for Leads */

                        Container()
                      ],
                    ),
                  ),
          ),
        );
      }),
    );
  }

  Widget _loanView(
      {required String appNo,
      required String status,
      required String name,
      required String amount,
      required String lead_id,
      required BuildContext context,
      required String applyDate}) {
    return Container(
      // height: Get.height * 0.2,
      margin: EdgeInsets.only(bottom: 20.sp),
      padding: EdgeInsets.all(15.sp),
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
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   decoration: BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
            //   height: 32.sp,
            //   width: 32.sp,
            //   child: Icon(
            //     Icons.person,
            //     color: Colors.black,
            //     size: 25.sp,
            //   ),
            // ),
            // SizedBox(width: 15.sp),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.7,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleMedium!.color,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 20.sp,
                    width: 60.sp,
                    child: Text(
                      appNo,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(left: 15.sp),
                padding: EdgeInsets.all(12.sp),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (status == 'Disbursed' || status == 'Completed' || status == 'Closed')
                      ? Colors.green
                      : (status == 'Rejected' || status == 'Settled' || status == 'Write-OFF')
                          ? Colors.red
                          : (status == "Pending" || status == "Processing" || status == "Partially-Paid")
                              ? Colors.yellow
                              : (status == "Submitted")
                                  ? const Color(ColorConstants.primaryColor)
                                  : const Color(ColorConstants.primaryColor),
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: (status == "Pending" || status == "Processing" || status == "Partially-Paid")
                        ? Colors.black54
                        : Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Amount',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
            ),
            Text(
              'Apply Date',
              style: TextStyle(
                  fontSize: 16.sp, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge!.color),
            ),
          ],
        ),
        SizedBox(
          height: 17.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹ $amount',
              style: TextStyle(
                  fontSize: 16.sp, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            Text(
              DateFormat('dd MMM yyyy').format(DateTime.parse(applyDate)),
              style: TextStyle(
                  fontSize: 16.sp, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
          ],
        ),
        SizedBox(
          height: 17.sp,
        ),
        CustomButton(
            height: Get.height * 0.06,
            onPressed: () {
              Get.toNamed(RoutesName.DashDetailScreen, arguments: lead_id);
            },
            text: "View Detail")
      ]),
    );
  }
}
