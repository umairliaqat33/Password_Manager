// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'password_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PasswordStates {
  bool get enableUpperCase => throw _privateConstructorUsedError;
  bool get enableSymbols => throw _privateConstructorUsedError;
  bool get enableDigits => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PasswordStatesCopyWith<PasswordStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordStatesCopyWith<$Res> {
  factory $PasswordStatesCopyWith(
          PasswordStates value, $Res Function(PasswordStates) then) =
      _$PasswordStatesCopyWithImpl<$Res>;
  $Res call({bool enableUpperCase, bool enableSymbols, bool enableDigits});
}

/// @nodoc
class _$PasswordStatesCopyWithImpl<$Res>
    implements $PasswordStatesCopyWith<$Res> {
  _$PasswordStatesCopyWithImpl(this._value, this._then);

  final PasswordStates _value;
  // ignore: unused_field
  final $Res Function(PasswordStates) _then;

  @override
  $Res call({
    Object? enableUpperCase = freezed,
    Object? enableSymbols = freezed,
    Object? enableDigits = freezed,
  }) {
    return _then(_value.copyWith(
      enableUpperCase: enableUpperCase == freezed
          ? _value.enableUpperCase
          : enableUpperCase // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSymbols: enableSymbols == freezed
          ? _value.enableSymbols
          : enableSymbols // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDigits: enableDigits == freezed
          ? _value.enableDigits
          : enableDigits // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_PasswordStatesCopyWith<$Res>
    implements $PasswordStatesCopyWith<$Res> {
  factory _$$_PasswordStatesCopyWith(
          _$_PasswordStates value, $Res Function(_$_PasswordStates) then) =
      __$$_PasswordStatesCopyWithImpl<$Res>;
  @override
  $Res call({bool enableUpperCase, bool enableSymbols, bool enableDigits});
}

/// @nodoc
class __$$_PasswordStatesCopyWithImpl<$Res>
    extends _$PasswordStatesCopyWithImpl<$Res>
    implements _$$_PasswordStatesCopyWith<$Res> {
  __$$_PasswordStatesCopyWithImpl(
      _$_PasswordStates _value, $Res Function(_$_PasswordStates) _then)
      : super(_value, (v) => _then(v as _$_PasswordStates));

  @override
  _$_PasswordStates get _value => super._value as _$_PasswordStates;

  @override
  $Res call({
    Object? enableUpperCase = freezed,
    Object? enableSymbols = freezed,
    Object? enableDigits = freezed,
  }) {
    return _then(_$_PasswordStates(
      enableUpperCase: enableUpperCase == freezed
          ? _value.enableUpperCase
          : enableUpperCase // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSymbols: enableSymbols == freezed
          ? _value.enableSymbols
          : enableSymbols // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDigits: enableDigits == freezed
          ? _value.enableDigits
          : enableDigits // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PasswordStates implements _PasswordStates {
  const _$_PasswordStates(
      {required this.enableUpperCase,
      required this.enableSymbols,
      required this.enableDigits});

  @override
  final bool enableUpperCase;
  @override
  final bool enableSymbols;
  @override
  final bool enableDigits;

  @override
  String toString() {
    return 'PasswordStates(enableUpperCase: $enableUpperCase, enableSymbols: $enableSymbols, enableDigits: $enableDigits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PasswordStates &&
            const DeepCollectionEquality()
                .equals(other.enableUpperCase, enableUpperCase) &&
            const DeepCollectionEquality()
                .equals(other.enableSymbols, enableSymbols) &&
            const DeepCollectionEquality()
                .equals(other.enableDigits, enableDigits));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(enableUpperCase),
      const DeepCollectionEquality().hash(enableSymbols),
      const DeepCollectionEquality().hash(enableDigits));

  @JsonKey(ignore: true)
  @override
  _$$_PasswordStatesCopyWith<_$_PasswordStates> get copyWith =>
      __$$_PasswordStatesCopyWithImpl<_$_PasswordStates>(this, _$identity);
}

abstract class _PasswordStates implements PasswordStates {
  const factory _PasswordStates(
      {required final bool enableUpperCase,
      required final bool enableSymbols,
      required final bool enableDigits}) = _$_PasswordStates;

  @override
  bool get enableUpperCase;
  @override
  bool get enableSymbols;
  @override
  bool get enableDigits;
  @override
  @JsonKey(ignore: true)
  _$$_PasswordStatesCopyWith<_$_PasswordStates> get copyWith =>
      throw _privateConstructorUsedError;
}
