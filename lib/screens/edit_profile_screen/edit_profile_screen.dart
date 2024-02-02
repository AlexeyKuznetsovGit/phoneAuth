import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_auth/screens/edit_profile_screen/cubit/cb_edit_profile_screen.dart';
import 'package:phone_auth/utils/pj_colors.dart';
import 'package:phone_auth/utils/singleton/sg_app_data.dart';
import 'package:phone_auth/widgets/pj_app_bar.dart';
import 'package:phone_auth/widgets/pj_error_dialog.dart';
import 'package:phone_auth/widgets/pj_loading_dialog.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const EditProfileScreen({super.key, this.data, required this.isName});

  final String? data;
  final bool isName;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbEditProfileScreen>(
      create: (context) => CbEditProfileScreen(),
      child: this,
    );
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _controllerText = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    if (widget.data != null) {
      _controllerText.text = widget.data!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controllerText.text.isNotEmpty) {
          _focusNode.unfocus();
          context
              .read<CbEditProfileScreen>()
              .editUserInfo(uid: SgAppData.instance.user.uid!, data: _controllerText.text, isName: widget.isName);
        } else {
          _focusNode.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: PjColors.background,
        appBar: PjAppBar(
          leading: () {
            context.router.pop();
          },
          leadingText: 'Аккаунт',
          title: widget.isName ? 'Ваше Имя' : 'Ваша Фамилия',
        ),
        body: BlocConsumer<CbEditProfileScreen, StEditProfileScreen>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                loaded: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  context.router.pop();
                },
                error: (code, message) {
                  showAlertDialog(context, code ?? '', message, () {

                    context.read<CbEditProfileScreen>().changeState(StEditProfileScreen.init());
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
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.w, left: 8.w),
      child: SizedBox(
          width: 358.w,
          height: 45.w,
          child: TextFormField(
            focusNode: _focusNode,
            onChanged: (val) {
              setState(() {
                _controllerText.text = val;
              });
            },
            onEditingComplete: () {
              if (_controllerText.text.isNotEmpty) {
                _focusNode.unfocus();
                context
                    .read<CbEditProfileScreen>()
                    .editUserInfo(uid: SgAppData.instance.user.uid!, data: _controllerText.text, isName: widget.isName);
              } else {
                _focusNode.unfocus();
              }
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            controller: _controllerText,
            style: TextStyle(
              height: 21 / 16,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              letterSpacing: -0.32,
              color: PjColors.darkGray,
              leadingDistribution: TextLeadingDistribution.even,
            ),
            textCapitalization: TextCapitalization.sentences,
            autovalidateMode: AutovalidateMode.disabled,
            decoration: InputDecoration(
              hintText: widget.isName ? "Ваше Имя" : 'Ваша Фамилия',
              hintStyle: TextStyle(
                height: 21 / 16,
                fontFamily: 'SFProText',
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                letterSpacing: -0.32,
                color: PjColors.lightGray,
                leadingDistribution: TextLeadingDistribution.even,
              ),
              isCollapsed: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              isDense: true,
              filled: true,
              fillColor: PjColors.superWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
            ),
          )),
    );
  }
}
