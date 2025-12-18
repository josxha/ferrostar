// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lib.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FerrostarRouteRequest {
  String get url => throw _privateConstructorUsedError;
  List<(String, String)> get headers => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, List<(String, String)> headers)
    httpGet,
    required TResult Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )
    httpPost,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, List<(String, String)> headers)? httpGet,
    TResult? Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )?
    httpPost,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, List<(String, String)> headers)? httpGet,
    TResult Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )?
    httpPost,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FerrostarRouteRequest_HttpGet value) httpGet,
    required TResult Function(FerrostarRouteRequest_HttpPost value) httpPost,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FerrostarRouteRequest_HttpGet value)? httpGet,
    TResult? Function(FerrostarRouteRequest_HttpPost value)? httpPost,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FerrostarRouteRequest_HttpGet value)? httpGet,
    TResult Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FerrostarRouteRequestCopyWith<FerrostarRouteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FerrostarRouteRequestCopyWith<$Res> {
  factory $FerrostarRouteRequestCopyWith(
    FerrostarRouteRequest value,
    $Res Function(FerrostarRouteRequest) then,
  ) = _$FerrostarRouteRequestCopyWithImpl<$Res, FerrostarRouteRequest>;
  @useResult
  $Res call({String url, List<(String, String)> headers});
}

/// @nodoc
class _$FerrostarRouteRequestCopyWithImpl<
  $Res,
  $Val extends FerrostarRouteRequest
>
    implements $FerrostarRouteRequestCopyWith<$Res> {
  _$FerrostarRouteRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? headers = null}) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            headers: null == headers
                ? _value.headers
                : headers // ignore: cast_nullable_to_non_nullable
                      as List<(String, String)>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FerrostarRouteRequest_HttpGetImplCopyWith<$Res>
    implements $FerrostarRouteRequestCopyWith<$Res> {
  factory _$$FerrostarRouteRequest_HttpGetImplCopyWith(
    _$FerrostarRouteRequest_HttpGetImpl value,
    $Res Function(_$FerrostarRouteRequest_HttpGetImpl) then,
  ) = __$$FerrostarRouteRequest_HttpGetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, List<(String, String)> headers});
}

/// @nodoc
class __$$FerrostarRouteRequest_HttpGetImplCopyWithImpl<$Res>
    extends
        _$FerrostarRouteRequestCopyWithImpl<
          $Res,
          _$FerrostarRouteRequest_HttpGetImpl
        >
    implements _$$FerrostarRouteRequest_HttpGetImplCopyWith<$Res> {
  __$$FerrostarRouteRequest_HttpGetImplCopyWithImpl(
    _$FerrostarRouteRequest_HttpGetImpl _value,
    $Res Function(_$FerrostarRouteRequest_HttpGetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? headers = null}) {
    return _then(
      _$FerrostarRouteRequest_HttpGetImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        headers: null == headers
            ? _value._headers
            : headers // ignore: cast_nullable_to_non_nullable
                  as List<(String, String)>,
      ),
    );
  }
}

/// @nodoc

