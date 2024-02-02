import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_auth/repository/get_it.dart';
import 'package:phone_auth/repository/user_repository.dart';
import 'package:phone_auth/utils/pj_utils.dart';
import 'package:phone_auth/utils/singleton/sg_app_data.dart';

part 'st_profile_screen.dart';

part 'cb_profile_screen.freezed.dart';

class CbProfileScreen extends Cubit<StProfileScreen> {
  CbProfileScreen() : super(const StProfileScreen.init());

  Future<void> getUserAvatar(
      {required String path, required XFile image, required String uid}) async {
    try {
      emit(StProfileScreen.loading());
      await (getIt<UserRepository>().uploadImageToStorage(path: path, image: image, uid: uid));
      SgAppData.instance.user = await (getIt<UserRepository>().getUser(uid: uid));
      emit(StProfileScreen.loaded());
    } on FirebaseException catch (e) {
      emit(StProfileScreen.error(e.code, PjUtils.textError));
    }
  }
  void changeState(StProfileScreen state) {
    if (state is _Init) {
      emit(const StProfileScreen.init());
    }
  }
}
