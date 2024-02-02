import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_auth/screens/projects_screen/cubit/cb_projects_screen.dart';
import 'package:phone_auth/utils/pj_colors.dart';

@RoutePage()
class ProjectsScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CbProjectsScreen>(
      create: (context) => CbProjectsScreen(),
      child: this,
    );
  }
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PjColors.background,
      body: SafeArea(child: Container(height: 0.5.w, color: PjColors.lightGray,),),
    );
  }
}