class _$FerrostarRouteRequest_HttpGetImpl
    extends FerrostarRouteRequest_HttpGet {
  const _$FerrostarRouteRequest_HttpGetImpl({
    required this.url,
    required final List<(String, String)> headers,
  }) : _headers = headers,
       super._();

  @override
  final String url;
  final List<(String, String)> _headers;
  @override
  List<(String, String)> get headers {
    if (_headers is EqualUnmodifiableListView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_headers);
  }

  @override
  String toString() {
    return 'FerrostarRouteRequest.httpGet(url: $url, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FerrostarRouteRequest_HttpGetImpl &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    url,
    const DeepCollectionEquality().hash(_headers),
  );

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FerrostarRouteRequest_HttpGetImplCopyWith<
    _$FerrostarRouteRequest_HttpGetImpl
  >
  get copyWith =>
      __$$FerrostarRouteRequest_HttpGetImplCopyWithImpl<
        _$FerrostarRouteRequest_HttpGetImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, List<(String, String)> headers)
    httpGet,
    required TResult Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )
    httpPost,
  }) {
    return httpGet(url, headers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, List<(String, String)> headers)? httpGet,
    TResult? Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )?
    httpPost,
  }) {
    return httpGet?.call(url, headers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, List<(String, String)> headers)? httpGet,
    TResult Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )?
    httpPost,
    required TResult orElse(),
  }) {
    if (httpGet != null) {
      return httpGet(url, headers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FerrostarRouteRequest_HttpGet value) httpGet,
    required TResult Function(FerrostarRouteRequest_HttpPost value) httpPost,
  }) {
    return httpGet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FerrostarRouteRequest_HttpGet value)? httpGet,
    TResult? Function(FerrostarRouteRequest_HttpPost value)? httpPost,
  }) {
    return httpGet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FerrostarRouteRequest_HttpGet value)? httpGet,
    TResult Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    required TResult orElse(),
  }) {
    if (httpGet != null) {
      return httpGet(this);
    }
    return orElse();
  }
}

abstract class FerrostarRouteRequest_HttpGet extends FerrostarRouteRequest {
  const factory FerrostarRouteRequest_HttpGet({
    required final String url,
    required final List<(String, String)> headers,
  }) = _$FerrostarRouteRequest_HttpGetImpl;
  const FerrostarRouteRequest_HttpGet._() : super._();

  @override
  String get url;
  @override
  List<(String, String)> get headers;

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FerrostarRouteRequest_HttpGetImplCopyWith<
    _$FerrostarRouteRequest_HttpGetImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FerrostarRouteRequest_HttpPostImplCopyWith<$Res>
    implements $FerrostarRouteRequestCopyWith<$Res> {
  factory _$$FerrostarRouteRequest_HttpPostImplCopyWith(
    _$FerrostarRouteRequest_HttpPostImpl value,
    $Res Function(_$FerrostarRouteRequest_HttpPostImpl) then,
  ) = __$$FerrostarRouteRequest_HttpPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, List<(String, String)> headers, Uint8List body});
}

/// @nodoc
class __$$FerrostarRouteRequest_HttpPostImplCopyWithImpl<$Res>
    extends
        _$FerrostarRouteRequestCopyWithImpl<
          $Res,
          _$FerrostarRouteRequest_HttpPostImpl
        >
    implements _$$FerrostarRouteRequest_HttpPostImplCopyWith<$Res> {
  __$$FerrostarRouteRequest_HttpPostImplCopyWithImpl(
    _$FerrostarRouteRequest_HttpPostImpl _value,
    $Res Function(_$FerrostarRouteRequest_HttpPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? headers = null, Object? body = null}) {
    return _then(
      _$FerrostarRouteRequest_HttpPostImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        headers: null == headers
            ? _value._headers
            : headers // ignore: cast_nullable_to_non_nullable
                  as List<(String, String)>,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as Uint8List,
      ),
    );
  }
}

/// @nodoc

