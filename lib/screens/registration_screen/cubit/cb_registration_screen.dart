import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phone_auth/repository/get_it.dart';
import 'package:phone_auth/repository/user_repository.dart';
import 'package:phone_auth/utils/pj_utils.dart';
import 'package:phone_auth/utils/singleton/sg_app_data.dart';

part 'st_registration_screen.dart';

part 'cb_registration_screen.freezed.dart';

class CbRegistrationScreen extends Cubit<StRegistrationScreen> {
  CbRegistrationScreen() : super(const StRegistrationScreen.init());
  String _verificationId = '';

  Future<void> sendPhoneNum(String phoneNum) async {
    try {
      emit(StRegistrationScreen.init());
      _verificationId = '';
      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNum,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            emit(StRegistrationScreen.error(e.code, PjUtils.textError));
          },
          codeSent: (String verificationId, int? token) {
            _verificationId = verificationId;
            emit(StRegistrationScreen.successVerifyPhone());
          },
          codeAutoRetrievalTimeout: (e) {});
    } on FirebaseAuthException catch (e) {
      emit(StRegistrationScreen.error(e.code, PjUtils.textError));
    }
  }

  void changeState(StRegistrationScreen state) {
    if (state is _Init) {
      emit(const StRegistrationScreen.init());
    }
  }

  Future<void> verifySmsCode({
    required String smsCode,
  }) async {
    try {
      if (_verificationId.isNotEmpty) {
        emit(StRegistrationScreen.loading());
        FirebaseAuth auth = FirebaseAuth.instance;

        PhoneAuthCredential credential =
            PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: smsCode);
        await auth.signInWithCredential(credential).then((result) {
          if (result.user != null && result.user?.phoneNumber != null) {
            getIt<UserRepository>().createUser(uid: result.user!.uid, phoneNumber: result.user!.phoneNumber!);
          }
        });
        emit(StRegistrationScreen.successVerifyCode());
      }
    } on FirebaseAuthException catch (e) {
      emit(StRegistrationScreen.error(e.code, PjUtils.textError));
    }
  }
}
