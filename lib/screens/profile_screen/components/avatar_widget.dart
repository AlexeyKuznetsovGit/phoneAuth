import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_auth/utils/custom_icons.dart';
import 'package:phone_auth/utils/pj_colors.dart';
import 'package:phone_auth/utils/singleton/sg_app_data.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 79.5.w,
            width: 78.w,
            child: Stack(
              children: [
                SgAppData.instance.user.avatarUrl!.isEmpty
                    ? Container(
                        height: 76.w,
                        width: 73.w,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(227, 227, 227, 1.0)),
                        child: Icon(
                          CustomIcons.profile,
                          size: 59.w,
                          color: PjColors.blue,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.network(
                          SgAppData.instance.user.avatarUrl!,
                          height: 76.w,
                          width: 73.w,
                          fit: BoxFit.cover,
                        )),
              ],
            ),
          ),
          Container(
            height: 32.w,
            width: 32.w,
            decoration: BoxDecoration(shape: BoxShape.circle, color: PjColors.background),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    3,
                    (index) => Container(
                          height: 5.3.w,
                          width: 5.3.w,
                          margin: index != 2 ? EdgeInsets.only(right: 2.67.w) : null,
                          decoration: BoxDecoration(color: PjColors.blue, shape: BoxShape.circle),
                        ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
