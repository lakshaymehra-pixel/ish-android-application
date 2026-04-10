import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/color_constants.dart';

class CustomRadioButton extends StatelessWidget {
  var currentSelected;
  var value;
  var text;
  bool isLongButton;
  void Function(dynamic)? onChanged;
  CustomRadioButton({super.key,required this.currentSelected,required this.value,required this.text,required this.onChanged,this.isLongButton=false});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: isLongButton?0:1,
      child: Container(
        height: 33.sp,
        margin: EdgeInsets.all(8.sp),
        alignment: Alignment.center,

        decoration: BoxDecoration(
            color: currentSelected == value
                ? Theme.of(context).highlightColor
                : Colors.grey.shade200.withOpacity(0.5),
            borderRadius: BorderRadius.circular(13.sp),
            border: Border.all(
              color: currentSelected == value
                  ? const Color(ColorConstants.primaryColor)
                  : Colors.grey.shade400,
            )),
        child: RadioListTile(
            activeColor: Theme.of(context).primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            title: Text(text,
              // minFontSize: 14,
              // maxFontSize: 18,
            ),
            value: value,
            contentPadding: EdgeInsets.only(right:10.sp),
            groupValue: currentSelected,
            //your group value,
            onChanged: onChanged),

      ),
    )
    ;
  }
}
