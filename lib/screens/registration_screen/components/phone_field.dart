import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phone_auth/utils/pj_colors.dart';
import 'package:phone_auth/widgets/pj_text.dart';

class PhoneField extends StatefulWidget {
  final MaskTextInputFormatter formatter;
  final FocusNode focusNode;
  final Function(String text) onChange;
  final TextEditingController controller;

  const PhoneField(
      {super.key, required this.focusNode, required this.formatter, required this.controller, required this.onChange});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 46.w,
      child: TextFormField(
          style: TextStyle(
              color: PjColors.black,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
              letterSpacing: -0.41,
              height: 22 / 17),
          keyboardType: TextInputType.phone,
          controller: widget.controller,
          focusNode: widget.focusNode,
          cursorColor: PjColors.gray,
          cursorHeight: 22.w,
          inputFormatters: [widget.formatter],
          onChanged: widget.onChange,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20.w, top: 12.w, bottom: 12.w),
              child: PjText(
                "+7",
                style: PjTextStyle.b1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(width: 1.w, color: PjColors.orange),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(width: 1.w, color: PjColors.borderGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(width: 1.w, color: PjColors.borderGray),
            ),
            isDense: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
          )),
    );
  }
}
