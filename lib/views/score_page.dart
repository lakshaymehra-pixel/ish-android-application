import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/show_score_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/main.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/HeadingText.dart';
import '../utils/shared_constants.dart';
import 'cibil_view_page.dart';

class ShowScorePage extends GetView<ShowScoreController> {
  const ShowScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomBackground(
        heightOfUpperBox: Get.height * 0.7,
        height: Get.height * 0.8,
        doubleBackToCloseApp: false,
        children:
            // controller.loading.value
            //     ? [
            //         SizedBox(
            //           height: Get.height * 0.03,
            //         ),
            //         Container(alignment: Alignment.center, height: Get.height * 0.7, child: CircularProgressIndicator())
            //       ]
            //     :
            controller.score.value == 0
                ? [
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Center(
                        child: Text(
                      "No Score Found !!",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 22.sp, color: Theme.of(context).primaryColor),
                    )),
                    SizedBox(
                      height: Get.height * 0.15,
                    ),
                    Center(
                      child: SizedBox(
                          width: Get.width * 0.7,
                          child: Text(
                            "Your score is not yet calculated. Please complete your profile to get your score.",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: Theme.of(context).textTheme.titleMedium!.color),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ]
                : [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CustomHeadingText(
                        text1:
                            "Hi, ${(prefs.getString(SharedConstants.NAME) ?? 'hi user').split(' ').map((word) => word.capitalize!).join(' ')}",
                        text2: 'Here is Your Score!'),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SfRadialGauge(enableLoadingAnimation: true, animationDuration: 3500, axes: <RadialAxis>[
                      RadialAxis(
                          startAngle: 180,
                          endAngle: 0,
                          minimum: 0,
                          maximum: 900,
                          showLabels: true,
                          interval: 180,
                          maximumLabels: 2,
                          onLabelCreated: (AxisLabelCreatedArgs args) {},
                          axisLabelStyle: GaugeTextStyle(
                            color: prefs.getBool(SharedConstants.THEME) ?? false ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                          showLastLabel: true,
                          labelsPosition: ElementsPosition.outside,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 180,
                              color: Colors.red,
                              startWidth: 30.sp,
                              endWidth: 30.sp,
                            ),
                            GaugeRange(
                              startValue: 180,
                              endValue: 360,
                              color: Colors.orange,
                              startWidth: 30.sp,
                              endWidth: 30.sp,
                            ),
                            GaugeRange(
                              startValue: 360,
                              endValue: 540,
                              color: Colors.yellow,
                              startWidth: 30.sp,
                              endWidth: 30.sp,
                            ),
                            GaugeRange(
                                startValue: 540,
                                startWidth: 30.sp,
                                endWidth: 30.sp,
                                endValue: 720,
                                color: Colors.green.shade400),
                            GaugeRange(
                              startValue: 720,
                              endValue: 900,
                              startWidth: 30.sp,
                              endWidth: 30.sp,
                              color: Colors.green,
                            )
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: controller.score.value.toDouble(),
                              needleStartWidth: 1.sp,
                              needleEndWidth: 12.sp,
                              needleColor: prefs.getBool(SharedConstants.THEME) ?? false ? Colors.white : Colors.black,
                              knobStyle: KnobStyle(
                                color: prefs.getBool(SharedConstants.THEME) ?? false ? Colors.blue : Colors.black,
                              ),
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Text(controller.score.value.toString(),
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).textTheme.titleLarge!.color)),
                                angle: 90,
                                positionFactor: 0.2),
                          ])
                    ]),
                    SizedBox(
                        width: Get.width,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Review your activity based on the previous loan sanctioned by ${SharedConstants.Brand_Name}.",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                        )),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CustomButton(
                        height: Get.height * 0.06,
                        onPressed: () {
                          Get.to(() => ReportPage());
                        },
                        text: "View Report"),
                  ],
      );
    });
  }
}
