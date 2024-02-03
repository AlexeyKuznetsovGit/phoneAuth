import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phone_auth/router/router.dart';
import 'package:phone_auth/screens/registration_screen/components/phone_field.dart';
import 'package:phone_auth/screens/registration_screen/cubit/cb_registration_screen.dart';
import 'package:phone_auth/utils/pj_colors.dart';
import 'package:phone_auth/utils/pj_icons.dart';
import 'package:phone_auth/utils/singleton/sg_app_data.dart';
import 'package:phone_auth/widgets/pj_app_bar.dart';
import 'package:phone_auth/widgets/pj_error_dialog.dart';
import 'package:phone_auth/widgets/pj_loading_dialog.dart';
import 'package:phone_auth/widgets/pj_text.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget implements AutoRouteWrapper {
  const RegistrationScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbRegistrationScreen>(
      create: (context) => CbRegistrationScreen(),
      child: this,
    );
  }

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final MaskTextInputFormatter formatter =
      MaskTextInputFormatter(mask: '(###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
  final FocusNode _focusNode = FocusNode();
  bool isPhoneFilled = false;
  final TextEditingController _controller = TextEditingController();
  int _currentPage = 0;
  PageController _pageController = PageController();
  Timer _timer = Timer(Duration(), () {});
  int _secondsRemaining = 60;
  bool isSuccessful = false;

  @override
  void initState() {
    _timer.cancel();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: PjColors.white,
        appBar: PjAppBar(
          type: AppBarType.registration,
          leading: () {
            if (_currentPage != 0) {
              _pageController.animateToPage(_currentPage - 1,
                  duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            }
          },
        ),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocConsumer<CbRegistrationScreen, StRegistrationScreen>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  successVerifyCode: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    context.router.replace(MainRoute());
                  },
                  successVerifyPhone: () {
                    isSuccessful = true;
                    if (_currentPage == 0) {
                      _pageController.animateToPage(_currentPage + 1,
                          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }
                  },
                  error: (code, message) {
                    showAlertDialog(context, code ?? '', message, () {
                      context.read<CbRegistrationScreen>().changeState(StRegistrationScreen.init());
                    }, _currentPage != 0, _currentPage == 0 ? Colors.black.withOpacity(0.5) : Colors.transparent);
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
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0 && _currentPage != 0) {
            _pageController.animateToPage(_currentPage - 1,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          } else if (isSuccessful && details.delta.dx < 0 && _currentPage == 0) {
            _pageController.animateToPage(_currentPage + 1,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        },
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [_buildSignUpContent(context), _buildNumberConfirmationContent(context)],
        ),
      ),
    );
  }

  Widget _buildSignUpContent(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 4.w,
          ),
          SizedBox(
            height: 36.w,
            width: 196.w,
            child: Row(
              children: [
                for (int index = 0; index < 3; index++) ...[
                  Container(
                    alignment: Alignment.center,
                    height: 36.w,
                    width: 36.w,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: index == 0 ? PjColors.orange : PjColors.darkWhite),
                    child: PjText('${index + 1}', style: PjTextStyle.h8),
                  ),
                  if (index != 2) ...[
                    Container(
                      width: 44.w,
                      height: 1.w,
                      color: PjColors.darkWhite,
                    ),
                  ]
                ]
              ],
            ),
          ),
          SizedBox(
            height: 24.w,
          ),
          Column(
            children: [
              PjText('Регистрация', style: PjTextStyle.h1),
              SizedBox(
                height: 24.w,
              ),
              SizedBox(
                  width: 199.w,
                  child: PjText(
                    'Введите номер телефона для регистрации',
                    style: PjTextStyle.h8,
                    align: TextAlign.center,
                  )),
            ],
          ),
          SizedBox(
            height: 38.w,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 2.w),
            margin: EdgeInsets.only(left: 16.w),
            alignment: Alignment.centerLeft,
            height: 24.w,
            child: PjText(
              'Номер телефона',
              style: PjTextStyle.h9,
            ),
          ),
          PhoneField(
              focusNode: _focusNode,
              formatter: formatter,
              controller: _controller,
              onChange: (text) {
                if (formatter.getUnmaskedText().length == 10) {
                  if (formatter.getUnmaskedText() != '9999999999') {
                    setState(() {
                      isPhoneFilled = true;
                      _focusNode.unfocus();
                    });
                  }
                }
                if (formatter.getUnmaskedText().length < 10) {
                  setState(() {
                    isPhoneFilled = false;
                  });
                }
              }),
          if (_timer.isActive) ...[
            SizedBox(
              height: 24.w,
            ),
            PjText('$_secondsRemaining сек до повтора отправки кода', style: PjTextStyle.h8),
            SizedBox(
              height: 76.w,
            ),
          ] else ...[
            SizedBox(
              height: 120.w,
            ),
          ],
          GestureDetector(
            onTap: isPhoneFilled && !_timer.isActive
                ? () {
                    setState(() {
                      isSuccessful = false;
                      _startTimer();
                    });

                    context.read<CbRegistrationScreen>().sendPhoneNum("+7${formatter.getUnmaskedText()}");
                  }
                : () {},
            child: Container(
              width: 285.w,
              alignment: Alignment.center,
              height: 53.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: isPhoneFilled && !_timer.isActive ? PjColors.orange : PjColors.gray),
              child: PjText(
                'Отправить смс-код',
                style: PjTextStyle.b2,
              ),
            ),
          ),
          SizedBox(
            height: 8.w,
          ),
          SizedBox(
            width: 232.w,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Нажимая на данную кнопку, вы даете согласие на обработку ',
                    style: TextStyle(
                        color: PjColors.gray,
                        fontFamily: 'SFProText',
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        letterSpacing: 0.07,
                        height: 12 / 10),
                  ),
                  TextSpan(
                    text: 'персональных данных',
                    style: TextStyle(
                        color: PjColors.orange,
                        fontFamily: 'SFProText',
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        letterSpacing: 0.07,
                        height: 12 / 10),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNumberConfirmationContent(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 4.w,
          ),
          SizedBox(
            height: 36.w,
            width: 196.w,
            child: Row(
              children: [
                for (int index = 0; index < 3; index++) ...[
                  if (index == 0) ...[
                    Container(
                      alignment: Alignment.center,
                      height: 36.w,
                      width: 36.w,
                      padding: EdgeInsets.all(8.w),
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.w, color: PjColors.green)),
                      child: SvgPicture.asset(PjIcons.successful, height: 20.w, width: 20.w),
                    ),
                  ] else ...[
                    Container(
                      alignment: Alignment.center,
                      height: 36.w,
                      width: 36.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: index == 1 ? PjColors.orange : PjColors.darkWhite),
                      child: PjText('${index + 1}', style: PjTextStyle.h8),
                    ),
                  ],
                  if (index != 2) ...[
                    Container(
                      width: 44.w,
                      height: 1.w,
                      color: PjColors.darkWhite,
                    ),
                  ]
                ]
              ],
            ),
          ),
          SizedBox(
            height: 24.w,
          ),
          Column(
            children: [
              PjText('Подтверждение', style: PjTextStyle.h1),
              SizedBox(
                height: 24.w,
              ),
              SizedBox(
                  width: 272.w,
                  child: PjText(
                    'Введите код, который мы отправили в SMS на +7${formatter.getMaskedText()}',
                    style: PjTextStyle.h8,
                    align: TextAlign.center,
                  )),
              SizedBox(
                height: 24.w,
              ),
              Pinput(
                length: 6,
                showCursor: false,
                onCompleted: (pin) {
                  context.read<CbRegistrationScreen>().verifySmsCode(smsCode: pin);
                },
                defaultPinTheme: PinTheme(
                    textStyle: TextStyle(
                        color: PjColors.black,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w400,
                        fontSize: 28.sp,
                        letterSpacing: 0.36,
                        height: 34 / 28),
                    width: 39.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                        color: PjColors.white, border: Border(bottom: BorderSide(width: 2.w, color: PjColors.gray))),
                    padding: EdgeInsets.only(bottom: 2.w)),
              ),
              SizedBox(
                height: 44.w,
              ),
              _timer.isActive
                  ? PjText('$_secondsRemaining сек до повтора отправки кода', style: PjTextStyle.h8)
                  : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          _startTimer();
                          context.read<CbRegistrationScreen>().sendPhoneNum("+7${formatter.getUnmaskedText()}");
                        });
                      },
                      child: PjText(
                        'Отправить код еще раз',
                        style: PjTextStyle.h8,
                        color: PjColors.orange,
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          timer.cancel();
          _secondsRemaining = 60;
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }
}
