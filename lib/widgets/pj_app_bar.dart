import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth/utils/custom_icons.dart';
import 'package:phone_auth/utils/pj_colors.dart';
import 'package:phone_auth/utils/pj_icons.dart';
import 'package:phone_auth/widgets/pj_text.dart';

enum AppBarType { registration, main }

class PjAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PjAppBar(
      {Key? key,
      this.leading,
      this.title = "",
      this.actions,
      this.type = AppBarType.main,
      this.leadingText = '',
      this.style = PjTextStyle.bodyBold})
      : super(key: key);

  final Function? leading;
  final String title;
  final List<Widget>? actions;
  final PjTextStyle style;
  final AppBarType type;
  final String leadingText;

  @override
  Size get preferredSize => Size.fromHeight(type == AppBarType.registration ? 38.w : 47.w);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: type == AppBarType.registration,
      titleSpacing: 0,
      leadingWidth: type == AppBarType.registration ? 37.w : null,
      backgroundColor: type == AppBarType.registration ? PjColors.white : PjColors.background,
      automaticallyImplyLeading: false,
      title: type == AppBarType.registration
          ? PjText(
              title,
              style: style,
            )
          : Container(
              height: 47.w,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 0.5.w, color: PjColors.lightGray),
              )),
              child: Container(
                height: 26.w,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 7.w, bottom: 10.w),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PjText(
                          title,
                          style: PjTextStyle.bodyBold,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (leading != null) {
                          leading!();
                        }
                      },
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 8.w,
                          ),
                          Icon(
                            CustomIcons.arrow,
                            color: PjColors.blue,
                            size: 20.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          PjText(
                            leadingText,
                            style: PjTextStyle.callout,
                            color: PjColors.blue,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      actions: actions,
      leading: type == AppBarType.registration
          ? leading != null
              ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    leading!();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 8.w, bottom: 8.w),
                    child: SvgPicture.asset(
                      PjIcons.longArrow,
                      height: 22.w,
                      width: 21.w,
                      color: PjColors.black,
                    ),
                  ),
                )
              : null
          : null,
    );
  }
}