class _$FerrostarRouteRequest_HttpPostImpl
    extends FerrostarRouteRequest_HttpPost {
  const _$FerrostarRouteRequest_HttpPostImpl({
    required this.url,
    required final List<(String, String)> headers,
    required this.body,
  }) : _headers = headers,
       super._();

  @override
  final String url;
  final List<(String, String)> _headers;
  @override
  List<(String, String)> get headers {
    if (_headers is EqualUnmodifiableListView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_headers);
  }

  @override
  final Uint8List body;

  @override
  String toString() {
    return 'FerrostarRouteRequest.httpPost(url: $url, headers: $headers, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FerrostarRouteRequest_HttpPostImpl &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            const DeepCollectionEquality().equals(other.body, body));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    url,
    const DeepCollectionEquality().hash(_headers),
    const DeepCollectionEquality().hash(body),
  );

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FerrostarRouteRequest_HttpPostImplCopyWith<
    _$FerrostarRouteRequest_HttpPostImpl
  >
  get copyWith =>
      __$$FerrostarRouteRequest_HttpPostImplCopyWithImpl<
        _$FerrostarRouteRequest_HttpPostImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url, List<(String, String)> headers)
    httpGet,
    required TResult Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )
    httpPost,
  }) {
    return httpPost(url, headers, body);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, List<(String, String)> headers)? httpGet,
    TResult? Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )?
    httpPost,
  }) {
    return httpPost?.call(url, headers, body);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, List<(String, String)> headers)? httpGet,
    TResult Function(
      String url,
      List<(String, String)> headers,
      Uint8List body,
    )?
    httpPost,
    required TResult orElse(),
  }) {
    if (httpPost != null) {
      return httpPost(url, headers, body);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FerrostarRouteRequest_HttpGet value) httpGet,
    required TResult Function(FerrostarRouteRequest_HttpPost value) httpPost,
  }) {
    return httpPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FerrostarRouteRequest_HttpGet value)? httpGet,
    TResult? Function(FerrostarRouteRequest_HttpPost value)? httpPost,
  }) {
    return httpPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FerrostarRouteRequest_HttpGet value)? httpGet,
    TResult Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    required TResult orElse(),
  }) {
    if (httpPost != null) {
      return httpPost(this);
    }
    return orElse();
  }
}

abstract class FerrostarRouteRequest_HttpPost extends FerrostarRouteRequest {
  const factory FerrostarRouteRequest_HttpPost({
    required final String url,
    required final List<(String, String)> headers,
    required final Uint8List body,
  }) = _$FerrostarRouteRequest_HttpPostImpl;
  const FerrostarRouteRequest_HttpPost._() : super._();

  @override
  String get url;
  @override
  List<(String, String)> get headers;
  Uint8List get body;

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FerrostarRouteRequest_HttpPostImplCopyWith<
    _$FerrostarRouteRequest_HttpPostImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LocationBias {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double field0) left,
    required TResult Function(double field0) right,
    required TResult Function(double field0) random,
    required TResult Function() none,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double field0)? left,
    TResult? Function(double field0)? right,
    TResult? Function(double field0)? random,
    TResult? Function()? none,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double field0)? left,
    TResult Function(double field0)? right,
    TResult Function(double field0)? random,
    TResult Function()? none,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationBias_Left value) left,
    required TResult Function(LocationBias_Right value) right,
    required TResult Function(LocationBias_Random value) random,
    required TResult Function(LocationBias_None value) none,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationBias_Left value)? left,
    TResult? Function(LocationBias_Right value)? right,
    TResult? Function(LocationBias_Random value)? random,
    TResult? Function(LocationBias_None value)? none,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationBias_Left value)? left,
    TResult Function(LocationBias_Right value)? right,
    TResult Function(LocationBias_Random value)? random,
    TResult Function(LocationBias_None value)? none,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationBiasCopyWith<$Res> {
  factory $LocationBiasCopyWith(
    LocationBias value,
    $Res Function(LocationBias) then,
  ) = _$LocationBiasCopyWithImpl<$Res, LocationBias>;
}

/// @nodoc
class _$LocationBiasCopyWithImpl<$Res, $Val extends LocationBias>
    implements $LocationBiasCopyWith<$Res> {
  _$LocationBiasCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LocationBias_LeftImplCopyWith<$Res> {
  factory _$$LocationBias_LeftImplCopyWith(
    _$LocationBias_LeftImpl value,
    $Res Function(_$LocationBias_LeftImpl) then,
  ) = __$$LocationBias_LeftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double field0});
}

