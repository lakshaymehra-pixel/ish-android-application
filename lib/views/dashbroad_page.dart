import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/controller/internet_connectivity_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/custom_widgets/custom_drawer.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/image_constants.dart';
import 'package:tejas_loan/views/home_page.dart';
import 'package:tejas_loan/views/all_leads_page.dart';
import 'package:tejas_loan/views/loan_status_page.dart';
import 'package:tejas_loan/views/support_page.dart';

import '../controller/status_controller.dart';
import '../services/api_constant/api_constants.dart';
import '../utils/color_constants.dart';

class DashbroadPage extends GetView<DashbroadController> {
  DashbroadController controller = Get.put(DashbroadController());
  StatusController controller1 = Get.put(StatusController());
  ConnectionManagerController connectionManagerController = Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    if (!APIConstants.isModeDevelopment()) checkVersion(context);
    List<Widget> widgetOptions = <Widget>[
      HomePage(),
      AllLeadsPage(),
      LoanStatusScreen(),
      Padding(
        padding: GetPlatform.isAndroid ? EdgeInsets.only(bottom: 30.sp) : EdgeInsets.zero,
        child: const SupportPage(),
      )
    ];
    return Obx(() {
      return AdvancedDrawer(
        backdrop: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                  // height: GetPlatform.isIOS ? 57.sp : 55.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  )),
            ),
            Expanded(
              flex: 17,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
          ],
        ),
        controller: controller.advancedDrawerController.value,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 350),
        animateChildDecoration: true,
        rtlOpening: false,
        openScale: 1,
        disabledGestures: false,
        openRatio: .8,
        childDecoration: BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15.sp,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(25.sp)),
        ),
        drawer: CustomDrawer(
          advancedDrawerController: controller.advancedDrawerController.value,
        ),
        child: Scaffold(
            bottomNavigationBar:
                // (widgetOptions.length <= 5)
                //     ? CustomNavBar(
                //         onTap: (index) {
                //           controller.pageController.value.jumpToPage(index);
                //         },
                //         notchBottomBarController:
                //             controller.notchBottomBarController.value,
                //         pageController: controller.pageController.value)
                //     : null,
                BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_outlined),
                    label: 'Applications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.history_rounded,
                    ),
                    label: 'Status',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.support_agent_rounded,
                    ),
                    label: 'Support',
                  ),
                ],
                    type: BottomNavigationBarType.fixed,
                    selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    currentIndex: controller.selectedIndex.value,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Theme.of(context).textTheme.titleLarge!.color,
                    unselectedIconTheme: IconThemeData(color: Theme.of(context).textTheme.titleLarge!.color),
                    iconSize: 23.sp,
                    onTap: controller.onItemTapped,
                    elevation: 10),
            appBar: CustomAppbar(
                title: "SOT",
                context: context,
                isEnableLogout: true,
                isImage: true,
                leading2: IconButton(
                    onPressed: () {
                      controller.advancedDrawerController.value.showDrawer();
                    },
                    icon: const Icon(Icons.menu)),
                leading: Image.asset(ImageConstants.getAppLogoForAppBar(context))),
            extendBody: true,
            body: DoubleBackToCloseApp(
                snackBar: SnackBar(
                    elevation: 10,
                    content: const Text("Press again to exit !!"),
                    backgroundColor: const Color(ColorConstants.tertiaryColor),
                    margin: const EdgeInsets.all(15),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                // child: _widgetOptions.elementAt(_selectedIndex),
                child: widgetOptions.elementAt(controller.selectedIndex.value))),
      );
    });
  }
}
//Padding(
//                         padding:
//                             EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10),
//                         child: Card(
//                           elevation: 4,
//                           color: Color(ColorConstants.secondaryColor),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.sp)),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 10.sp, horizontal: 13.sp),
//                             //getPadding(),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: Get.width,
//                                   alignment: Alignment.center,
//                                   child: RichText(
//                                     text: TextSpan(children: <TextSpan>[
//                                       TextSpan(
//                                         text: "LOAN APPLICATION - ",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16.sp),
//                                       ),
//                                       TextSpan(
//                                         text: "( ",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15.sp),
//                                       ),
//                                       TextSpan(
//                                         text: controller
//                                                     .allLead.value[index].status
//                                                     .toString() ==
//                                                 "LEAD-NEW"
//                                             ? "INCOMPLETE"
//                                             : controller.allLead.value[index]
//                                                     .status ??
//                                                 "INCOMPLETE",
//                                         style: TextStyle(
//                                             color: controller.allLead
//                                                         .value[index].status
//                                                         .toString() ==
//                                                     "DISBURSED"
//                                                 ? Colors.greenAccent
//                                                 : controller
//                                                             .allLead
//                                                             .value[index]
//                                                             .status ==
//                                                         "CLOSED"
//                                                     ? Colors
//                                                         .greenAccent.shade400
//                                                     : controller
//                                                                 .allLead
//                                                                 .value[index]
//                                                                 .status ==
//                                                             "REJECT"
//                                                         ? Colors.red
//                                                         : Colors.orange,
//                                             fontSize: 15.sp),
//                                       ),
//                                       TextSpan(
//                                         text: " )",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15.sp),
//                                       ),
//                                     ]),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10.sp,
//                                 ),
//                                 Row(
//                                   children: [
//                                     // CircleAvatar(
//                                     //   radius: 24.sp,
//                                     //   foregroundImage: NetworkImage(
//                                     //       "https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg"),
//                                     // ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           border:
//                                               Border.all(color: Colors.white),
//                                           shape: BoxShape.circle),
//                                       height: 35.sp,
//                                       width: 35.sp,
//                                       child: Icon(
//                                         Icons.person,
//                                         color: Colors.white,
//                                         size: 30.sp,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 15.sp,
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                         RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: "NAME : ",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15.sp),
//                                             ),
//                                             TextSpan(
//                                               text: prefs.getString(
//                                                       SharedConstants.NAME) ??
//                                                   "- - - -",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15.sp),
//                                             ),
//                                           ]),
//                                         ),
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                         RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: "APPLY DATE : ",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15.sp),
//                                             ),
//                                             TextSpan(
//                                               text: controller.df.format(
//                                                   DateTime.parse(controller
//                                                           .allLead
//                                                           .value[index]
//                                                           .leadEntryDate ??
//                                                       "0000-00-00 00:00:00")),
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15.sp),
//                                             ),
//                                           ]),
//                                         ),
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                         RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: "LOAN AMT : ",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15.sp),
//                                             ),
//                                             TextSpan(
//                                               text: controller
//                                                       .allLead
//                                                       .value[index]
//                                                       .loanAmount ??
//                                                   "- - - -",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15.sp),
//                                             ),
//                                           ]),
//                                         ),
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                         RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: "APPLICATION No: ",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 14.sp),
//                                             ),
//                                             TextSpan(
//                                               text: controller
//                                                       .allLead
//                                                       .value[index]
//                                                       .application_no ??
//                                                   "- - - -",
//                                               style: TextStyle(
//                                                   // overflow:
//                                                   //     TextOverflow.ellipsis,
//                                                   color: Colors.white,
//                                                   fontSize: 14.sp),
//                                             ),
//                                           ]),
//                                         ),
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10.sp,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     controller.allLead.value[index].status
//                                                 .toString() !=
//                                             "LEAD-NEW"
//                                         ? Container()
//                                         : InkWell(
//                                             onTap: () {
//                                               controller.getLeadStatus(
//                                                   controller.allLead
//                                                       .value[index].leadId
//                                                       .toString());
//                                             },
//                                             child: Card(
//                                               color: Colors.transparent,
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   side: BorderSide(
//                                                       color: Colors.white,
//                                                       width: 2.sp)),
//                                               // child: Container(
//                                               //     alignment: Alignment.center,
//                                               //     width: Get.width * 0.15,
//                                               //     height: Get.height * 0.03,
//                                               //     decoration: BoxDecoration(
//                                               //       borderRadius: BorderRadius.all(
//                                               //           Radius.circular(5)),
//                                               //     ),
//                                               //     child: controller
//                                               //             .loadingOnApply.value
//                                               //         ? Center(
//                                               //             child: SizedBox(
//                                               //                 height:
//                                               //                     Get.height * 0.02,
//                                               //                 width:
//                                               //                     Get.width * 0.1,
//                                               //                 child:
//                                               //                     CircularProgressIndicator()),
//                                               //           )
//                                               //         : Text("Apply Now",
//                                               //             style: TextStyle(
//                                               //                 fontSize: 12.sp,
//                                               //                 color:
//                                               //                     Colors.white))
//                                               // ),
//                                             )),
//                                     InkWell(
//                                         onTap: () {
//                                           Get.toNamed(
//                                               RoutesName.DashDetailScreen,
//                                               arguments: controller
//                                                   .allLead.value[index].leadId
//                                                   .toString());
//                                         },
//                                         child: Card(
//                                           color: Colors.transparent,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               side: BorderSide(
//                                                   color: Colors.white,
//                                                   width: 2.sp)),
//                                           child: Container(
//                                               alignment: Alignment.center,
//                                               width: Get.width * 0.15,
//                                               height: Get.height * 0.03,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(5)),
//                                               ),
//                                               child: Text("View Details",
//                                                   style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       color: Colors.white))),
//                                         )),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
