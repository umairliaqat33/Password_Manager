import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_states.freezed.dart';

@freezed
class PasswordStates with _$PasswordStates {
  const factory PasswordStates({
    required bool enableUpperCase,
    required bool enableSymbols,
    required bool enableDigits,
  }) = _PasswordStates;
}