/// @nodoc
class __$$LocationBias_LeftImplCopyWithImpl<$Res>
    extends _$LocationBiasCopyWithImpl<$Res, _$LocationBias_LeftImpl>
    implements _$$LocationBias_LeftImplCopyWith<$Res> {
  __$$LocationBias_LeftImplCopyWithImpl(
    _$LocationBias_LeftImpl _value,
    $Res Function(_$LocationBias_LeftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? field0 = null}) {
    return _then(
      _$LocationBias_LeftImpl(
        null == field0
            ? _value.field0
            : field0 // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$LocationBias_LeftImpl extends LocationBias_Left {
  const _$LocationBias_LeftImpl(this.field0) : super._();

  @override
  final double field0;

  @override
  String toString() {
    return 'LocationBias.left(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationBias_LeftImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationBias_LeftImplCopyWith<_$LocationBias_LeftImpl> get copyWith =>
      __$$LocationBias_LeftImplCopyWithImpl<_$LocationBias_LeftImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double field0) left,
    required TResult Function(double field0) right,
    required TResult Function(double field0) random,
    required TResult Function() none,
  }) {
    return left(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double field0)? left,
    TResult? Function(double field0)? right,
    TResult? Function(double field0)? random,
    TResult? Function()? none,
  }) {
    return left?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double field0)? left,
    TResult Function(double field0)? right,
    TResult Function(double field0)? random,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (left != null) {
      return left(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationBias_Left value) left,
    required TResult Function(LocationBias_Right value) right,
    required TResult Function(LocationBias_Random value) random,
    required TResult Function(LocationBias_None value) none,
  }) {
    return left(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationBias_Left value)? left,
    TResult? Function(LocationBias_Right value)? right,
    TResult? Function(LocationBias_Random value)? random,
    TResult? Function(LocationBias_None value)? none,
  }) {
    return left?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationBias_Left value)? left,
    TResult Function(LocationBias_Right value)? right,
    TResult Function(LocationBias_Random value)? random,
    TResult Function(LocationBias_None value)? none,
    required TResult orElse(),
  }) {
    if (left != null) {
      return left(this);
    }
    return orElse();
  }
}

abstract class LocationBias_Left extends LocationBias {
  const factory LocationBias_Left(final double field0) =
      _$LocationBias_LeftImpl;
  const LocationBias_Left._() : super._();

  double get field0;

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationBias_LeftImplCopyWith<_$LocationBias_LeftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationBias_RightImplCopyWith<$Res> {
  factory _$$LocationBias_RightImplCopyWith(
    _$LocationBias_RightImpl value,
    $Res Function(_$LocationBias_RightImpl) then,
  ) = __$$LocationBias_RightImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double field0});
}

/// @nodoc
class __$$LocationBias_RightImplCopyWithImpl<$Res>
    extends _$LocationBiasCopyWithImpl<$Res, _$LocationBias_RightImpl>
    implements _$$LocationBias_RightImplCopyWith<$Res> {
  __$$LocationBias_RightImplCopyWithImpl(
    _$LocationBias_RightImpl _value,
    $Res Function(_$LocationBias_RightImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? field0 = null}) {
    return _then(
      _$LocationBias_RightImpl(
        null == field0
            ? _value.field0
            : field0 // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$LocationBias_RightImpl extends LocationBias_Right {
  const _$LocationBias_RightImpl(this.field0) : super._();

  @override
  final double field0;

  @override
  String toString() {
    return 'LocationBias.right(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationBias_RightImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationBias_RightImplCopyWith<_$LocationBias_RightImpl> get copyWith =>
      __$$LocationBias_RightImplCopyWithImpl<_$LocationBias_RightImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double field0) left,
    required TResult Function(double field0) right,
    required TResult Function(double field0) random,
    required TResult Function() none,
  }) {
    return right(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double field0)? left,
    TResult? Function(double field0)? right,
    TResult? Function(double field0)? random,
    TResult? Function()? none,
  }) {
    return right?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double field0)? left,
    TResult Function(double field0)? right,
    TResult Function(double field0)? random,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (right != null) {
      return right(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationBias_Left value) left,
    required TResult Function(LocationBias_Right value) right,
    required TResult Function(LocationBias_Random value) random,
    required TResult Function(LocationBias_None value) none,
  }) {
    return right(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationBias_Left value)? left,
    TResult? Function(LocationBias_Right value)? right,
    TResult? Function(LocationBias_Random value)? random,
    TResult? Function(LocationBias_None value)? none,
  }) {
    return right?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationBias_Left value)? left,
    TResult Function(LocationBias_Right value)? right,
    TResult Function(LocationBias_Random value)? random,
    TResult Function(LocationBias_None value)? none,
    required TResult orElse(),
  }) {
    if (right != null) {
      return right(this);
    }
    return orElse();
  }
}

