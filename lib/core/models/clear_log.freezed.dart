// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clear_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClearLog _$ClearLogFromJson(Map<String, dynamic> json) {
  return _ClearLog.fromJson(json);
}

/// @nodoc
mixin _$ClearLog {
  String get id => throw _privateConstructorUsedError;
  DateTime get clearedAt => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this ClearLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClearLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClearLogCopyWith<ClearLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClearLogCopyWith<$Res> {
  factory $ClearLogCopyWith(ClearLog value, $Res Function(ClearLog) then) =
      _$ClearLogCopyWithImpl<$Res, ClearLog>;
  @useResult
  $Res call({String id, DateTime clearedAt, String? note});
}

/// @nodoc
class _$ClearLogCopyWithImpl<$Res, $Val extends ClearLog>
    implements $ClearLogCopyWith<$Res> {
  _$ClearLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClearLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clearedAt = null,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            clearedAt: null == clearedAt
                ? _value.clearedAt
                : clearedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClearLogImplCopyWith<$Res>
    implements $ClearLogCopyWith<$Res> {
  factory _$$ClearLogImplCopyWith(
    _$ClearLogImpl value,
    $Res Function(_$ClearLogImpl) then,
  ) = __$$ClearLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime clearedAt, String? note});
}

/// @nodoc
class __$$ClearLogImplCopyWithImpl<$Res>
    extends _$ClearLogCopyWithImpl<$Res, _$ClearLogImpl>
    implements _$$ClearLogImplCopyWith<$Res> {
  __$$ClearLogImplCopyWithImpl(
    _$ClearLogImpl _value,
    $Res Function(_$ClearLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClearLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clearedAt = null,
    Object? note = freezed,
  }) {
    return _then(
      _$ClearLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        clearedAt: null == clearedAt
            ? _value.clearedAt
            : clearedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClearLogImpl implements _ClearLog {
  const _$ClearLogImpl({required this.id, required this.clearedAt, this.note});

  factory _$ClearLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClearLogImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime clearedAt;
  @override
  final String? note;

  @override
  String toString() {
    return 'ClearLog(id: $id, clearedAt: $clearedAt, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClearLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clearedAt, clearedAt) ||
                other.clearedAt == clearedAt) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, clearedAt, note);

  /// Create a copy of ClearLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClearLogImplCopyWith<_$ClearLogImpl> get copyWith =>
      __$$ClearLogImplCopyWithImpl<_$ClearLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClearLogImplToJson(this);
  }
}

abstract class _ClearLog implements ClearLog {
  const factory _ClearLog({
    required final String id,
    required final DateTime clearedAt,
    final String? note,
  }) = _$ClearLogImpl;

  factory _ClearLog.fromJson(Map<String, dynamic> json) =
      _$ClearLogImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get clearedAt;
  @override
  String? get note;

  /// Create a copy of ClearLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClearLogImplCopyWith<_$ClearLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
