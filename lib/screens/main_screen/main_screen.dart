import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth/router/router.dart';
import 'package:phone_auth/screens/main_screen/cubit/cb_main_screen.dart';
import 'package:phone_auth/utils/custom_icons.dart';
import 'package:phone_auth/utils/pj_colors.dart';
import 'package:phone_auth/utils/pj_icons.dart';

@RoutePage()
class MainScreen extends StatefulWidget implements AutoRouteWrapper {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbMainScreen>(
      create: (context) => CbMainScreen()..getUser(),
      child: this,
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CbMainScreen, StMainScreen>(
        builder: (context, state) => state.maybeWhen(
            orElse: () => Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                  color: PjColors.blue,
                ))),
            loaded: () => AutoTabsScaffold(
                backgroundColor: PjColors.background,
                routes: [ProjectsTab(), ProfileTab()],
                bottomNavigationBuilder: (context, tabsRouter) {
                  return Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border(top: BorderSide(width: 0.5.w, color: PjColors.lightGray))),
                      child: BottomNavigationBar(

                        backgroundColor:
                            tabsRouter.activeIndex == 0 ? PjColors.background : Color.fromRGBO(227, 227, 227, 1.0),
                        elevation: 0,
                        selectedItemColor: PjColors.blue,
                        type: BottomNavigationBarType.fixed,
                        showUnselectedLabels: true,
                        currentIndex: tabsRouter.activeIndex,
                        selectedLabelStyle: TextStyle(
                            color: PjColors.blue,
                            fontFamily: 'SFProText',
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            letterSpacing: 0.07,
                            height: 13 / 11),
                        unselectedLabelStyle: TextStyle(
                            color: PjColors.gray,
                            fontFamily: 'SFProText',
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            letterSpacing: 0.07,
                            height: 13 / 11),
                        onTap: tabsRouter.setActiveIndex,
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(
                                CustomIcons.projects,
                                size: 20.w,
                              ),
                              label: "Мои проекты"),
                          BottomNavigationBarItem(icon: Icon(CustomIcons.profile, size: 20.w), label: "Мой аккаунт"),
                        ],
                      ),
                    ),
                  );
                })));
  }
}
