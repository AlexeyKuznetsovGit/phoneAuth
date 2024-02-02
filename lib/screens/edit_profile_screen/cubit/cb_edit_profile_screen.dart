import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth/repository/get_it.dart';
import 'package:phone_auth/repository/user_repository.dart';
import 'package:phone_auth/utils/pj_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phone_auth/utils/singleton/sg_app_data.dart';

part 'st_edit_profile_screen.dart';

part 'cb_edit_profile_screen.freezed.dart';

class CbEditProfileScreen extends Cubit<StEditProfileScreen> {
  CbEditProfileScreen() : super(const StEditProfileScreen.init());

  Future<void> editUserInfo(
      {required String uid, required String data, required bool isName}) async {
    try {
      emit(StEditProfileScreen.loading());
      await (getIt<UserRepository>().editUserInfo(uid: uid, data: data, isName: isName));
      SgAppData.instance.user = await (getIt<UserRepository>().getUser(uid: uid));
      emit(StEditProfileScreen.loaded());
    } on FirebaseException catch (e) {
      emit(StEditProfileScreen.error(e.code, PjUtils.textError));
    }
  }
  void changeState(StEditProfileScreen state) {
    if (state is _Init) {
      emit(const StEditProfileScreen.init());
    }
  }
}