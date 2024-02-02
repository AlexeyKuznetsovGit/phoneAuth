import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_auth/utils/pj_colors.dart';
import 'package:phone_auth/utils/pj_utils.dart';
import 'package:phone_auth/widgets/pj_text.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: Column(
                children: [
                  Container(
                    height: 162.w,
                    width: 359.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.r),
                      color: PjColors.background,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 42.w,
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.5.w, color: PjColors.lightGray))),
                          child: Center(
                            child: PjText(
                              'Выберите фото',
                              style: PjTextStyle.footnote,
                              color: PjColors.darkGray,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!(await getCameraPermission())) {
                              return;
                            }
                            final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                            if (image != null) {
                              Navigator.pop(context,{'path': image.path, 'image': image});
                            }
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.5.w, color: PjColors.lightGray))),
                            height: 60.w,
                            child: Center(
                                child: PjText(
                              'Камера',
                              style: PjTextStyle.t3,
                              color: PjColors.blue,
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!(await getGalleryPermission())) {
                              return;
                            }
                            final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              Navigator.pop(context,{'path': image.path, 'image': image});
                            }
                          },
                          behavior: HitTestBehavior.translucent,
                          child: SizedBox(
                            height: 60.w,
                            child: Center(
                                child: PjText(
                              'Галерея Фото',
                              style: PjTextStyle.t3,
                              color: PjColors.blue,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.pop();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      height: 60.w,
                      width: 359.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.r),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: PjText(
                          'Закрыть',
                          style: PjTextStyle.t3bold,
                          color: PjColors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
