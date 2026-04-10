import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tejas_loan/controller/homeController.dart';
import 'package:tejas_loan/controller/internet_connectivity_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/custom_profile_pic_view.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/events.dart';
import 'package:tejas_loan/utils/shared_constants.dart';
import 'package:tejas_loan/views/repayment_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes/routes_names.dart';
import '../utils/image_constants.dart';

class HomePage extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  ConnectionManagerController connectionManagerController = Get.put(
    ConnectionManagerController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            if (homeController.number != "9999999999") {
              await homeController.getDashboard();
              await homeController.getLeadDetails();
            }
          },
          child:SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Skeletonizer(
                    enabled:homeController.loading.value,
                    child: Container(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if (homeController.bannerList.isNotEmpty &&
                            prefs.getString(SharedConstants.MOBILE) != "9999999999")
                          Visibility(
                            visible: prefs.getBool(SharedConstants.IS_BANNERS) ?? false,
                            child: SizedBox(
                              // margin: EdgeInsets.only(bottom: 16.sp),
                              height: homeController.isBanner.value ? Get.height * 0.2 : 0,
                              width: Get.width,
                              child: CarouselSlider(
                                items: [
                                  for (var i = 0; i < homeController.bannerList.length; i++)
                                    InkWell(
                                      onTap: () async {
                                        var url = homeController.bannerList[i].redirectUrl ?? "";
                                        try {
                                          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                                        } catch (e) {
                                          if (kDebugMode) {
                                            print(e);
                                          }
                                          ShortMessage.toast(title: "Invalid Url");
                                        }
                                      },
                                      child: Container(
                                        height: Get.height * 0.2,
                                        width: Get.width,
                                        margin: EdgeInsets.all(0.sp),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.sp),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.sp),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              imageUrl: homeController.bannerList[i].imgUrl ?? "",
                                              progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                                                    height: Get.height * 0.2,
                                                    width: Get.width,
                                                    child: Center(
                                                      child: CircularProgressIndicator(value: downloadProgress.progress),
                                                    ),
                                                  ),
                                              errorWidget: (context, url, error) => Image.asset(
                                                    ImageConstants.banner,
                                                    fit: BoxFit.fill,
                                                  )),
                                        ),
                                      ),
                                    )
                                ],
                                //Slider Container properties
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  viewportFraction: 0.99,
                                ),
                              ),
                            ),
                          ),
                        if (prefs.getString(SharedConstants.OUT_AMT) != "0" &&
                            prefs.getString(SharedConstants.OUT_AMT) != "null")
                          Container(
                            margin: EdgeInsets.only(top: 16.sp),
                            padding: EdgeInsets.all(18.sp),
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(12.sp),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your Outstanding Amount',
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.titleMedium!.color,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "₹ ${prefs.getString(SharedConstants.OUT_AMT) ?? "0.0"}",
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.titleMedium!.color,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                homeController.loadingOnContinue.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Get.to(RepaymentPage());
                                        },
                                        child: Column(
                                          children: [
                                            const Icon(Icons.remove_red_eye_sharp, color: Colors.blue),
                                            Padding(
                                              padding: EdgeInsets.only(top: 9.sp),
                                              child: const Text(
                                                'View Details',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        SizedBox(height: 18.sp),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.3),
                            //     spreadRadius: 3,
                            //     blurRadius: 10,
                            //     offset: Offset(0, 3),
                            //   ),
                            // ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const CustomProfilePicView(),

                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.53,
                                        child: Text(
                                          (prefs.getString(SharedConstants.NAME) ?? 'Hi User')
                                              .split(' ')
                                              .map((word) => word.capitalize!)
                                              .join(' '),
                                          style: TextStyle(
                                            color: Theme.of(context).textTheme.titleMedium!.color,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '+91 ${(prefs.getString(SharedConstants.MOBILE) ?? '').substring(0, 5)} ${(prefs.getString(SharedConstants.MOBILE) ?? '').substring(5, 10)}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Theme.of(context).textTheme.titleMedium!.color,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'PAN: ${prefs.getString(SharedConstants.PANCARD) ?? ''}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Theme.of(context).textTheme.titleMedium!.color,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              if (prefs.getString(SharedConstants.STEP_STAGE) != Events.COMPLETED)
                                homeController.loadingOnContinue.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
                                        child: CustomButton(
                                          onPressed: () {
                                            if (connectionManagerController.connectivityResult ==
                                                ConnectivityResult.none) {
                                              ShortMessage.toast(title: "Check your internet connection");
                                            } else {
                                              if (prefs.getString(SharedConstants.STEP_STAGE) != Events.COMPLETED) {
                                                Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? "");
                                              } else {
                                                ShortMessage.toast(title: "Application Already Completed");
                                              }
                                            }

                                            // Handle Edit Application
                                          },
                                          text:
                                              prefs.getString(SharedConstants.USER_TYPE).toString().contains("REPEAT") &&
                                                      prefs.getString(SharedConstants.STEP_STAGE) == Events.REGISTER_NOW
                                                  ? 'Apply Re-Loan'
                                                  : 'Complete Your Application',
                                          isLoading: homeController.loadingOnContinue.value,
                                          height: Get.height * 0.058,
                                        ),
                                      ),
                            ],
                          ),
                        ),
                        SizedBox(height: 18.sp),
                        Visibility(
                          visible: false,
                          child: Container(
                            // height: Get.height * 0.2,
                            padding: EdgeInsets.all(20.sp),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if ((prefs.getString(SharedConstants.IS_REGESTRATED) ?? "0") == "1") {
                                      Get.offAllNamed(RoutesName.ScoreScreen);
                                    } else {
                                      ShortMessage.toast(title: "Please Complete Your Profile First to View CIBIL Score");
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.auto_graph_rounded,
                                        size: 28.sp,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(height: 15.sp),
                                      Text(
                                        "View CIBIL",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).textTheme.titleMedium!.color),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15.sp,
                                ),
                                InkWell(
                                  onTap: () {
                                    // ShortMessage.toast(
                                    //     title: "This Feature Is Coming Soon");
                                    if ((prefs.getString(SharedConstants.IS_REGESTRATED) ?? "0") == "1") {
                                      Get.offAllNamed(RoutesName.LoanSelect, arguments: true);
                                    } else {
                                      ShortMessage.toast(title: "Please Complete Your Profile First !!");
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.calculate,
                                        size: 28.sp,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(height: 15.sp),
                                      Text(
                                        "Calculate Loan",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Theme.of(context).textTheme.titleMedium!.color,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        Text(
                          '   Recent Loans',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.titleMedium!.color,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeController.allLead.length < 2 ? homeController.allLead.length : 2,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(RoutesName.DashDetailScreen,
                                      arguments: homeController.allLead[index].leadId.toString());
                                },
                                child: _recentLoan(
                                  context: context,
                                  appliedDate: homeController.allLead[index].leadEntryDate.toString(),
                                  status: homeController.allLead[index].status ?? '',
                                  // status: "Disbursed",
                                  amount: homeController.allLead[index].loanAmount ?? '0',
                                  tenure: homeController.allLead[index].tenure ?? '0',
                                ),
                              );
                            })
                      ]),
                    ),
                  ),
                ),
        ),
      );
    });
  }

  Widget _recentLoan(
      {required String appliedDate,
      required String status,
      required String amount,
      required String tenure,
      required BuildContext context}) {
    return Container(
      // height: Get.height * 0.2,
      margin: EdgeInsets.only(bottom: 20.sp),
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(10.sp),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.53,
                  child: Text(
                    'Salary Loan',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Text(
                  'Applied on ${DateFormat('dd MMM yyyy').format(DateTime.parse(appliedDate))}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20.sp),
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
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: Text(status,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: (status == "Pending" || status == "Processing" || status == "Partially-Paid")
                        ? Colors.black54
                        : Colors.white,
                  )),
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
              'Duration',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
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
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium!.color,
              ),
            ),
            Text(
              '$tenure Days',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium!.color,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
