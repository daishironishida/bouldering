// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'problem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Problem _$ProblemFromJson(Map<String, dynamic> json) {
  return _Problem.fromJson(json);
}

/// @nodoc
mixin _$Problem {
  String get id => throw _privateConstructorUsedError;
  String get gymId => throw _privateConstructorUsedError;
  String get gradeId => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  List<Generation> get generations => throw _privateConstructorUsedError;

  /// Serializes this Problem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProblemCopyWith<Problem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProblemCopyWith<$Res> {
  factory $ProblemCopyWith(Problem value, $Res Function(Problem) then) =
      _$ProblemCopyWithImpl<$Res, Problem>;
  @useResult
  $Res call({
    String id,
    String gymId,
    String gradeId,
    int number,
    List<Generation> generations,
  });
}

/// @nodoc
class _$ProblemCopyWithImpl<$Res, $Val extends Problem>
    implements $ProblemCopyWith<$Res> {
  _$ProblemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gymId = null,
    Object? gradeId = null,
    Object? number = null,
    Object? generations = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            gymId: null == gymId
                ? _value.gymId
                : gymId // ignore: cast_nullable_to_non_nullable
                      as String,
            gradeId: null == gradeId
                ? _value.gradeId
                : gradeId // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            generations: null == generations
                ? _value.generations
                : generations // ignore: cast_nullable_to_non_nullable
                      as List<Generation>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProblemImplCopyWith<$Res> implements $ProblemCopyWith<$Res> {
  factory _$$ProblemImplCopyWith(
    _$ProblemImpl value,
    $Res Function(_$ProblemImpl) then,
  ) = __$$ProblemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String gymId,
    String gradeId,
    int number,
    List<Generation> generations,
  });
}

/// @nodoc
class __$$ProblemImplCopyWithImpl<$Res>
    extends _$ProblemCopyWithImpl<$Res, _$ProblemImpl>
    implements _$$ProblemImplCopyWith<$Res> {
  __$$ProblemImplCopyWithImpl(
    _$ProblemImpl _value,
    $Res Function(_$ProblemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gymId = null,
    Object? gradeId = null,
    Object? number = null,
    Object? generations = null,
  }) {
    return _then(
      _$ProblemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        gymId: null == gymId
            ? _value.gymId
            : gymId // ignore: cast_nullable_to_non_nullable
                  as String,
        gradeId: null == gradeId
            ? _value.gradeId
            : gradeId // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        generations: null == generations
            ? _value._generations
            : generations // ignore: cast_nullable_to_non_nullable
                  as List<Generation>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProblemImpl implements _Problem {
  const _$ProblemImpl({
    required this.id,
    required this.gymId,
    required this.gradeId,
    required this.number,
    final List<Generation> generations = const [],
  }) : _generations = generations;

  factory _$ProblemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProblemImplFromJson(json);

  @override
  final String id;
  @override
  final String gymId;
  @override
  final String gradeId;
  @override
  final int number;
  final List<Generation> _generations;
  @override
  @JsonKey()
  List<Generation> get generations {
    if (_generations is EqualUnmodifiableListView) return _generations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_generations);
  }

  @override
  String toString() {
    return 'Problem(id: $id, gymId: $gymId, gradeId: $gradeId, number: $number, generations: $generations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProblemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gymId, gymId) || other.gymId == gymId) &&
            (identical(other.gradeId, gradeId) || other.gradeId == gradeId) &&
            (identical(other.number, number) || other.number == number) &&
            const DeepCollectionEquality().equals(
              other._generations,
              _generations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    gymId,
    gradeId,
    number,
    const DeepCollectionEquality().hash(_generations),
  );

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProblemImplCopyWith<_$ProblemImpl> get copyWith =>
      __$$ProblemImplCopyWithImpl<_$ProblemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProblemImplToJson(this);
  }
}

abstract class _Problem implements Problem {
  const factory _Problem({
    required final String id,
    required final String gymId,
    required final String gradeId,
    required final int number,
    final List<Generation> generations,
  }) = _$ProblemImpl;

  factory _Problem.fromJson(Map<String, dynamic> json) = _$ProblemImpl.fromJson;

  @override
  String get id;
  @override
  String get gymId;
  @override
  String get gradeId;
  @override
  int get number;
  @override
  List<Generation> get generations;

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProblemImplCopyWith<_$ProblemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
