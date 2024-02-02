part of 'cb_edit_profile_screen.dart';

@freezed
abstract class StEditProfileScreen with _$StEditProfileScreen {
  const factory StEditProfileScreen.init() = _Init;
  const factory StEditProfileScreen.loading() = _Loading;
  const factory StEditProfileScreen.error(String? error, String message) = _Error;
  const factory StEditProfileScreen.loaded() = _Loaded;
}