import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_auth/router/router.dart';
import 'package:phone_auth/screens/profile_screen/components/avatar_widget.dart';
import 'package:phone_auth/screens/profile_screen/components/photo_picker.dart';
import 'package:phone_auth/screens/profile_screen/cubit/cb_profile_screen.dart';
import 'package:phone_auth/utils/custom_icons.dart';
import 'package:phone_auth/utils/pj_colors.dart';
import 'package:phone_auth/utils/singleton/sg_app_data.dart';
import 'package:phone_auth/widgets/pj_app_bar.dart';
import 'package:phone_auth/widgets/pj_error_dialog.dart';
import 'package:phone_auth/widgets/pj_loading_dialog.dart';
import 'package:phone_auth/widgets/pj_text.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbProfileScreen>(
      create: (context) => CbProfileScreen(),
      child: this,
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PjAppBar(
        leadingText: 'Мой аккаунт',
        title: 'Аккаунт',
      ),
      backgroundColor: PjColors.background,
      body: BlocConsumer<CbProfileScreen, StProfileScreen>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              loaded: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              error: (code, message) {
                showAlertDialog(context, code ?? '', message, () {
                  context.read<CbProfileScreen>().changeState(StProfileScreen.init());
                }, true);
              },
              loading: () {
                showLoader(context);
              });
        },
        builder: (context, state) => state.maybeWhen(
          orElse: () {
            return _buildBodyContent(context);
          },
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 24.w,
            ),
            AvatarWidget(
              onTap: () async {
                Map<String, dynamic>? result = await showDialog(
                  barrierColor: PjColors.black.withOpacity(0.5),
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return PhotoPicker();
                  },
                );
                if (result != null) {
                  await context.read<CbProfileScreen>().getUserAvatar(
                        path: result['path'],
                        image: result['image'],
                        uid: SgAppData.instance.user.uid!,
                      );
                  setState(() {});
                }
              },
            ),
            SizedBox(
              height: 12.5.w,
            ),
            PjText(
              'apollo@gmail.com',
              style: PjTextStyle.caption1,
              color: PjColors.darkGray,
            ),
            SizedBox(
              height: 28.w,
            ),
            Flexible(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await context.router.push(EditProfileRoute(
                            isName: index == 0,
                            data: index == 0 ? SgAppData.instance.user.name : SgAppData.instance.user.lastName));
                        setState(() {});
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        height: 48.h,
                        width: 359.w,
                        decoration: BoxDecoration(
                            color: PjColors.superWhite,
                            border: Border(bottom: BorderSide(width: 1.w, color: PjColors.lightGray)),
                            borderRadius: index == 0
                                ? BorderRadius.only(topRight: Radius.circular(13.r), topLeft: Radius.circular(13.r))
                                : null),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16.w,
                            ),
                            PjText(index == 0 ? 'Имя' : 'Фамилия', style: PjTextStyle.callout),
                            Spacer(),
                            Container(
                              width: 160.w,
                              height: 24.w,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(vertical: 1.5.w),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                child: PjText(
                                    index == 0
                                        ? (SgAppData.instance.user.name!.isEmpty
                                            ? 'Настроить'
                                            : SgAppData.instance.user.name!)
                                        : (SgAppData.instance.user.lastName!.isEmpty
                                            ? 'Настроить'
                                            : SgAppData.instance.user.lastName!),
                                    style: PjTextStyle.callout,
                                    color: index == 0
                                        ? (SgAppData.instance.user.name!.isEmpty ? PjColors.lightGray : PjColors.darkGray)
                                        : (SgAppData.instance.user.lastName!.isEmpty
                                            ? PjColors.lightGray
                                            : PjColors.darkGray)),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                CustomIcons.arrow,
                                size: 20.w,
                                color: PjColors.lightGray,
                              ),
                            ),
                            SizedBox(
                              width: 13.5.w,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 2),
            )
          ],
        ),
      ),
    );
  }
}
