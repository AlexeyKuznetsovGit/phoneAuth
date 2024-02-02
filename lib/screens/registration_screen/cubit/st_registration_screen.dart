part of 'cb_registration_screen.dart';

@freezed
abstract class StRegistrationScreen with _$StRegistrationScreen {
  const factory StRegistrationScreen.init() = _Init;
  const factory StRegistrationScreen.loading() = _Loading;
  const factory StRegistrationScreen.error(String? error, String message) = _Error;
  const factory StRegistrationScreen.successVerifyPhone() = _SuccessVerifyPhone;
  const factory StRegistrationScreen.successVerifyCode() = _SuccessVerifyCode;
}