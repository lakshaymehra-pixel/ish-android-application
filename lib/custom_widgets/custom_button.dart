import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/color_constants.dart';

import '../utils/shared_constants.dart';

class CustomButton extends StatelessWidget {
  var height;
  var text;
  var isLoading;
  Function()? onPressed;

  CustomButton({super.key, required this.height, required this.onPressed, required this.text, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Get.width * 0.9,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:prefs.getBool(SharedConstants.THEME)??false? const Color(ColorConstants.secondaryColor):const Color(ColorConstants.secondaryColor),
            disabledBackgroundColor: Colors.grey,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.sp),
            ),
          ),
          child: isLoading
              ? SpinKitRing(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 20.sp,
                  lineWidth: 6.sp,
                )
              : Text(
                  text,
                  style: TextStyle(
                      fontSize: 16.sp, color: Theme.of(context).scaffoldBackgroundColor, fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
