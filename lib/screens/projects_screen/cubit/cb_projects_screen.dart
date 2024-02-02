
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phone_auth/utils/pj_utils.dart';

part 'st_projects_screen.dart';

part 'cb_projects_screen.freezed.dart';

class CbProjectsScreen extends Cubit<StProjectsScreen> {
  CbProjectsScreen() : super(const StProjectsScreen.init());

  Future<void> getData() async {
    try {

    } on FirebaseException catch (e) {
      emit(StProjectsScreen.error(e.code, PjUtils.textError));
    }
  }
}
