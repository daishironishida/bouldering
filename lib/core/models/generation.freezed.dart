// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Generation _$GenerationFromJson(Map<String, dynamic> json) {
  return _Generation.fromJson(json);
}

/// @nodoc
mixin _$Generation {
  String get id => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get area => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<ClearLog> get clearLogs => throw _privateConstructorUsedError;

  /// Serializes this Generation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Generation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GenerationCopyWith<Generation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerationCopyWith<$Res> {
  factory $GenerationCopyWith(
    Generation value,
    $Res Function(Generation) then,
  ) = _$GenerationCopyWithImpl<$Res, Generation>;
  @useResult
  $Res call({
    String id,
    int order,
    bool isActive,
    String? label,
    String? area,
    DateTime createdAt,
    List<ClearLog> clearLogs,
  });
}

/// @nodoc
class _$GenerationCopyWithImpl<$Res, $Val extends Generation>
    implements $GenerationCopyWith<$Res> {
  _$GenerationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Generation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? isActive = null,
    Object? label = freezed,
    Object? area = freezed,
    Object? createdAt = null,
    Object? clearLogs = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            label: freezed == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String?,
            area: freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            clearLogs: null == clearLogs
                ? _value.clearLogs
                : clearLogs // ignore: cast_nullable_to_non_nullable
                      as List<ClearLog>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GenerationImplCopyWith<$Res>
    implements $GenerationCopyWith<$Res> {
  factory _$$GenerationImplCopyWith(
    _$GenerationImpl value,
    $Res Function(_$GenerationImpl) then,
  ) = __$$GenerationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int order,
    bool isActive,
    String? label,
    String? area,
    DateTime createdAt,
    List<ClearLog> clearLogs,
  });
}

/// @nodoc
class __$$GenerationImplCopyWithImpl<$Res>
    extends _$GenerationCopyWithImpl<$Res, _$GenerationImpl>
    implements _$$GenerationImplCopyWith<$Res> {
  __$$GenerationImplCopyWithImpl(
    _$GenerationImpl _value,
    $Res Function(_$GenerationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Generation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? isActive = null,
    Object? label = freezed,
    Object? area = freezed,
    Object? createdAt = null,
    Object? clearLogs = null,
  }) {
    return _then(
      _$GenerationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        label: freezed == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String?,
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        clearLogs: null == clearLogs
            ? _value._clearLogs
            : clearLogs // ignore: cast_nullable_to_non_nullable
                  as List<ClearLog>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerationImpl implements _Generation {
  const _$GenerationImpl({
    required this.id,
    required this.order,
    required this.isActive,
    this.label,
    this.area,
    required this.createdAt,
    final List<ClearLog> clearLogs = const [],
  }) : _clearLogs = clearLogs;

  factory _$GenerationImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenerationImplFromJson(json);

  @override
  final String id;
  @override
  final int order;
  @override
  final bool isActive;
  @override
  final String? label;
  @override
  final String? area;
  @override
  final DateTime createdAt;
  final List<ClearLog> _clearLogs;
  @override
  @JsonKey()
  List<ClearLog> get clearLogs {
    if (_clearLogs is EqualUnmodifiableListView) return _clearLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clearLogs);
  }

  @override
  String toString() {
    return 'Generation(id: $id, order: $order, isActive: $isActive, label: $label, area: $area, createdAt: $createdAt, clearLogs: $clearLogs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(
              other._clearLogs,
              _clearLogs,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    order,
    isActive,
    label,
    area,
    createdAt,
    const DeepCollectionEquality().hash(_clearLogs),
  );

  /// Create a copy of Generation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerationImplCopyWith<_$GenerationImpl> get copyWith =>
      __$$GenerationImplCopyWithImpl<_$GenerationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerationImplToJson(this);
  }
}

abstract class _Generation implements Generation {
  const factory _Generation({
    required final String id,
    required final int order,
    required final bool isActive,
    final String? label,
    final String? area,
    required final DateTime createdAt,
    final List<ClearLog> clearLogs,
  }) = _$GenerationImpl;

  factory _Generation.fromJson(Map<String, dynamic> json) =
      _$GenerationImpl.fromJson;

  @override
  String get id;
  @override
  int get order;
  @override
  bool get isActive;
  @override
  String? get label;
  @override
  String? get area;
  @override
  DateTime get createdAt;
  @override
  List<ClearLog> get clearLogs;

  /// Create a copy of Generation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenerationImplCopyWith<_$GenerationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
