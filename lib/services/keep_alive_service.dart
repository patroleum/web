// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:patroleum_dashboard/core/singleton/dio_singleton.dart';
import 'package:patroleum_dashboard/core/singleton/local_storage_singleton.dart';
import 'package:patroleum_dashboard/provider/internet/rest_provider_login.dart';

class KeepAliveService {
  // static const String baseUrl = Constants.baseUrl;
  static final KeepAliveService _instance = KeepAliveService._internal();

  factory KeepAliveService() => _instance;

  KeepAliveService._internal();

  Timer? _keepAliveTimer;
  Timer? _updateTimer;


  void start() {
    startKeepAlive();
  }

  void startKeepAlive() async {
    stopKeepAlive();

    _keepAliveTimer = Timer.periodic(const Duration(seconds: 22), (timer) => sendKeepAlive());
    _updateTimer = Timer.periodic(const Duration(minutes: 22), (timer) => _updateToken());
  }

  void stopKeepAlive() {
    _keepAliveTimer?.cancel();
    _keepAliveTimer = null;
    _updateTimer?.cancel();
    _updateTimer = null;
  }

  Future<void> sendKeepAlive() async {
    print("sendKeepAlive: Method started.");
    final idUser =  LocalStorageSingleton.getIdUser();
    final tokenDSS =  LocalStorageSingleton.getTokenDSS();
    final token =  LocalStorageSingleton.getToken();

    if (token == null) {
      print("sendKeepAlive: Token is null. Stopping keep-alive.");
      stopKeepAlive();
      return;
    }

    // final url = '$baseUrl/keepAlive/$idUser';
    final headers = {
      'Content-Type': 'application/json',
      'x-token': token,
    };
    final body = jsonEncode({'tokenDSS': tokenDSS});

    try {
      final response =
        await DioSingleton.dio.put(
          '/keepAlive/$idUser', 
          options: Options(headers: headers), 
          data: body
        );
      if (response.statusCode == 200) {
        print("sendKeepAlive: Keep alive successful.");
        final newTokenDSS = response.data['data']['token'];

        await LocalStorageSingleton.saveTokenDSS(newTokenDSS);

      } else {
        print('Keep alive failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("sendKeepAlive: Error occurred: $e");
    }
  }

  Future<void> _updateToken() async {

    final signature =  LocalStorageSingleton.getSignature();
    final tokenDSS =  LocalStorageSingleton.getTokenDSS();
    final token =  LocalStorageSingleton.getToken();

    if (token == null || signature == null || tokenDSS == null) {
      stopKeepAlive();
      return;
    }

    // final url = '$baseUrl/keepAlive/update/100';
    // final url = '$baseUrl/keepAlive/update/$idUser';
    final headers = {
      'Content-Type': 'application/json',
      'x-token': token,
    };
    final body = jsonEncode({'signature': signature, 'tokenDSS': tokenDSS});

    try {
      final response =
          await DioSingleton.dio.post(
            '/keepAlive/update/100', 
            options: Options(headers: headers), 
            data: body
          );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final newTokenDSS = data['token'];
        await LocalStorageSingleton.saveTokenDSS(newTokenDSS);
        print('Update token success: $newTokenDSS');
      } else {
        print('Update token failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Update token error: $e');
    }
  }
}

class TokenInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 500 || err.response?.statusCode == 401) {
      print('500 error received, attempting to refresh token');
      final refreshResponse = await RestLoginProvider().refreshToken();
      if (refreshResponse != null) {
        print('Token refreshed successfully in interceptor');
        return handler.resolve(await _retry(err.requestOptions));
      } else {
        print('Token refresh failed in interceptor');
      }
    }
    return handler.next(err);
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final newToken =  LocalStorageSingleton.getToken();
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'x-token': newToken,
      },
    );
    final client = DioSingleton.dio;
    return client.request(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }
}
