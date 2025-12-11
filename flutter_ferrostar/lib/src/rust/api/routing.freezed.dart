// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routing.dart';

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
  Map<String, String> get headers => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String url,
      Map<String, String> headers,
      Uint8List body,
    )
    httpPost,
    required TResult Function(String url, Map<String, String> headers) httpGet,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, Map<String, String> headers, Uint8List body)?
    httpPost,
    TResult? Function(String url, Map<String, String> headers)? httpGet,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, Map<String, String> headers, Uint8List body)?
    httpPost,
    TResult Function(String url, Map<String, String> headers)? httpGet,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FerrostarRouteRequest_HttpPost value) httpPost,
    required TResult Function(FerrostarRouteRequest_HttpGet value) httpGet,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    TResult? Function(FerrostarRouteRequest_HttpGet value)? httpGet,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    TResult Function(FerrostarRouteRequest_HttpGet value)? httpGet,
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
  $Res call({String url, Map<String, String> headers});
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
                      as Map<String, String>,
          )
          as $Val,
    );
  }
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
  $Res call({String url, Map<String, String> headers, Uint8List body});
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
                  as Map<String, String>,
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
    required final Map<String, String> headers,
    required this.body,
  }) : _headers = headers,
       super._();

  @override
  final String url;
  final Map<String, String> _headers;
  @override
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
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
    required TResult Function(
      String url,
      Map<String, String> headers,
      Uint8List body,
    )
    httpPost,
    required TResult Function(String url, Map<String, String> headers) httpGet,
  }) {
    return httpPost(url, headers, body);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, Map<String, String> headers, Uint8List body)?
    httpPost,
    TResult? Function(String url, Map<String, String> headers)? httpGet,
  }) {
    return httpPost?.call(url, headers, body);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, Map<String, String> headers, Uint8List body)?
    httpPost,
    TResult Function(String url, Map<String, String> headers)? httpGet,
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
    required TResult Function(FerrostarRouteRequest_HttpPost value) httpPost,
    required TResult Function(FerrostarRouteRequest_HttpGet value) httpGet,
  }) {
    return httpPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    TResult? Function(FerrostarRouteRequest_HttpGet value)? httpGet,
  }) {
    return httpPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    TResult Function(FerrostarRouteRequest_HttpGet value)? httpGet,
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
    required final Map<String, String> headers,
    required final Uint8List body,
  }) = _$FerrostarRouteRequest_HttpPostImpl;
  const FerrostarRouteRequest_HttpPost._() : super._();

  @override
  String get url;
  @override
  Map<String, String> get headers;
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
abstract class _$$FerrostarRouteRequest_HttpGetImplCopyWith<$Res>
    implements $FerrostarRouteRequestCopyWith<$Res> {
  factory _$$FerrostarRouteRequest_HttpGetImplCopyWith(
    _$FerrostarRouteRequest_HttpGetImpl value,
    $Res Function(_$FerrostarRouteRequest_HttpGetImpl) then,
  ) = __$$FerrostarRouteRequest_HttpGetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, Map<String, String> headers});
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
                  as Map<String, String>,
      ),
    );
  }
}

/// @nodoc

class _$FerrostarRouteRequest_HttpGetImpl
    extends FerrostarRouteRequest_HttpGet {
  const _$FerrostarRouteRequest_HttpGetImpl({
    required this.url,
    required final Map<String, String> headers,
  }) : _headers = headers,
       super._();

  @override
  final String url;
  final Map<String, String> _headers;
  @override
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
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
    required TResult Function(
      String url,
      Map<String, String> headers,
      Uint8List body,
    )
    httpPost,
    required TResult Function(String url, Map<String, String> headers) httpGet,
  }) {
    return httpGet(url, headers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url, Map<String, String> headers, Uint8List body)?
    httpPost,
    TResult? Function(String url, Map<String, String> headers)? httpGet,
  }) {
    return httpGet?.call(url, headers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url, Map<String, String> headers, Uint8List body)?
    httpPost,
    TResult Function(String url, Map<String, String> headers)? httpGet,
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
    required TResult Function(FerrostarRouteRequest_HttpPost value) httpPost,
    required TResult Function(FerrostarRouteRequest_HttpGet value) httpGet,
  }) {
    return httpGet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    TResult? Function(FerrostarRouteRequest_HttpGet value)? httpGet,
  }) {
    return httpGet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FerrostarRouteRequest_HttpPost value)? httpPost,
    TResult Function(FerrostarRouteRequest_HttpGet value)? httpGet,
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
    required final Map<String, String> headers,
  }) = _$FerrostarRouteRequest_HttpGetImpl;
  const FerrostarRouteRequest_HttpGet._() : super._();

  @override
  String get url;
  @override
  Map<String, String> get headers;

  /// Create a copy of FerrostarRouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FerrostarRouteRequest_HttpGetImplCopyWith<
    _$FerrostarRouteRequest_HttpGetImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
