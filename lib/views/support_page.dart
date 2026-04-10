import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/image_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/shared_constants.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.2,
              width: Get.width,
              child: Image.asset(
                ImageConstants.support,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 20.sp),
            Text(
              'Contact Detail',
              style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: Icon(
                FontAwesomeIcons.phone,
                size: 24.sp,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Call Us',
              value: prefs.getString(SharedConstants.CONTACT_US_NUMBER) ?? SharedConstants.Company_Number,
              onTap: () async {
                final Uri telLaunchUri = Uri(
                  scheme: 'tel',
                  path: prefs.getString(SharedConstants.CONTACT_US_NUMBER) ?? SharedConstants.Company_Number,
                );
                launchUrl(telLaunchUri);
              },
            ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: Icon(
                FontAwesomeIcons.whatsapp,
                size: 25.sp,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Text Us',
              value: prefs.getString(SharedConstants.CONTACT_US_WHATSAPP) ?? SharedConstants.Company_WaNumber,
              onTap: () async {
                final Uri whatsAppLaunchUri = Uri.parse(
                    "https://api.whatsapp.com/send?phone=${prefs.getString(SharedConstants.CONTACT_US_WHATSAPP) ?? SharedConstants.Company_WaNumber}&text=Hi");
                launchUrl(whatsAppLaunchUri);
              },
            ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: Icon(
                size: 25.sp,
                Icons.mail,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Email Us',
              value: prefs.getString(SharedConstants.CONTACT_US_EMAIL) ?? SharedConstants.Company_Email,
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: prefs.getString(SharedConstants.CONTACT_US_EMAIL) ?? SharedConstants.Company_Email,
                );

                launchUrl(emailLaunchUri);
              },
            ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: Icon(
                size: 25.sp,
                Icons.alarm_on_rounded,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Available Time',
              value: '9:30 AM - 10:30 PM',
              onTap: () async {},
            ),
            // SizedBox(height: 13.sp),
            // _buildDivider(
            //   context: context,
            //   icon: Icon(
            //     size: 25.sp,
            //     FontAwesomeIcons.rankingStar,
            //     color: Theme.of(context).primaryColor,
            //   ),
            //   title: 'Give Rating & Review',
            //   value: 'App Store / Play Store',
            //   onTap: () async {
            //     final InAppReview inAppReview = InAppReview.instance;
            //
            //     if (await inAppReview.isAvailable()) {
            //       // inAppReview.requestReview();
            //       inAppReview.openStoreListing(appStoreId: '');
            //     }
            //   },
            // ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: Icon(
                size: 25.sp,
                FontAwesomeIcons.link,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Website',
              value: SharedConstants.Company_Website,
              onTap: () async {
                final Uri whatsAppLaunchUri = Uri.parse(SharedConstants.Company_Website);
                launchUrl(whatsAppLaunchUri, mode: LaunchMode.externalApplication);
              },
            ),
            SizedBox(height: 20.sp),
            Text(
              'Our customer support team is available [9:30AM-10:30PM] to assist you with any inquiries or concerns. Feel free to reach out - we\'re always ready to lend a helping hand!',
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
            ),
            SizedBox(height: 20.sp),
            Text(
              SharedConstants.Company_Name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium!.color,
              ),
            ),
            SizedBox(height: 13.sp),
            Row(
              children: [
                Icon(
                  Icons.map,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 15.sp,
                ),
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.gmaps);
                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: SizedBox(
                    width: Get.width * 0.8,
                    child: Text(
                      SharedConstants.Company_Address,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.titleMedium!.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            Text(
              'Connect with us on social media',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium!.color,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.facebook);

                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: CircleAvatar(
                    radius: 18.sp,
                    foregroundImage: const AssetImage(ImageConstants.facebook),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.instagram);

                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: CircleAvatar(
                    radius: 18.sp,
                    foregroundImage: const AssetImage(ImageConstants.instagram),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.twitter);

                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: CircleAvatar(
                    radius: 18.sp,
                    foregroundImage: const AssetImage(ImageConstants.twitter),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.youtube);
                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: CircleAvatar(
                    radius: 18.sp,
                    foregroundImage: const AssetImage(ImageConstants.youtube),
                  ),
                ),
              ],
            ), SizedBox(height: 40.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider({
    required String title,
    required String value,
    required Icon icon,
    required BuildContext context,
    required Function()? onTap,
  }) {
    return SizedBox(
      height: Get.height * 0.08,
      width: Get.width,
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 25.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleMedium!.color,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              InkWell(
                onTap: onTap,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
