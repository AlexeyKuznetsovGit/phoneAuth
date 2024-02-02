part of 'cb_main_screen.dart';

@freezed
abstract class StMainScreen with _$StMainScreen {
  const factory StMainScreen.init() = _Init;
  const factory StMainScreen.loading() = _Loading;
  const factory StMainScreen.error(String? error, String? message) = _Error;
  const factory StMainScreen.loaded() = _Loaded;
}