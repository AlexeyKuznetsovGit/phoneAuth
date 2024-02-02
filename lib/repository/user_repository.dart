import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_auth/models/user_model.dart';

class UserRepository {
  Future<void> createUser({required String uid, required String phoneNumber}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({'uid': uid, 'phoneNumber': phoneNumber});
  }

  Future<UserModel> getUser({required String uid}) async {
    Map<String, dynamic> response = {};
    await FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      if (value.data() != null) {
        response = value.data()!;
      }
    });
    return UserModel.fromJson(response);
  }

  Future<void> uploadImageToStorage({required String path, required XFile image, required String uid }) async {
    final ref = FirebaseStorage.instance.ref(path).child(image.name);
    await ref.putFile(File(image.path));
    String url = await ref.getDownloadURL();
    await FirebaseFirestore.instance.collection('users').doc(uid).update({"avatarUrl": url});
  }

  Future<void> editUserInfo({required String data, required String uid, required bool isName}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update(isName ? {"name": data} : {"lastName": data});
  }
}
