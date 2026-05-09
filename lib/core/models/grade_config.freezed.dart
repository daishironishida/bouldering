// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GradeConfig _$GradeConfigFromJson(Map<String, dynamic> json) {
  return _GradeConfig.fromJson(json);
}

/// @nodoc
mixin _$GradeConfig {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get colorHex => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  /// Serializes this GradeConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GradeConfigCopyWith<GradeConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GradeConfigCopyWith<$Res> {
  factory $GradeConfigCopyWith(
    GradeConfig value,
    $Res Function(GradeConfig) then,
  ) = _$GradeConfigCopyWithImpl<$Res, GradeConfig>;
  @useResult
  $Res call({String id, String name, String colorHex, int order});
}

/// @nodoc
class _$GradeConfigCopyWithImpl<$Res, $Val extends GradeConfig>
    implements $GradeConfigCopyWith<$Res> {
  _$GradeConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? colorHex = null,
    Object? order = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            colorHex: null == colorHex
                ? _value.colorHex
                : colorHex // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GradeConfigImplCopyWith<$Res>
    implements $GradeConfigCopyWith<$Res> {
  factory _$$GradeConfigImplCopyWith(
    _$GradeConfigImpl value,
    $Res Function(_$GradeConfigImpl) then,
  ) = __$$GradeConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String colorHex, int order});
}

/// @nodoc
class __$$GradeConfigImplCopyWithImpl<$Res>
    extends _$GradeConfigCopyWithImpl<$Res, _$GradeConfigImpl>
    implements _$$GradeConfigImplCopyWith<$Res> {
  __$$GradeConfigImplCopyWithImpl(
    _$GradeConfigImpl _value,
    $Res Function(_$GradeConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? colorHex = null,
    Object? order = null,
  }) {
    return _then(
      _$GradeConfigImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        colorHex: null == colorHex
            ? _value.colorHex
            : colorHex // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GradeConfigImpl implements _GradeConfig {
  const _$GradeConfigImpl({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.order,
  });

  factory _$GradeConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GradeConfigImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String colorHex;
  @override
  final int order;

  @override
  String toString() {
    return 'GradeConfig(id: $id, name: $name, colorHex: $colorHex, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GradeConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, colorHex, order);

  /// Create a copy of GradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GradeConfigImplCopyWith<_$GradeConfigImpl> get copyWith =>
      __$$GradeConfigImplCopyWithImpl<_$GradeConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GradeConfigImplToJson(this);
  }
}

abstract class _GradeConfig implements GradeConfig {
  const factory _GradeConfig({
    required final String id,
    required final String name,
    required final String colorHex,
    required final int order,
  }) = _$GradeConfigImpl;

  factory _GradeConfig.fromJson(Map<String, dynamic> json) =
      _$GradeConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get colorHex;
  @override
  int get order;

  /// Create a copy of GradeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GradeConfigImplCopyWith<_$GradeConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
