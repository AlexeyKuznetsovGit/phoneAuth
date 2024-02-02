import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_auth/utils/pj_colors.dart';

enum PjTextStyle { h1, h8, h9, b1, b2, b5, callout, bodyBold, caption1, caption2, footnote, t3, t3bold }

class PjText extends StatelessWidget {
  const PjText(this.text, {Key? key, required this.style, this.color = PjColors.black, this.align = TextAlign.start})
      : super(key: key);

  final String text;
  final Color? color;
  final PjTextStyle style;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        letterSpacing: style == PjTextStyle.caption1 ? null : letterSpacing,
        height: height,
        fontWeight: fontWeight,
        fontSize: fontSize.sp,
        color: color,
        fontFamily: fontFamily,
        leadingDistribution: TextLeadingDistribution.even,
        // height: height,
      ),
    );
  }

  FontWeight get fontWeight {
    if (style == PjTextStyle.h1) return FontWeight.w700;
    if (style == PjTextStyle.h9 ||
        style == PjTextStyle.caption1 ||
        style == PjTextStyle.caption2 ||
        style == PjTextStyle.footnote) {
      return FontWeight.w500;
    }

    if (style == PjTextStyle.bodyBold || style == PjTextStyle.t3bold) return FontWeight.w600;
    return FontWeight.w400;
  }

  double get letterSpacing {
    if (style == PjTextStyle.h1) return 0.37;
    if (style == PjTextStyle.h8) return -0.24;
    if (style == PjTextStyle.h9 || style == PjTextStyle.t3 || style == PjTextStyle.t3bold) return 0.38;
    if (style == PjTextStyle.b1 || style == PjTextStyle.bodyBold) return -0.41;
    if (style == PjTextStyle.b5 || style == PjTextStyle.caption2) return 0.07;
    if (style == PjTextStyle.footnote) return -0.08;
    return -0.32;
  }

  double get fontSize {
    if (style == PjTextStyle.h1) return 34;
    if (style == PjTextStyle.h9 || style == PjTextStyle.caption1) return 12;
    if (style == PjTextStyle.b1 || style == PjTextStyle.bodyBold) return 17;
    if (style == PjTextStyle.b2 || style == PjTextStyle.callout) return 16;
    if (style == PjTextStyle.b5) return 10;
    if (style == PjTextStyle.caption2) return 11;
    if (style == PjTextStyle.footnote) return 13;
    if (style == PjTextStyle.t3 || style == PjTextStyle.t3bold) return 20;
    return 15;
  }

  double get height {
    if (style == PjTextStyle.h1) return 41 / 38;
    if (style == PjTextStyle.h9) return 24 / 12;
    if (style == PjTextStyle.b1 || style == PjTextStyle.bodyBold) return 22 / 17;
    if (style == PjTextStyle.b2 || style == PjTextStyle.callout) return 21 / 16;
    if (style == PjTextStyle.b5) return 12 / 10;
    if (style == PjTextStyle.caption1) return 16 / 12;
    if (style == PjTextStyle.caption2) return 13 / 11;
    if (style == PjTextStyle.footnote) return 18 / 13;
    if (style == PjTextStyle.t3 || style == PjTextStyle.t3bold) return 24 / 20;
    return 20 / 15;
  }

  String get fontFamily {
    if (style == PjTextStyle.h1 || style == PjTextStyle.h9 || style == PjTextStyle.t3 || style == PjTextStyle.t3bold) {
      return "SFProDisplay";
    }

    return "SFProText";
  }
}