abstract class LocationBias_Right extends LocationBias {
  const factory LocationBias_Right(final double field0) =
      _$LocationBias_RightImpl;
  const LocationBias_Right._() : super._();

  double get field0;

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationBias_RightImplCopyWith<_$LocationBias_RightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationBias_RandomImplCopyWith<$Res> {
  factory _$$LocationBias_RandomImplCopyWith(
    _$LocationBias_RandomImpl value,
    $Res Function(_$LocationBias_RandomImpl) then,
  ) = __$$LocationBias_RandomImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double field0});
}

/// @nodoc
class __$$LocationBias_RandomImplCopyWithImpl<$Res>
    extends _$LocationBiasCopyWithImpl<$Res, _$LocationBias_RandomImpl>
    implements _$$LocationBias_RandomImplCopyWith<$Res> {
  __$$LocationBias_RandomImplCopyWithImpl(
    _$LocationBias_RandomImpl _value,
    $Res Function(_$LocationBias_RandomImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? field0 = null}) {
    return _then(
      _$LocationBias_RandomImpl(
        null == field0
            ? _value.field0
            : field0 // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$LocationBias_RandomImpl extends LocationBias_Random {
  const _$LocationBias_RandomImpl(this.field0) : super._();

  @override
  final double field0;

  @override
  String toString() {
    return 'LocationBias.random(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationBias_RandomImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationBias_RandomImplCopyWith<_$LocationBias_RandomImpl> get copyWith =>
      __$$LocationBias_RandomImplCopyWithImpl<_$LocationBias_RandomImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double field0) left,
    required TResult Function(double field0) right,
    required TResult Function(double field0) random,
    required TResult Function() none,
  }) {
    return random(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double field0)? left,
    TResult? Function(double field0)? right,
    TResult? Function(double field0)? random,
    TResult? Function()? none,
  }) {
    return random?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double field0)? left,
    TResult Function(double field0)? right,
    TResult Function(double field0)? random,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (random != null) {
      return random(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationBias_Left value) left,
    required TResult Function(LocationBias_Right value) right,
    required TResult Function(LocationBias_Random value) random,
    required TResult Function(LocationBias_None value) none,
  }) {
    return random(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationBias_Left value)? left,
    TResult? Function(LocationBias_Right value)? right,
    TResult? Function(LocationBias_Random value)? random,
    TResult? Function(LocationBias_None value)? none,
  }) {
    return random?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationBias_Left value)? left,
    TResult Function(LocationBias_Right value)? right,
    TResult Function(LocationBias_Random value)? random,
    TResult Function(LocationBias_None value)? none,
    required TResult orElse(),
  }) {
    if (random != null) {
      return random(this);
    }
    return orElse();
  }
}

abstract class LocationBias_Random extends LocationBias {
  const factory LocationBias_Random(final double field0) =
      _$LocationBias_RandomImpl;
  const LocationBias_Random._() : super._();

