import 'package:flutter/material.dart';
import 'package:phone_auth/utils/pj_colors.dart';

void showLoader(BuildContext context,[GlobalKey<FormState>? dialogKey ]) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
            child: CircularProgressIndicator(
              color: PjColors.blue,
            ),
          ));
}

