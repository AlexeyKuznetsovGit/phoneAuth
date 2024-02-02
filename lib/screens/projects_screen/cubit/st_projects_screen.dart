part of 'cb_projects_screen.dart';

@freezed
abstract class StProjectsScreen with _$StProjectsScreen {
  const factory StProjectsScreen.init() = _Init;
  const factory StProjectsScreen.loading() = _Loading;
  const factory StProjectsScreen.error(String? error, String? message) = _Error;
  const factory StProjectsScreen.loaded() = _Loaded;
}