  double get field0;

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationBias_RandomImplCopyWith<_$LocationBias_RandomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationBias_NoneImplCopyWith<$Res> {
  factory _$$LocationBias_NoneImplCopyWith(
    _$LocationBias_NoneImpl value,
    $Res Function(_$LocationBias_NoneImpl) then,
  ) = __$$LocationBias_NoneImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LocationBias_NoneImplCopyWithImpl<$Res>
    extends _$LocationBiasCopyWithImpl<$Res, _$LocationBias_NoneImpl>
    implements _$$LocationBias_NoneImplCopyWith<$Res> {
  __$$LocationBias_NoneImplCopyWithImpl(
    _$LocationBias_NoneImpl _value,
    $Res Function(_$LocationBias_NoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationBias
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LocationBias_NoneImpl extends LocationBias_None {
  const _$LocationBias_NoneImpl() : super._();

  @override
  String toString() {
    return 'LocationBias.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LocationBias_NoneImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double field0) left,
    required TResult Function(double field0) right,
    required TResult Function(double field0) random,
    required TResult Function() none,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double field0)? left,
    TResult? Function(double field0)? right,
    TResult? Function(double field0)? random,
    TResult? Function()? none,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double field0)? left,
    TResult Function(double field0)? right,
    TResult Function(double field0)? random,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationBias_Left value) left,
    required TResult Function(LocationBias_Right value) right,
    required TResult Function(LocationBias_Random value) random,
    required TResult Function(LocationBias_None value) none,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationBias_Left value)? left,
    TResult? Function(LocationBias_Right value)? right,
    TResult? Function(LocationBias_Random value)? random,
    TResult? Function(LocationBias_None value)? none,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationBias_Left value)? left,
    TResult Function(LocationBias_Right value)? right,
    TResult Function(LocationBias_Random value)? random,
    TResult Function(LocationBias_None value)? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class LocationBias_None extends LocationBias {
  const factory LocationBias_None() = _$LocationBias_NoneImpl;
  const LocationBias_None._() : super._();
}

/// @nodoc
mixin _$SimulationError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String error) polylineError,
    required TResult Function() notEnoughPoints,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String error)? polylineError,
    TResult? Function()? notEnoughPoints,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String error)? polylineError,
    TResult Function()? notEnoughPoints,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationError_PolylineError value)
    polylineError,
    required TResult Function(SimulationError_NotEnoughPoints value)
    notEnoughPoints,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationError_PolylineError value)? polylineError,
    TResult? Function(SimulationError_NotEnoughPoints value)? notEnoughPoints,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationError_PolylineError value)? polylineError,
    TResult Function(SimulationError_NotEnoughPoints value)? notEnoughPoints,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationErrorCopyWith<$Res> {
  factory $SimulationErrorCopyWith(
    SimulationError value,
    $Res Function(SimulationError) then,
  ) = _$SimulationErrorCopyWithImpl<$Res, SimulationError>;
}

/// @nodoc
class _$SimulationErrorCopyWithImpl<$Res, $Val extends SimulationError>
    implements $SimulationErrorCopyWith<$Res> {
  _$SimulationErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SimulationError_PolylineErrorImplCopyWith<$Res> {
  factory _$$SimulationError_PolylineErrorImplCopyWith(
    _$SimulationError_PolylineErrorImpl value,
    $Res Function(_$SimulationError_PolylineErrorImpl) then,
  ) = __$$SimulationError_PolylineErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$SimulationError_PolylineErrorImplCopyWithImpl<$Res>
    extends
        _$SimulationErrorCopyWithImpl<$Res, _$SimulationError_PolylineErrorImpl>
    implements _$$SimulationError_PolylineErrorImplCopyWith<$Res> {
  __$$SimulationError_PolylineErrorImplCopyWithImpl(
    _$SimulationError_PolylineErrorImpl _value,
    $Res Function(_$SimulationError_PolylineErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$SimulationError_PolylineErrorImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SimulationError_PolylineErrorImpl
    extends SimulationError_PolylineError {
  const _$SimulationError_PolylineErrorImpl({required this.error}) : super._();

  @override
  final String error;

  @override
  String toString() {
    return 'SimulationError.polylineError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationError_PolylineErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of SimulationError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationError_PolylineErrorImplCopyWith<
    _$SimulationError_PolylineErrorImpl
  >
  get copyWith =>
      __$$SimulationError_PolylineErrorImplCopyWithImpl<
        _$SimulationError_PolylineErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String error) polylineError,
    required TResult Function() notEnoughPoints,
  }) {
    return polylineError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String error)? polylineError,
    TResult? Function()? notEnoughPoints,
  }) {
    return polylineError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String error)? polylineError,
    TResult Function()? notEnoughPoints,
    required TResult orElse(),
  }) {
    if (polylineError != null) {
      return polylineError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationError_PolylineError value)
    polylineError,
    required TResult Function(SimulationError_NotEnoughPoints value)
    notEnoughPoints,
  }) {
    return polylineError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationError_PolylineError value)? polylineError,
    TResult? Function(SimulationError_NotEnoughPoints value)? notEnoughPoints,
  }) {
    return polylineError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationError_PolylineError value)? polylineError,
    TResult Function(SimulationError_NotEnoughPoints value)? notEnoughPoints,
    required TResult orElse(),
  }) {
    if (polylineError != null) {
      return polylineError(this);
    }
    return orElse();
  }
}

