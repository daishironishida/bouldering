// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gym.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Gym _$GymFromJson(Map<String, dynamic> json) {
  return _Gym.fromJson(json);
}

/// @nodoc
mixin _$Gym {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<GradeConfig> get grades => throw _privateConstructorUsedError;
  List<String> get areas => throw _privateConstructorUsedError;

  /// Serializes this Gym to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Gym
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GymCopyWith<Gym> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GymCopyWith<$Res> {
  factory $GymCopyWith(Gym value, $Res Function(Gym) then) =
      _$GymCopyWithImpl<$Res, Gym>;
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    List<GradeConfig> grades,
    List<String> areas,
  });
}

/// @nodoc
class _$GymCopyWithImpl<$Res, $Val extends Gym> implements $GymCopyWith<$Res> {
  _$GymCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Gym
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? grades = null,
    Object? areas = null,
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
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            grades: null == grades
                ? _value.grades
                : grades // ignore: cast_nullable_to_non_nullable
                      as List<GradeConfig>,
            areas: null == areas
                ? _value.areas
                : areas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GymImplCopyWith<$Res> implements $GymCopyWith<$Res> {
  factory _$$GymImplCopyWith(_$GymImpl value, $Res Function(_$GymImpl) then) =
      __$$GymImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    List<GradeConfig> grades,
    List<String> areas,
  });
}

/// @nodoc
class __$$GymImplCopyWithImpl<$Res> extends _$GymCopyWithImpl<$Res, _$GymImpl>
    implements _$$GymImplCopyWith<$Res> {
  __$$GymImplCopyWithImpl(_$GymImpl _value, $Res Function(_$GymImpl) _then)
    : super(_value, _then);

  /// Create a copy of Gym
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? grades = null,
    Object? areas = null,
  }) {
    return _then(
      _$GymImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        grades: null == grades
            ? _value._grades
            : grades // ignore: cast_nullable_to_non_nullable
                  as List<GradeConfig>,
        areas: null == areas
            ? _value._areas
            : areas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GymImpl implements _Gym {
  const _$GymImpl({
    required this.id,
    required this.name,
    required this.createdAt,
    final List<GradeConfig> grades = const [],
    final List<String> areas = const [],
  }) : _grades = grades,
       _areas = areas;

  factory _$GymImpl.fromJson(Map<String, dynamic> json) =>
      _$$GymImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  final List<GradeConfig> _grades;
  @override
  @JsonKey()
  List<GradeConfig> get grades {
    if (_grades is EqualUnmodifiableListView) return _grades;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grades);
  }

  final List<String> _areas;
  @override
  @JsonKey()
  List<String> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  String toString() {
    return 'Gym(id: $id, name: $name, createdAt: $createdAt, grades: $grades, areas: $areas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GymImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._grades, _grades) &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    createdAt,
    const DeepCollectionEquality().hash(_grades),
    const DeepCollectionEquality().hash(_areas),
  );

  /// Create a copy of Gym
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GymImplCopyWith<_$GymImpl> get copyWith =>
      __$$GymImplCopyWithImpl<_$GymImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GymImplToJson(this);
  }
}

abstract class _Gym implements Gym {
  const factory _Gym({
    required final String id,
    required final String name,
    required final DateTime createdAt,
    final List<GradeConfig> grades,
    final List<String> areas,
  }) = _$GymImpl;

  factory _Gym.fromJson(Map<String, dynamic> json) = _$GymImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  List<GradeConfig> get grades;
  @override
  List<String> get areas;

  /// Create a copy of Gym
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GymImplCopyWith<_$GymImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
