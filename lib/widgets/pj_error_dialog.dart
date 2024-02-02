import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_auth/widgets/pj_text.dart';

void showAlertDialog(BuildContext context,String code, String message, [ Function? callback, bool pop = false, Color? color]) {
  showDialog(
    barrierColor: color ?? Colors.transparent,
    context: context,
    builder: (context) => AlertDialog(
      title: PjText(code, style: PjTextStyle.b1, align: TextAlign.center,),
      content: PjText(message, align: TextAlign.center, style: PjTextStyle.h8,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),

    ),
  ).then((value) {
    if(pop){
      Navigator.of(context, rootNavigator: true).pop();
    }
    if(callback != null){
      callback();
    }
  });

}