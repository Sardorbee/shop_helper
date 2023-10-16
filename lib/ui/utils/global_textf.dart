import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_helper/ui/utils/colors.dart';

// ignore: must_be_immutable
class GlobalTextField extends StatelessWidget {
  GlobalTextField({
    Key? key,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    required this.textAlign,
    this.obscureText = false,
    this.maxLines = 1,
     this.controller ,
    required this.label,
  }) : super(key: key);

  final String hintText;
  int? maxLines;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  TextAlign textAlign;
  final bool obscureText;
   TextEditingController? controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 15.h,),
        SizedBox(
          // height: 55.h,
          child: TextField(
            maxLines: maxLines,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontFamily: "DMSans"),
            textAlign: textAlign,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.c_676767,
                  fontFamily: "DMSans"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.c_C8C8C8,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.c_C8C8C8,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.c_C8C8C8,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.c_C8C8C8,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.c_C8C8C8,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 18.h,),
      ],
    );
  }
}
