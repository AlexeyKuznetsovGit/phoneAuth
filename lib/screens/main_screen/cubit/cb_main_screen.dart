import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phone_auth/models/user_model.dart';
import 'package:phone_auth/repository/get_it.dart';
import 'package:phone_auth/repository/user_repository.dart';
import 'package:phone_auth/utils/pj_utils.dart';
import 'package:phone_auth/utils/singleton/sg_app_data.dart';

part 'st_main_screen.dart';

part 'cb_main_screen.freezed.dart';

class CbMainScreen extends Cubit<StMainScreen> {
  CbMainScreen() : super(const StMainScreen.init());

  Future<void> getUser() async {
    try {
     UserModel user = await (getIt<UserRepository>().getUser(uid: FirebaseAuth.instance.currentUser!.uid));
     SgAppData.instance.user = user;
     log(SgAppData.instance.user.toJson().toString(), name: 'user');
     emit(StMainScreen.loaded());
    } on FirebaseException catch (e) {
      emit(StMainScreen.error(e.code, PjUtils.textError));
    }
  }
}