abstract class SimulationError_PolylineError extends SimulationError {
  const factory SimulationError_PolylineError({required final String error}) =
      _$SimulationError_PolylineErrorImpl;
  const SimulationError_PolylineError._() : super._();

  String get error;

  /// Create a copy of SimulationError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationError_PolylineErrorImplCopyWith<
    _$SimulationError_PolylineErrorImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SimulationError_NotEnoughPointsImplCopyWith<$Res> {
  factory _$$SimulationError_NotEnoughPointsImplCopyWith(
    _$SimulationError_NotEnoughPointsImpl value,
    $Res Function(_$SimulationError_NotEnoughPointsImpl) then,
  ) = __$$SimulationError_NotEnoughPointsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SimulationError_NotEnoughPointsImplCopyWithImpl<$Res>
    extends
        _$SimulationErrorCopyWithImpl<
          $Res,
          _$SimulationError_NotEnoughPointsImpl
        >
    implements _$$SimulationError_NotEnoughPointsImplCopyWith<$Res> {
  __$$SimulationError_NotEnoughPointsImplCopyWithImpl(
    _$SimulationError_NotEnoughPointsImpl _value,
    $Res Function(_$SimulationError_NotEnoughPointsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SimulationError_NotEnoughPointsImpl
    extends SimulationError_NotEnoughPoints {
  const _$SimulationError_NotEnoughPointsImpl() : super._();

  @override
  String toString() {
    return 'SimulationError.notEnoughPoints()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationError_NotEnoughPointsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String error) polylineError,
    required TResult Function() notEnoughPoints,
  }) {
    return notEnoughPoints();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String error)? polylineError,
    TResult? Function()? notEnoughPoints,
  }) {
    return notEnoughPoints?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String error)? polylineError,
    TResult Function()? notEnoughPoints,
    required TResult orElse(),
  }) {
    if (notEnoughPoints != null) {
      return notEnoughPoints();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimulationError_PolylineError value)
    polylineError,
    required TResult Function(SimulationError_NotEnoughPoints value)
    notEnoughPoints,
  }) {
    return notEnoughPoints(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimulationError_PolylineError value)? polylineError,
    TResult? Function(SimulationError_NotEnoughPoints value)? notEnoughPoints,
  }) {
    return notEnoughPoints?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimulationError_PolylineError value)? polylineError,
    TResult Function(SimulationError_NotEnoughPoints value)? notEnoughPoints,
    required TResult orElse(),
  }) {
    if (notEnoughPoints != null) {
      return notEnoughPoints(this);
    }
    return orElse();
  }
}

abstract class SimulationError_NotEnoughPoints extends SimulationError {
  const factory SimulationError_NotEnoughPoints() =
      _$SimulationError_NotEnoughPointsImpl;
  const SimulationError_NotEnoughPoints._() : super._();
}
