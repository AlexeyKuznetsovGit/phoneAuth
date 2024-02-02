part of 'cb_profile_screen.dart';

@freezed
abstract class StProfileScreen with _$StProfileScreen {
  const factory StProfileScreen.init() = _Init;
  const factory StProfileScreen.loading() = _Loading;
  const factory StProfileScreen.error(String? error, String message) = _Error;
  const factory StProfileScreen.loaded() = _Loaded;
}