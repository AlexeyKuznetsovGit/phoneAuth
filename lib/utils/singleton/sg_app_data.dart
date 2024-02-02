import 'package:phone_auth/models/user_model.dart';

class SgAppData {
  SgAppData._();

  static SgAppData instance = SgAppData._();

  static UserModel _user = UserModel();

  set user(UserModel v) => _user = v;

  UserModel get user => _user;
}
