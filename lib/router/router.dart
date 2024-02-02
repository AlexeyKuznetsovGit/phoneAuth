import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:phone_auth/screens/main_screen/main_screen.dart';
import 'package:phone_auth/screens/profile_screen/profile_screen.dart';
import 'package:phone_auth/screens/projects_screen/projects_screen.dart';
import 'package:phone_auth/screens/registration_screen/registration_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Widget|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: RegistrationRoute.page, initial: FirebaseAuth.instance.currentUser == null ? true : false),
        AutoRoute(
            path: '/',
            page: MainRoute.page,
            initial: FirebaseAuth.instance.currentUser != null ? true : false,
            children: [
              AutoRoute(page: ProfileTab.page, children: [
                AutoRoute(page: ProfileRoute.page, initial: true),
                AutoRoute(page: EditProfileRoute.page, path: 'edit')
              ]),
              AutoRoute(page: ProjectsTab.page, initial: true, children: [
                AutoRoute(page: ProjectsRoute.page, initial: true),
              ])
            ])
      ];
}

@RoutePage(name: 'ProfileTab')
class ProfileTabPage extends AutoRouter {
  const ProfileTabPage({super.key});
}

@RoutePage(name: 'ProjectsTab')
class ProjectsTabPage extends AutoRouter {
  const ProjectsTabPage({super.key});
}
