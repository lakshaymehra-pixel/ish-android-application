import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/utils/color_constants.dart';

import '../controller/dashbroadController.dart';
import '../routes/routes_names.dart';
import '../utils/image_constants.dart';
import '../views/all_leads_page.dart';
import '../views/loan_status_page.dart';
import '../views/support_page.dart';
import 'custom_drawer.dart';

class CustomBackground extends StatelessWidget {
  List<Widget> children;
  var height;
  var backEnabled;
  var enableBottomNav;
  var heightOfUpperBox;
  var doubleBackToCloseApp;
  var isScrollable;
  var isAppBarVisible;
  var isBanner;
  var isUpLifted;
  var isTagLine;
  var isDrawer;
  var isUpperBoxVisible;

  CustomBackground({
    Key? key,
    required this.children,
    this.height = 0.0,
    this.doubleBackToCloseApp = true,
    this.enableBottomNav = false,
    required this.heightOfUpperBox,
    this.isScrollable = true,
    this.backEnabled = true,
    this.isAppBarVisible = true,
    this.isDrawer = true,
    this.isBanner = false,
    this.isUpperBoxVisible = true,
    this.isUpLifted = false,
    this.isTagLine = false,
  }) : super(key: key);

  DashbroadController controller = Get.put(DashbroadController());

  @override
  Widget build(BuildContext context) {
    var widgetOptions = <Widget>[customBackground(), AllLeadsPage(), LoanStatusScreen(), SupportPage()].obs;
    return Obx(() {
      return AdvancedDrawer(
        backdrop: Column(
          children: [
            Container(
                height: 57.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                )),
            Expanded(
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
        disabledGestures: !isDrawer,
        openRatio:.8,
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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            resizeToAvoidBottomInset: true,
            // drawer: widget.isAppBarVisible ? CustomDrawer() : null,
            appBar: isAppBarVisible
                ? CustomAppbar(
                    title: "SOT",
                    context: context,
                    isEnableLogout: true,
                    isImage: true,
                    leading2: IconButton(
                        onPressed: () {
                          controller.advancedDrawerController.value.showDrawer();
                        },
                        icon: Icon(Icons.menu)),
                    leading: Image.asset(ImageConstants.getAppLogoForAppBar(context)))
                : AppBar(
                    elevation: 0,
                    backgroundColor: Color(ColorConstants.primaryColor),
                    toolbarHeight: 0,
                  ),
            // bottomNavigationBar:
            // widget.isAppBarVisible
            //     ? CustomNavBar(
            //         onTap: controller.onItemTapped,
            //         notchBottomBarController:
            //             controller.notchBottomBarController.value,
            //         pageController: controller.pageController.value)
            //     : null,
            //

            bottomNavigationBar: isAppBarVisible
                ? BottomNavigationBar(
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
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                    currentIndex: controller.selectedIndex1.value,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Theme.of(context).textTheme.titleLarge!.color,
                    unselectedIconTheme: IconThemeData(color: Theme.of(context).textTheme.titleLarge!.color),
                    iconSize: 22.sp,
                    onTap: (index) {
                      HapticFeedback.mediumImpact();
                      if (index != 0) {
                        controller.selectedIndex1.value = index;
                      } else {
                        Get.offAllNamed(RoutesName.DashbroadScreen);
                      }
                    },
                    elevation: 10)
                : null,
            body: doubleBackToCloseApp != false
                ? DoubleBackToCloseApp(
                    snackBar: SnackBar(
                        elevation: 10,
                        content: Text("Press again to exit !!"),
                        backgroundColor: Color(ColorConstants.primaryColor),
                        margin: EdgeInsets.all(15),
                        behavior: SnackBarBehavior.fixed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    // child: _widgetOptions.elementAt(_selectedIndex),
                    child:
                        // PageView(
                        //   controller: controller.pageController.value,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   children: List.generate(
                        //       widgetOptions.length, (index) => widgetOptions[index]),
                        // ),
                        widgetOptions.elementAt(controller.selectedIndex1.value),
                  )
                : widgetOptions.elementAt(controller.selectedIndex1.value)
            // PageView(
            //         controller: controller.pageController.value,
            //         physics: const NeverScrollableScrollPhysics(),
            //         children: List.generate(
            //             widgetOptions.length, (index) => widgetOptions[index]),
            //       ),
            ),
      );
    });
  }

  Widget customBackground() {
    try {
      controller.selectedDrawerIndex.value = 1;
    } catch (e) {
      print(e);
    }
    return Container(
        padding: EdgeInsets.all(12.sp),
        // color: Colors.black,
        height: GetPlatform.isIOS ? Get.height * 0.78 : Get.height * 0.8,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: children,
          ),
        ));
  }
}
