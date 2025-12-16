import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_ferrostar/src/rust/api/models.dart';
import 'package:flutter_ferrostar/src/rust/api/routing.dart';

/// Minimal HTTP executor that keeps networking within the plugin and avoids extra deps.
class FerrostarHttpRouteProvider {
  final ValhallaHttpRequestGenerator _generator;

  FerrostarHttpRouteProvider._(this._generator);

  static Future<FerrostarHttpRouteProvider> create({
    required String baseUrl,
    required String apiKey,
    String profile = 'auto',
  }) async {
    final generator = await ValhallaHttpRequestGenerator.newInstance(
      endpointUrl: '$baseUrl?api_key=$apiKey',
      profile: profile,
    );
    return FerrostarHttpRouteProvider._(generator);
  }

  Future<List<Route>> getRoutes({
    required UserLocation userLocation,
    required List<Waypoint> waypoints,
  }) async {
    final request = await _generator.generateRequest(
      userLocation: userLocation,
      waypoints: waypoints,
    );

    final bytes = await _execute(request);

    return parseOsrmResponse(response: bytes, polylinePrecision: 6);
  }

  Future<Uint8List> _execute(FerrostarRouteRequest request) async {
    final client = HttpClient();

    try {
      if (request is FerrostarRouteRequest_HttpPost) {
        final uri = Uri.parse(request.url);
        final req = await client.postUrl(uri);
        request.headers.forEach(req.headers.set);
        req.add(request.body);
        final resp = await req.close();
        final body = await resp.fold<List<int>>(
          <int>[],
          (a, b) => a..addAll(b),
        );
        if (resp.statusCode != 200) {
          throw HttpException('HTTP ${resp.statusCode}', uri: uri);
        }
        return Uint8List.fromList(body);
      } else if (request is FerrostarRouteRequest_HttpGet) {
        final uri = Uri.parse(request.url);
        final req = await client.getUrl(uri);
        request.headers.forEach(req.headers.set);
        final resp = await req.close();
        final body = await resp.fold<List<int>>(
          <int>[],
          (a, b) => a..addAll(b),
        );
        if (resp.statusCode != 200) {
          throw HttpException('HTTP ${resp.statusCode}', uri: uri);
        }
        return Uint8List.fromList(body);
      }

      throw UnsupportedError('Unknown request type');
    } finally {
      client.close(force: true);
    }
  }
}
